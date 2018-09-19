# common variables
variable "availability_zone" {
  description = "The available zone to launch vswitch and cluster."
  default     = ""
}

variable "resource_group_name" {
  default = "tf-module-concourse"
}

# Image variables
variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  default     = "^ubuntu_16.*_64"
}

# Instance typs variables
variable "cpu_core_count" {
  description = "CPU core count is used to fetch instance types."
  default     = 1
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  default     = 2
}

# VPC variables
variable "vpc_id" {
  description = "A existing vpc id used to create vswitch and other resources."
  default     = ""
}

variable "vpc_name" {
  description = "The vpc name used to create a new vpc when vpc_id is not set. Default to variable `resource_group_name`"
  default     = ""
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  default     = "10.1.0.0/21"
}

# VSwitch variables
variable "vswitch_id" {
  description = "A existing vswitch id used to create swarm cluster."
  default     = ""
}

variable "vswitch_name" {
  description = "The vswitch name prefix used to create a new vswitch when vswitch_id is not set. Default to variable `resource_group_name`"
  default     = ""
}

variable "vswitch_cidr" {
  description = "The cidr block used to create a new vswitch when vswitch_id is not set."
  default     = "10.1.2.0/24"
}

# Cluster instance variables
variable "image_id" {
  description = "The image id used to launch cluster instances. Default from images datasource."
  default     = ""
}

variable "instance_type" {
  description = "The instance type used to launch cluster instances. Default from instance typs datasource."
  default     = ""
}

variable "data_disk_category" {
  description = "The data disk category used to launch cluster instances data disk."
  default     = "cloud_efficiency"
}

variable "data_disk_size" {
  description = "The data disk size used to launch cluster instances data disk."
  default     = "40"
}

variable "cluster_name" {
  description = "The cluster name. Default to variable `resource_group_name`"
  default     = ""
}

variable "ecs_password" {
  description = "The password of cluster instance."
  default     = "Abc12345"
}

variable "node_number" {
  description = "The number of launching cluster node."
  default     = 1
}

variable "cluster_cidr" {
  description = "The cidr block of cluster. It cannot conflict with VPC or Vswitch cidr block."
  default     = "172.20.0.0/16"
}

// Application variables
variable "app_name" {
  description = "The app resource name. Default to variable `resource_group_name`"
  default     = ""
}

variable "app_version" {
  description = "The app resource version."
  default     = "1.0"
}

variable "latest_image" {
  description = "Whether use the latest image while each update."
  default     = true
}

variable "blue_green" {
  description = "Whether use blue-green release while each update."
  default     = true
}

variable "confirm_blue_green" {
  description = "Confirm a application release which in blue_green."
  default     = true
}
