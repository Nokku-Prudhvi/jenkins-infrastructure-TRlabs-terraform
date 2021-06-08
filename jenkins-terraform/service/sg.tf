module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for cockroachdb"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id


  #Essential
  egress_rules             = ["all-all"]
  
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = 6
      description = "internal communication"
      cidr_blocks = "10.10.0.0/20"
    },
    {
      from_port   = 26257
      to_port     = 26257
      protocol    = 6
      description = "internal communication"
      cidr_blocks = "10.10.0.0/20"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = 6
      description = "cockroachdb from terraform"
      cidr_blocks = "54.184.140.8/32"
    },
    {
      from_port   = 26257
      to_port     = 26257
      protocol    = 6
      description = "from terraform"
      cidr_blocks = "54.184.140.8/32"
    },
{
      from_port   = 8080
      to_port     = 8080
      protocol    = 6
      description = "from terraform"
      cidr_blocks = "54.184.140.8/32"
    }
  ]
  /*

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = data.terraform_remote_state.service-const.outputs.admin_alb_sg_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1
  */

  tags                     = var.tags #Use common_vars.tf file 
}

