terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "datadog" {
  api_key = var.datadog_api_key != "" ? var.datadog_api_key : (lookup(var.env_vars, "DATADOG_API_KEY", ""))
  app_key = var.datadog_app_key != "" ? var.datadog_app_key : (lookup(var.env_vars, "DATADOG_APP_KEY", ""))
}

data "aws_caller_identity" "current" {}
