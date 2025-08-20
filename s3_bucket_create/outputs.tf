# Output the S3 bucket name
output "bucket" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.taco_wagon.bucket
}

# Output the AWS region used
output "region" {
  description = "The AWS region where the bucket was created"
  value       = var.aws_region
}
