# Network Variables
AWS_REGION   = "us-west-2"

vpc_cidr     = "10.10.0.0/20"
public_cidr  = ["10.10.1.0/24", "10.10.2.0/24","10.10.3.0/24"]
private_cidr = ["10.10.5.0/24", "10.10.6.0/24","10.10.7.0/24"]
vpc_region   = "us-west-2"
azs          = ["us-west-2a", "us-west-2b","us-west-2c"]

# Common Variables
prefix      = "tf"
region_name = "oregon"
service     = "jenkins"
stage       = "dev"
tags = {
  "Service" = "jenkins "
  "Stage"   = "dev"
}




#Service variables

# Instance Details
instance_type_cockroachdb = "t3.micro"
key_name = "terraform-instance-keypair"
aws_instances_count= 1
