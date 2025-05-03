provider "aws" {
  region = "us-east-2"
}

module "mysql_stage" {
  source = "../../../../modules/data-stores/mysql"
  
  db_name = "stage_db"
  db_username = var.db_username
  db_password = var.db_password
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "unique-name-bucket-jiow02"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "unique-name-dynamo-jiow02"
    encrypt        = true
  }
}