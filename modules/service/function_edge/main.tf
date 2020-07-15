provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

data "external" "package" {
  program = ["../../scripts/zip-function-edge.sh", var.name]
}

resource "aws_lambda_function" "lambda_edge" {
	filename      = "../../build/${var.name}.zip"
  function_name = "${var.env}-${var.name}"
  role          = var.role.arn
  handler       = "bundle.handler"
	publish = true

	source_code_hash = filebase64sha256("../../build/${var.name}.zip")

  runtime = "nodejs10.x"
	memory_size = 128
	timeout = 5

	provider = aws.us-east-1
}