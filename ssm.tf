resource "aws_ssm_parameter" "datadog_api_key" {
  name        = "/datadog/api_key"
  description = "Datadog API Key (secure)"
  type        = "SecureString"
  value       = var.datadog_api_key
  overwrite   = true
  tags = { project = var.project }
}
