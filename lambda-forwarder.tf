# Package the lambda code from lambda/ directory
data "archive_file" "datadog_forwarder" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/dist/datadog_forwarder.zip"
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.project}-lambda-exec"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_logs_policy" {
  name = "${var.project}-lambda-logs-policy"
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "datadog_forwarder" {
  filename         = data.archive_file.datadog_forwarder.output_path
  function_name    = "${var.project}-datadog-forwarder"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "forwarder.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30

  environment {
    variables = {
      DD_API_KEY = aws_ssm_parameter.datadog_api_key.value
      DD_SITE    = "datadoghq.com"
    }
  }
}

# Permission for CloudWatch Logs to invoke the Lambda
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.datadog_forwarder.function_name
  principal     = "logs.${data.aws_caller_identity.current.account_id}.amazonaws.com"
  # source_arn = aws_cloudwatch_log_group.app_logs.arn # optional
}

# Subscribe the app log group to the Lambda
resource "aws_cloudwatch_log_subscription_filter" "app_to_forwarder" {
  name            = "app-to-datadog-forwarder"
  log_group_name  = aws_cloudwatch_log_group.app_logs.name
  destination_arn = aws_lambda_function.datadog_forwarder.arn
  filter_pattern  = "" # all logs
}
