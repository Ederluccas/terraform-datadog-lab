resource "datadog_monitor" "high_cpu" {
  name    = "${var.project} - High CPU (EC2)"
  type    = "metric alert"
  query   = "avg(last_5m):avg:aws.ec2.cpuutilization{*} by {host} > 70"
  message = "CPU alto detectado na instância. @ops"
  tags    = ["project:${var.project}", "env:lab"]
  notify_no_data = false
  thresholds {
    critical = 70
    warning  = 50
  }
}
