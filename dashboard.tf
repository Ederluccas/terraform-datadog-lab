resource "datadog_dashboard" "basic" {
  title       = "${var.project} - Basic Dashboard"
  description = "Dashboard de exemplo - CPU e Logs"
  layout_type = "ordered"

  widget {
    timeseries_definition {
      request {
        q = "avg:aws.ec2.cpuutilization{*}"
      }
      title = "EC2 CPU (média)"
    }
  }

  widget {
    log_stream_definition {
      query = "source:aws.ec2 OR @log"
      title = "Logs (exemplo)"
    }
  }
}
