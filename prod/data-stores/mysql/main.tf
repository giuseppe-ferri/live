provider "aws" {
  region = "us-east-2"
  alias  = "primary"

  # Tags to apply to all AWS resources by default
  default_tags {
    tags = {
      Owner     = "team-devops"
      ManagedBy = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  alias  = "replica"

  # Tags to apply to all AWS resources by default
  default_tags {
    tags = {
      Owner     = "team-devops"
      ManagedBy = "Terraform"
    }
  }
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name     = "prod_db"
  db_username = var.db_username
  db_password = var.db_password

  # Must be enabled to support replication
  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  # Make this a replica of the primary
  replicate_source_db = module.mysql_primary.arn
}

# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket = "unique-name-bucket-jiow02"
#     key    = "prod/data-stores/mysql/terraform.tfstate"
#     region = "us-east-2"

#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "unique-name-dynamo-jiow02"
#     encrypt        = true
#   }
# }