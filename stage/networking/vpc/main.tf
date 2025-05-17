module "vpc" {
  source = "github.com/giuseppe-ferri/modules//networking/vpc"
  environment = "stage"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"] # Two subnets
  availability_zones = ["us-east-2a", "us-east-2b"]   # Two AZs
}