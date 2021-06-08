
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = format("%s-%s-%s-%s-alb", var.prefix, var.region_name, var.stage, var.service)

  load_balancer_type = "application"

  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  subnets            = data.terraform_remote_state.network.outputs.public_subnets
  security_groups    = ["sg-edcd9784", "sg-edcd9785"]

  #access_logs = {
  #  bucket = "my-alb-logs"
  #}

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      targets = [
        {
          target_id = module.jenkins.id[0]
          port = 8080
        }
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      target_group_index = 0
    }
  ]

  
  tags = {
    Environment = "Dev"
  }
}
  
