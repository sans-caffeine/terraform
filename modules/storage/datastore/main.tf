resource "aws_dynamodb_table" "table" {
  name           = "${var.env}-${var.name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_iam_policy" "policy" {
    name   = "${var.env}_policy_for_${var.name}_table"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:UpdateItem",
        "dynamodb:Scan"
      ],
      "Resource": "${aws_dynamodb_table.table.arn}"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "datastore_role" {
  role       = var.role.name
  policy_arn = aws_iam_policy.policy.arn
}