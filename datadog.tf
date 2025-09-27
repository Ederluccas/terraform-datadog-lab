resource "datadog_integration_aws" "this" {
  account_id = data.aws_caller_identity.current.account_id
  role_name  = aws_iam_role.datadog_integration_role.name
  host_tags  = ["project:${var.project}"]
}
