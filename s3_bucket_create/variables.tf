# Input variable for AWS region
variable "aws_region" {
  description = "The AWS region where the S3 bucket will be created"
  type        = string
  default     = "us-west-2"
}
