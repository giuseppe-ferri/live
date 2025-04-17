provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "unique-name-bucket-jiow02"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  # cluster_name = var.cluster_name
  # db_remote_state_bucket = var.db_remote_state_bucket
  # db_remote_state_key = var.db_remote_state_key

  instance_type = "t2.micro"
  min_size      = 1
  max_size      = 1
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}