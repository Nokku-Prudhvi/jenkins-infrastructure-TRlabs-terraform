# Define an Amazon Linux AMI.
data "aws_ami" "amazon_linux_ami" {
  most_recent = true

  owners = [
    "amazon"
    ]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }

}


module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"

  #essential [required for Infra Governance]
  name                    = format("%s-%s-%s-%s-host", var.prefix, var.region_name, var.stage, var.service)
  instance_count          = var.aws_instances_count  #"3"

  ami                     = data.aws_ami.amazon_linux_ami.id
  instance_type           = var.instance_type_jenkins
  key_name                = var.key_name
  monitoring              = false

  vpc_security_group_ids  = [module.jenkins_sg.this_security_group_id]
  subnet_ids              = data.terraform_remote_state.network.outputs.public_subnets

  # set instance profile to give EC2 read only permissions
  #iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile_admin.name

  # set user data for configuring server

  user_data      =   file("scripts/jenkins_userdata")
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 30
    }
  ]
  tags                    = var.tags
}

