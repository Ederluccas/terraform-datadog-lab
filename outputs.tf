output "instance_public_ip" {
  value = aws_instance.app.public_ip
}

output "datadog_integration_id" {
  value = datadog_integration_aws.this.id
}

output "lambda_forwarder_name" {
  value = aws_lambda_function.datadog_forwarder.function_name
}
