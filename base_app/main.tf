provider "aws" {
  region = var.region
}

## Networking Resources

data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = var.network_info.vpc_name
  cidr = var.network_info.vpc_cidr

  azs                     = slice(data.aws_availability_zones.available.names, 0, length(keys(var.network_info.public_subnets)))
  public_subnets          = values(var.network_info.public_subnets)
  public_subnet_names     = keys(var.network_info.public_subnets)
  enable_dns_hostnames    = var.network_info.enable_dns_hostnames
  enable_dns_support      = var.network_info.enable_dns_support
  map_public_ip_on_launch = var.network_info.map_public_ip
}

## EC2 Instance resources

resource "aws_security_group" "main" {
  name   = "nacho-brigade-sg"
  vpc_id = module.networking.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = var.sg_port_http
    to_port     = var.sg_port_http
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "web" {
  ami                         = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type               = var.instance_type
  subnet_id                   = module.networking.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.main.id]
  user_data_replace_on_change = true
  user_data = templatefile("${path.module}/templates/user_data.sh",
    {
      environment = var.environment
  })

  tags = {
    Name = "nacho-brigade-web-${var.environment}"
  }
}
