variable "region" {
  default = "us-west-2"
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  description = "The EC2 instance type to use for the web server"
  type        = string
  default     = "t3.micro"
}

variable "network_info" {
  description = "A map of networking configuration values for the VPC and subnets"
  type = object({
    vpc_name             = string
    vpc_cidr             = string
    public_subnets       = map(string)
    map_public_ip        = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    enable_dns_support   = optional(bool, true)
  })
}

variable "sg_port_http" {
  description = "The port number for HTTP access in the security group"
  type        = number
  default     = 80
}
