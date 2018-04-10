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

//output "cluster_node_ids" {
//  description = "List IDs of cluster nodes."
//  value = "${chunklist(alicloud_cs_swarm.default.nodes, 1)[0].id)}"
//}
//
////output "cluster_node_private_ips" {
////  description = "List private ips of cluster nodes."
////  value = ["${lookup(alicloud_cs_swarm.default.nodes.*, "private_ip")}"]
////}
//
//output "cluster_node_private_eips" {
//  description = "List elastic ips of cluster nodes."
////  count = "${var.node_number}"
//  value = ["${alicloud_cs_swarm.default.nodes}"]
////  lookup(data.alicloud_zones.default.zones[format("%d", length(data.alicloud_zones.default.zones) < 2 ? 0 : count.index%length(data.alicloud_zones.default.zones))], "id")}
//}

// Application
output "app_version" {
  description = "The current version of the application."
  value = "${alicloud_cs_application.concourse.version}"
}


output "app_services" {
  description = "List names of services' in the application."
  value = "${alicloud_cs_application.concourse.services}"
}
