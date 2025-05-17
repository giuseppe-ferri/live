terraform {
  required_version = "~> 1.11.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

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

module "webserver_cluster" {
  source = "github.com/giuseppe-ferri/modules//services/webserver-cluster?ref=v0.0.6"

  cluster_name           = "webserver-prod"
  db_remote_state_bucket = "unique-name-bucket-jiow02"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type      = "t3.micro"
  min_size           = 1 # 2
  max_size           = 1 # 5
  enable_autoscaling = false

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}
