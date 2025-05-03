output "address" {
  description = "Connect to the database at this endpoint"
  value       = module.mysql_stage.address
}

output "port" {
  description = "The port the database is listening on"
  value       = module.mysql_stage.port
}

output "arn" {
  description = "The ARN of the database"
  value       = module.mysql_stage.arn
}