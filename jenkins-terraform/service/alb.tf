resource "aws_lb" "cockroachdb" {
  name               = format("%s-%s-%s-%s-nlb", var.prefix, var.region_name, var.stage, var.service)
  internal           = false
  load_balancer_type = "network"
  subnets            = data.terraform_remote_state.network.outputs.public_subnets

  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_listener" "cockroachdb" {
  load_balancer_arn = aws_lb.cockroachdb.arn
  port              = "26257"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cockroachdb.arn
  }
}

resource "aws_lb_target_group" "cockroachdb" {
  name     = format("%s-%s-%s-%s-tg", var.prefix, var.region_name, var.stage, var.service)
  port     = 26257
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
}

resource "aws_lb_target_group_attachment" "cockroachdb" {
  count      = var.aws_instances_count
  target_group_arn = aws_lb_target_group.cockroachdb.arn
  target_id        = module.cockroachdb.id[count.index]
  port             = 26257
}

