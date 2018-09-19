Alicloud Swarm Cluster deployment Concourse Terraform Module
terraform-alicloud-concourse
=====================================================================

A terraform module supports to create a swarm cluster and deploy a concourse application using compose template on it.

These types of the module resource are supported:

- [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
- [Subnet](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
- [Security Group Rule](https://www.terraform.io/docs/providers/alicloud/r/security_group_rule.html)
- [Swarm Cluster](https://www.terraform.io/docs/providers/alicloud/r/cs_swarm.html)
- [Container Application](https://www.terraform.io/docs/providers/alicloud/r/cs_application.html)

**Note:** From version 3.0.0, the module `aliyun/concourse/alicloud` will be deprecated and use new module `terraform-alicloud-modules/concourse/alicloud` instead.

----------------------

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

    ```
    module "concourse" {
        source = "terraform-alicloud-modules/concourse/alicloud"

        region = "cn-beijing"

        vpc_name = "tf-concourse-vpc"
        vswitch_name = "tf-concourse-vsw"

        cluster_name = "tf-for-concourse"
        node_number = 1

        app_name = "my-first-concourse"
        version = "1.0"
    }
    ```

2. Setting values for the following variables:

    through environment variables

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION


**Note:** `cluster_cidr`: The swarm cluster cidr block. It cannot be equals to vpc's or vswitch's and cannot be in them. If vpc's cidr block is `172.16.XX.XX/XX`,
          it had better to `192.168.XX.XX/XX` or `10.XX.XX.XX/XX`

**Output:** After the module finished, you can use address: `<cluster-node-eip>:8080` to access your Concourse CI.

Conditional creation
--------------------
Sometimes you need to using existing VSwitch not creating a new VSwitch resources conditionally. And the solution is to specify argument vswitch_id.

### It will not create a new VPC and VSwitch.
module "concourse" {
    source = "terraform-alicloud-concourse"

    vswitch_id = "vsw-abc12345"

    cluster_name = "tf-for-concourse"
    node_number = 1

    app_name = "my-first-concourse"
    version = "1.1"
}

Terraform version
-----------------
Terraform version 0.11.0 or newer and Provider version 1.9.0 or newer are required for this module to work.

Authors
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com)

License
-------
Mozilla Public License 2.0. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/)


