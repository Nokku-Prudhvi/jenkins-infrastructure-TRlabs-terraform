variable "AWS_REGION" {}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.10.0.0/16"
}
variable "public_cidr" {
  description = "list of public subnets to be created"
}
variable "private_cidr" {
  description = "list of private subnets to be created"
}
variable "prefix" {}
variable "region_name" {}
variable "service" {}
variable "stage" {}
variable "vpc_region" {}
variable "azs" {}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
}


# Service Variables
variable "instance_type_cockroachdb"{
  description = "Instance Type for Admin EC2"
}

variable "key_name"{
  description = "AWS Key Namee"
}

variable "aws_instances_count"{
  description = "aws_instances_count"
}
