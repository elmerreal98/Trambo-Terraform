provider "aws" {}

terraform {
  backend "s3" {
    bucket = "terraform-bucket-elmer"
    key    = "terraform/main.tfstate"
    region = "us-west-2"
  }
}

module "Roles" {
  source = "./modules/Rol"
}


module "Dynamo" {
  source = "./modules/Dynamo"
}

module "Lambda" {
  source = "./modules/Lambda"
  arn_rol_put = module.Roles.arn_rol_put
  arn_rol_edit = module.Roles.arn_rol_edit
  arn_rol_read = module.Roles.arn_rol_read
  arn_rol_delete = module.Roles.arn_rol_delete
  name_dynamo_table = module.Dynamo.name_dynamo_table
}

module "ApiGateway" {
  source = "./modules/ApiGateway"
  terraform-lambda_get_all-elmer =                module.Lambda.terraform-lambda_get_all-elmer
  terraform-lambda_get_all-elmer-function_name =  module.Lambda.terraform-lambda_get_all-elmer-function_name
  terraform-lambda_put-elmer                   =  module.Lambda.terraform-lambda_put-elmer
  terraform-lambda_put-elmer-function_name     =  module.Lambda.terraform-lambda_put-elmer-function_name
  terraform-lambda_delete-elmer                   =  module.Lambda.terraform-lambda_delete-elmer
  terraform-lambda_delete-elmer-function_name     =  module.Lambda.terraform-lambda_delete-elmer-function_name
  terraform-lambda_update-elmer                   =  module.Lambda.terraform-lambda_update-elmer
  terraform-lambda_update-elmer-function_name     =  module.Lambda.terraform-lambda_update-elmer-function_name
}