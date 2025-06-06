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

module "mysql_stage" {
  source = "../../../../modules/data-stores/mysql"
  
  db_name = "stage_db"
  db_username = var.db_username
  db_password = var.db_password
  # instance_class = "db.t3.micro"
  # allocated_storage = 20
  # engine = "mysql"
  # engine_version = "8.0"
  # multi_az = false
  # skip_final_snapshot = true
  backup_retention_period = 0
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