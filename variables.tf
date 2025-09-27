variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "tf-datadog-lab"
}

variable "datadog_api_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "env_vars" {
  type    = map(string)
  default = {}
}
