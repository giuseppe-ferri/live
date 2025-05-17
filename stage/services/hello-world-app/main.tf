terraform {
  required_version = "~> 1.12.0"
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

module "hello_world_app" {
  source = "git@github.com:giuseppe-ferri/modules.git//services/hello-world-app?ref=v0.1.0"

  server_text = "New server text"
  environment = "stage"
  cluster_name = "hello-world-app-stage"
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key = var.db_remote_state_key

  instance_type = "t2.micro"
  min_size      = 1 # 1
  max_size      = 1 # 2
  enable_autoscaling = false
  ami = data.aws_ami.ubuntu.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
