# This bucket contains the backend code
resource "aws_s3_bucket" "backend" {
  bucket = "${var.name_prefix}backend"
}

# Implements the Lambda API processing requests from the web
module "backend_api" {
  source    = "../aws_lambda_api"
  providers = { aws.us_east_1 = aws.us_east_1 } # this alias is needed because ACM is only available in the "us-east-1" region

  name_prefix        = var.name_prefix
  api_domain         = "api.dev.vigilant-sniffle.com"
  function_s3_bucket = aws_s3_bucket.backend.id
  function_zipfile   = "backend-lambda.zip"

  function_env_vars = {
    ENV_NAME = "dev"
  }
}