data "archive_file" "hello" {
  type        = "zip"
  source_dir  = "${path.module}/files/"
  output_path = "${path.module}/files/hello.zip"
}
data "archive_file" "dynamozip" {
  type        = "zip"
  source_dir  = "${path.module}/files/"
  output_path = "${path.module}/files/dynamo.zip"
}

data "archive_file" "get_stop_instance" {
  type        = "zip"
  source_dir  = "${path.module}/files/"
  output_path = "${path.module}/files/dynamo.zip"
}
resource "aws_lambda_function" "get_stop_instance" {
  filename         = data.archive_file.get_stop_instance.output_path
  function_name    = "get_stop_instance"
  role             = aws_iam_role.get_stop_instance.arn
  handler          = "get_stop_instance.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.hello.output_base64sha256

}
resource "aws_lambda_function" "get_value" {
  filename         = data.archive_file.hello.output_path
  function_name    = "get_value"
  role             = aws_iam_role.role_lambda_function.arn
  handler          = "hello.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.hello.output_base64sha256
  # depends_on = [
  #   aws_iam_role.role_lambda_function
  # ]
}
resource "aws_lambda_function" "dynamo" {
  filename      = data.archive_file.dynamozip.output_path
  function_name = "dynamo"
  role          = aws_iam_role.dynamodb-role.arn
  handler       = "dynamo.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.dynamozip.output_base64sha256
  # depends_on = [
  #   aws_iam_role.role_lambda_function
  # ]#
}
