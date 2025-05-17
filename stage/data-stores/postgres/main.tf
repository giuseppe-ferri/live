module "postgres_stage" {
    source = "github.com/giuseppe-ferri/modules//data-stores/postgres"
    environment = "stage"
    db_name = "stage-db"
    db_username = var.db_username
    db_password = var.db_password
    instance_class = "dv.t3.micro"
    allocated_storage = 20
    security_group_id = module.vpc.security_group_id
    db_subnet_group_name = module.vpc.db_subnet_group_name
}