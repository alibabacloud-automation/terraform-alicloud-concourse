provider "alicloud" {
//  access_key = "${var.alicloud_access_key}"
//  secret_key = "${var.alicloud_secret_key}"
  region = "${var.region}"
}

data "alicloud_instance_types" "main" {
  cpu_core_count = "${var.cpu_core_count}"
  memory_size = "${var.memory_size}"
}

data "alicloud_zones" "main" {
  available_resource_creation = "VSwitch"
  available_instance_type = "${data.alicloud_instance_types.main.instance_types.0.id}"
}

data "alicloud_images" main {
  most_recent = true
  name_regex = "${var.image_name_regex}"
}

resource "alicloud_vpc" "default" {
  count = "${var.vswitch_id == "" && var.vpc_id == "" ? 1 : 0}"
  name = "${var.vpc_name == "" ? var.resource_group_name : var.vpc_name}"
  cidr_block = "${var.vpc_cidr}"
}

resource "alicloud_vswitch" "default" {
  count = "${var.vswitch_id == "" ? 1 : 0}"
  vpc_id = "${var.vpc_id == "" ? join("", alicloud_vpc.default.*.id) : var.vpc_id}"
  cidr_block = "${var.vswitch_cidr}"
  availability_zone = "${var.availability_zone == ""? data.alicloud_zones.main.zones.0.id : var.availability_zone}"
  name = "${var.vswitch_name == "" ? var.resource_group_name : var.vswitch_name}"
}

resource "alicloud_security_group_rule" "8080" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "intranet"
  policy = "accept"
  port_range = "8080/8080"
  priority = 1
  security_group_id = "${alicloud_cs_swarm.default.security_group_id}"
  cidr_ip = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "22" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "intranet"
  policy = "accept"
  port_range = "22/22"
  priority = 1
  security_group_id = "${alicloud_cs_swarm.default.security_group_id}"
  cidr_ip = "0.0.0.0/0"
}

resource "alicloud_cs_swarm" "default" {
  password = "${var.ecs_password}"
  instance_type = "${data.alicloud_instance_types.main.instance_types.0.id}"
  name = "${var.cluster_name == "" ? var.resource_group_name : var.cluster_name}"
  node_number = "${var.node_number}"
  disk_category = "${var.data_disk_category}"
  disk_size = "${var.data_disk_size}"
  cidr_block = "${var.cluster_cidr}"
  image_id = "${var.image_id == "" ? data.alicloud_images.main.images.0.id : var.image_id}"
  vswitch_id = "${var.vswitch_id == "" ? join("", alicloud_vswitch.default.*.id) : var.vswitch_id}"
}

resource "null_resource" "nodes" {
  connection {
    host = "${alicloud_cs_swarm.default.nodes.0.eip}"
    type     = "ssh"
    user     = "root"
    password = "${var.ecs_password}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p keys/web keys/worker",

      "ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''",
      "ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''",
      "ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''",

      "cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys",
      "cp ./keys/web/tsa_host_key.pub ./keys/worker",
    ]
  }

  depends_on = ["alicloud_cs_swarm.default", "alicloud_security_group_rule.8080", "alicloud_security_group_rule.22"]
}
resource "alicloud_cs_application" "concourse" {
  cluster_name = "${alicloud_cs_swarm.default.name}"
  name = "${var.app_name == "" ? var.resource_group_name : var.app_name}"
  version = "${var.app_version}"
  template = "${file("concourse.yml")}"
  description = "terraform deploy consource"
  latest_image = "${var.latest_image}"
  blue_green = "${var.blue_green}"
  blue_green_confirm = "${var.confirm_blue_green}"
  environment = {
    CONCOURSE_EXTERNAL_URL = "${alicloud_cs_swarm.default.nodes.0.eip}:8080"
  }
  depends_on = ["null_resource.nodes"]
}
