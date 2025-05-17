output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "db_subnet_group_name" {
  value = module.vpc.db_subnet_group_name
}

output "security_group_id" {
  value = module.vpc.security_group_id
}