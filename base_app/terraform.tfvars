region        = "us-west-2"
instance_type = "t3.micro"
network_info = {
  vpc_name = "nacho-brigade-vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnets = {
    subnet_1 = "10.0.0.0/24"
  }
}
sg_port_http = 80