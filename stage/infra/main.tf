provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Owner     = "team-devops"
      ManagedBy = "Terraform"
    }
  }
}

module "vpc" {
  source = "github.com/giuseppe-ferri/modules//networking/vpc"
  environment = "stage"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-2a", "us-east-2b"]
  allowed_cidr_blocks = ["10.0.0.0/16"]
}

module "postgres_stage" {
  source = "github.com/giuseppe-ferri/modules//data-stores/postgres"
  environment = "stage"
  db_name = "stage_db"
  db_username = var.db_username
  db_password = var.db_password
  instance_class = "db.t3.micro"
  allocated_storage = 20
  security_group_id = module.vpc.security_group_id
  db_subnet_group_name = module.vpc.db_subnet_group_name
}

output "db_endpoint" {
  value = module.postgres_stage.db_endpoint
}