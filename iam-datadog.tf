data "aws_iam_policy_document" "datadog_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["datadog.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "datadog_integration_role" {
  name               = "${var.project}-datadog-role"
  assume_role_policy = data.aws_iam_policy_document.datadog_assume_role.json
  tags = { Name = "${var.project}-datadog-role" }
}

resource "aws_iam_role_policy" "datadog_policy" {
  name = "${var.project}-datadog-policy"
  role = aws_iam_role.datadog_integration_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:GetMetricData",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricStatistics",
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "s3:GetBucketLocation",
          "sts:GetCallerIdentity",
          "autoscaling:DescribeAutoScalingGroups",
          "elasticloadbalancing:DescribeLoadBalancers",
          "rds:DescribeDBInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

output "datadog_role_arn" {
  value = aws_iam_role.datadog_integration_role.arn
}
