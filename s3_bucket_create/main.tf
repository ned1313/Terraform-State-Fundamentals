# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create S3 bucket with versioning and encryption
resource "aws_s3_bucket" "taco_wagon" {
  bucket_prefix  = "taco-wagon"
  force_destroy  = true

  tags = {
    Environment = "terraform-demo"
    Purpose     = "State storage"
  }
}

# Configure versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "taco_wagon_versioning" {
  bucket = aws_s3_bucket.taco_wagon.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Configure server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "taco_wagon_encryption" {
  bucket = aws_s3_bucket.taco_wagon.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "taco_wagon_pab" {
  bucket = aws_s3_bucket.taco_wagon.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
