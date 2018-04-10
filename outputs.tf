// Output VPC
output "vpc_id" {
  description = "ID of the VPC."
  value = "${alicloud_cs_swarm.default.vpc_id}"
}

output "vswitch_id" {
  description = "ID of the VSwitch."
  value = "${alicloud_cs_swarm.default.vswitch_id}"
}

// Output Swarm resource
output "cluster_id" {
  description = "ID of the swarm cluster."
  value = "${alicloud_cs_swarm.default.id}"
}

output "cluster_slb_id" {
  description = "ID of the load balancer used to deploy swarm cluster."
  value = "${alicloud_cs_swarm.default.slb_id}"
}

// Output security group
output "security_group_id" {
  description = "ID of the Security Group used to deploy swarm cluster."
  value = "${alicloud_cs_swarm.default.security_group_id}"
}

output "cluster_nodes" {
  description = "List nodes of cluster."
  value = ["${alicloud_cs_swarm.default.nodes}"]
}

// Application
output "app_version" {
  description = "The current version of the application."
  value = "${alicloud_cs_application.concourse.version}"
}


output "app_services" {
  description = "List names of services' in the application."
  value = "${alicloud_cs_application.concourse.services}"
}
