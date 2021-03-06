provider "aws" {
  region = var.region
}

# terraform {
#   # Terraform can store it's state to s3 bucket. Create one and upadte the variables here.
#   backend "s3" {
#     bucket = "example-terraform-state"
#     key = "terraform/staging/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

module "vpc" {
  source = "./modules/vpc"
  # environment = var.env
  # tag = var.tag
  # enable_nat_gateway = false
  # nat_instance_ami = "${lookup(var.nat_instance_ami, var.region)}"
  # bastion_host_ami = "${lookup(var.bastion_host_ami, var.region)}"
  # key_name = "example_ssh_key_to_staging"
  # availability_zones = ["${var.az}"]
}

# module "mongodb" {
#   source = "./modules/mongodb"
#   environment = "${var.env}"
#   key_name = "example_ssh_key_to_staging"
#   ebs_volume_size = 8
#   replicaset_name = "no_replica_set"
#   availability_zones = ["${var.az}"]
#   vpc_id = "${module.vpc.vpc_id}"
#   security_group_bastion = "${module.vpc.security_group_bastion}"
#   subnet_ids = "${module.vpc.private_subnets}"
#   ami = "${lookup(var.mongodb_ami, var.region)}"
#   arbiter_ami = "${lookup(var.mongodb_arbiter_ami, var.region)}"
# }