resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/${var.project}/app"
  retention_in_days = 7
  tags = { project = var.project }
}
