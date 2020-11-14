resource "aws_dynamodb_table" "terraform-dynamotable-pacientes" {
  name           = "Pacientes"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "Nombre"

  attribute {
    name = "Nombre"
    type = "S"
  }

  tags = {
    Name        = "terraform-dynamotable-pacientes"
    Environment = "production"
  }
}

output "name_dynamo_table" {
  value = aws_dynamodb_table.terraform-dynamotable-pacientes.id
}