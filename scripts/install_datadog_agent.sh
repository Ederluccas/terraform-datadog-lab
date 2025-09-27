#!/bin/bash
set -e
echo "Starting Datadog Agent install script..."

# Try to get Datadog API key from SSM Parameter Store
PARAM_NAME="/datadog/api_key"
DD_API_KEY=""
if command -v aws >/dev/null 2>&1; then
  DD_API_KEY=$(aws ssm get-parameter --name "$PARAM_NAME" --with-decryption --query "Parameter.Value" --output text 2>/dev/null || true)
fi

if [ -z "$DD_API_KEY" ]; then
  echo "Datadog API key not found in SSM Parameter Store. Please populate /datadog/api_key."
  exit 0
fi

# Install Agent on Amazon Linux 2 using the official install script
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY="$DD_API_KEY" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)" || true
systemctl enable datadog-agent || true
systemctl start datadog-agent || true
echo "Datadog Agent installed (if supported on this AMI)."
