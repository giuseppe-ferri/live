provider "aws" {
  region = "us-east-2"

  # Tags to apply to all AWS resources by default
  default_tags {
    tags = {
      Owner     = "team-devops"
      ManagedBy = "Terraform"
    }
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "unique-name-bucket-jiow02"

  force_destroy = true
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = false# default: true
  }
}

# Enable versioning so you can see the full revision history of your state files
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Use DynamoDB for locking with Terraform
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "unique-name-dynamo-jiow02"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"


  attribute {
    name = "LockID"
    type = "S"
  }
}

# terraform {
#   backend "s3" {
#     # Replace this with your bucket table name!
#     bucket = "unique-name-bucket-jiow02"
#     key    = "global/s3/terraform.tfstate"
#     region = "us-east-2"

#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "unique-name-dynamo-jiow02"
#     encrypt        = true
#   }
# }
