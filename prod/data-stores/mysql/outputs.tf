output "address" {
  description = "Connect to the production database at this endpoint"
  value = aws_db_instance.example.address
}

output "port" {
  description = "The port the production database is listening on"
  value = aws_db_instance.example.port
}