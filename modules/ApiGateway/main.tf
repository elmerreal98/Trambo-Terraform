variable "terraform-lambda_get_all-elmer" {
  type = string
}
variable "terraform-lambda_get_all-elmer-function_name" {
  type = string
}

variable "terraform-lambda_put-elmer" {
  type = string
}
variable "terraform-lambda_put-elmer-function_name" {
  type = string
}

variable "terraform-lambda_delete-elmer" {
  type = string
}
variable "terraform-lambda_delete-elmer-function_name" {
  type = string
}
variable "terraform-lambda_update-elmer" {
  type = string
}
variable "terraform-lambda_update-elmer-function_name" {
  type = string
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name = "api_gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "resource"
}

########################  GET  ###########################################3

resource "aws_api_gateway_method" "method" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "GET" #
   authorization = "NONE"
 }


  resource "aws_api_gateway_method_response" "exampleMethodResponse" {
    rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
    resource_id = "${aws_api_gateway_resource.proxy.id}"
    http_method = "${aws_api_gateway_method.method.http_method}" #
    status_code = "200"

    response_models = {
         "application/json" = "Empty"
    }
}

resource "aws_api_gateway_integration_response" "lambda-getResponse" {
   depends_on = [
     aws_api_gateway_integration.lambda-get
   ]
   rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
   resource_id = "${aws_api_gateway_resource.proxy.id}"
   http_method = "${aws_api_gateway_method.method.http_method}" #
   status_code = "${aws_api_gateway_method_response.exampleMethodResponse.status_code}" #

   response_templates = {
       "application/json" = ""
   } 
}

 resource "aws_api_gateway_integration" "lambda-get" {
   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   resource_id = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.method.http_method #

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.terraform-lambda_get_all-elmer #
}

  resource "aws_lambda_permission" "apigw_get" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = var.terraform-lambda_get_all-elmer-function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/GET/resource"
 }
#######################################################################################

###########################  PUT  #####################################################
resource "aws_api_gateway_method" "method_put" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "PUT" #
   authorization = "NONE"
 }




  resource "aws_api_gateway_method_response" "PutMethodResponse" {
    rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
    resource_id = "${aws_api_gateway_resource.proxy.id}"
    http_method = "${aws_api_gateway_method.method_put.http_method}" #
    status_code = "200"

    response_models = {
         "application/json" = "Empty"
    }
}

resource "aws_api_gateway_integration_response" "lambda-putResponse" {
   depends_on = [
     aws_api_gateway_integration.lambda-put
   ]
   rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
   resource_id = "${aws_api_gateway_resource.proxy.id}"
   http_method = "${aws_api_gateway_method.method_put.http_method}" #
   status_code = "${aws_api_gateway_method_response.PutMethodResponse.status_code}" #

   response_templates = {
       "application/json" = ""
   } 
}

 resource "aws_api_gateway_integration" "lambda-put" {
   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   resource_id = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.method_put.http_method #

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.terraform-lambda_put-elmer #
}

  resource "aws_lambda_permission" "apigw_put" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = var.terraform-lambda_put-elmer-function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/PUT/resource"
 }
###########################################################################################
###########################  DELETE  #####################################################
resource "aws_api_gateway_method" "method_delete" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "DELETE" #
   authorization = "NONE"
 }




  resource "aws_api_gateway_method_response" "DeleteMethodResponse" {
    rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
    resource_id = "${aws_api_gateway_resource.proxy.id}"
    http_method = "${aws_api_gateway_method.method_delete.http_method}" #
    status_code = "200"

    response_models = {
         "application/json" = "Empty"
    }
}

resource "aws_api_gateway_integration_response" "lambda-deleteResponse" {
   depends_on = [
     aws_api_gateway_integration.lambda-delete
   ]
   rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
   resource_id = "${aws_api_gateway_resource.proxy.id}"
   http_method = "${aws_api_gateway_method.method_delete.http_method}" #
   status_code = "${aws_api_gateway_method_response.DeleteMethodResponse.status_code}" #

   response_templates = {
       "application/json" = ""
   } 
}

 resource "aws_api_gateway_integration" "lambda-delete" {
   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   resource_id = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.method_delete.http_method #

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.terraform-lambda_delete-elmer #
}

  resource "aws_lambda_permission" "apigw_delete" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = var.terraform-lambda_delete-elmer-function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/DELETE/resource"
 }
 ######################################################################################
 ###########################  UPDATE  #####################################################
resource "aws_api_gateway_method" "method_update" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "PATCH" #
   authorization = "NONE"
 }




  resource "aws_api_gateway_method_response" "UpdateMethodResponse" {
    rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
    resource_id = "${aws_api_gateway_resource.proxy.id}"
    http_method = "${aws_api_gateway_method.method_update.http_method}" #
    status_code = "200"

    response_models = {
         "application/json" = "Empty"
    }
}

resource "aws_api_gateway_integration_response" "lambda-updateResponse" {
     depends_on = [
     aws_api_gateway_integration.lambda_update
   ]
   rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
   resource_id = "${aws_api_gateway_resource.proxy.id}"
   http_method = "${aws_api_gateway_method.method_update.http_method}" #
   status_code = "${aws_api_gateway_method_response.UpdateMethodResponse.status_code}" #

   response_templates = {
       "application/json" = ""
   } 
}

 resource "aws_api_gateway_integration" "lambda_update" {
   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   resource_id = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.method_update.http_method #

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.terraform-lambda_update-elmer #
}

  resource "aws_lambda_permission" "apigw_update" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = var.terraform-lambda_update-elmer-function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/PATCH/resource"
 }
 ######################################################################################
resource "aws_api_gateway_deployment" "test" {
   depends_on = [
     aws_api_gateway_integration.lambda-get,
     aws_api_gateway_integration.lambda-put,
     aws_api_gateway_integration.lambda-delete,
     aws_api_gateway_integration.lambda_update
   ]

   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   stage_name  = "test"
 }




 output "base_url" {
  value = aws_api_gateway_deployment.test.invoke_url
}