
provider "archive" {}
variable "arn_rol_put" {
  type = string
}
variable "arn_rol_edit" {
  type = string
}
variable "arn_rol_read" {
  type = string
}
variable "arn_rol_delete" {
  type = string
}
variable "name_dynamo_table" {
  type = string
}
###############################################
data "archive_file" "zip_get_all" {
  type        = "zip"
  source_file = "${path.module}/get_all.js"
  output_path = "${path.module}/get_all.zip"
}

resource "aws_lambda_function" "terraform-lambda_get_all-elmer" {
  function_name = "terraform-lambda_get_all-elmer"

  filename         = data.archive_file.zip_get_all.output_path
  source_code_hash = data.archive_file.zip_get_all.output_base64sha256

  handler = "get_all.handler"
  runtime = "nodejs12.x"

  
  role    = var.arn_rol_read

   environment {
    variables = {
      table = var.name_dynamo_table
    }
  }
}
##############################################################
data "archive_file" "zip_put" {
  type        = "zip"
  source_file = "${path.module}/put.js"
  output_path = "${path.module}/put.zip"
}

resource "aws_lambda_function" "terraform-lambda_put-elmer" {
  function_name = "terraform-lambda_put-elmer"

  filename         = data.archive_file.zip_put.output_path
  source_code_hash = data.archive_file.zip_put.output_base64sha256

  handler = "put.handler"
  runtime = "nodejs12.x"

  
  role    = var.arn_rol_put

   environment {
    variables = {
      table = var.name_dynamo_table
    }
  }
}
##############################################################
data "archive_file" "zip_delete" {
  type        = "zip"
  source_file = "${path.module}/delete.js"
  output_path = "${path.module}/delete.zip"
}

resource "aws_lambda_function" "terraform-lambda_delete-elmer" {
  function_name = "terraform-lambda_delete-elmer"

  filename         = data.archive_file.zip_delete.output_path
  source_code_hash = data.archive_file.zip_delete.output_base64sha256

  handler = "delete.handler"
  runtime = "nodejs12.x"

  
  role    = var.arn_rol_delete

   environment {
    variables = {
      table = var.name_dynamo_table
    }
  }
}
##############################################################
data "archive_file" "zip_update" {
  type        = "zip"
  source_file = "${path.module}/update.js"
  output_path = "${path.module}/update.zip"
}

resource "aws_lambda_function" "terraform-lambda_update-elmer" {
  function_name = "terraform-lambda_update-elmer"

  filename         = data.archive_file.zip_update.output_path
  source_code_hash = data.archive_file.zip_update.output_base64sha256

  handler = "update.handler"
  runtime = "nodejs12.x"

  
  role    = var.arn_rol_edit

   environment {
    variables = {
      table = var.name_dynamo_table
    }
  }
}



output "terraform-lambda_get_all-elmer" {
  value = aws_lambda_function.terraform-lambda_get_all-elmer.invoke_arn
}

output "terraform-lambda_get_all-elmer-function_name" {
  value = aws_lambda_function.terraform-lambda_get_all-elmer.function_name
}

output "terraform-lambda_put-elmer" {
  value = aws_lambda_function.terraform-lambda_put-elmer.invoke_arn
}

output "terraform-lambda_put-elmer-function_name" {
  value = aws_lambda_function.terraform-lambda_put-elmer.function_name
}

output "terraform-lambda_delete-elmer" {
  value = aws_lambda_function.terraform-lambda_delete-elmer.invoke_arn
}

output "terraform-lambda_delete-elmer-function_name" {
  value = aws_lambda_function.terraform-lambda_delete-elmer.function_name
}

output "terraform-lambda_update-elmer" {
  value = aws_lambda_function.terraform-lambda_update-elmer.invoke_arn
}

output "terraform-lambda_update-elmer-function_name" {
  value = aws_lambda_function.terraform-lambda_update-elmer.function_name
}