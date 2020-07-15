data "external" "function_zip" {
  program = ["../../scripts/zip-function.sh", var.name]
}

resource "aws_lambda_function" "lambda" {
  filename      = "../../build/${var.name}.zip"
  function_name = "${var.env}-${var.name}"
  role          = var.role.arn
  handler       = "bundle.handler"

  source_code_hash = filebase64sha256("../../build/${var.name}.zip")
  runtime = "nodejs10.x"
  memory_size = 512
  timeout = 10

  environment {
    variables = {
      environment = var.env
    }
  }
}