provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"

  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "unique-name-bucket-jiow02"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "unique-name-dynamo-jiow02"
    encrypt        = true
  }
}