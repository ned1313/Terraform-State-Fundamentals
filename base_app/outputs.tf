output "ec2_public_dns" {
  description = "The public DNS name of the EC2 web instance"
  value = aws_instance.web.public_dns
}

output "public_subnet_ids" {
  description = "The list of IDs for the public subnets created in the VPC"
  value = module.networking.public_subnets
}

output "vpc_id" {
  description = "The ID of the VPC created"
  value = module.networking.vpc_id
}
