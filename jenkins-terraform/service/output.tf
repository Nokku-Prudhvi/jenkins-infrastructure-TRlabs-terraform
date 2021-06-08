output "alb_dns" {
	description = "The ID of the VPC"
	value = aws_lb.jenkins.dns_name

}

output "ec2_id" {
  description = "The ID of the VPC"
  value       = module.jenkins.id
}

output "ec2_public_ips" {
  description = "The ID of the VPC"
  value       = module.jenkins.public_ip
}


output "ec2_private_ips" {
  description = "The ID of the VPC"
  value       = module.jenkins.private_ip
}


