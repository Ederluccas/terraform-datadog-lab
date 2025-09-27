import os
import json
import gzip
import base64
import urllib.request

DD_API_KEY = os.environ.get('DD_API_KEY')
DD_SITE = os.environ.get('DD_SITE', 'datadoghq.com')
DD_URL = f"https://http-intake.logs.{DD_SITE}/v1/input/{DD_API_KEY}"

def lambda_handler(event, context):
    # CloudWatch Logs subscription payload arrives base64 + gzip encoded
    try:
        payload = event['awslogs']['data']
        compressed_payload = base64.b64decode(payload)
        decompressed = gzip.decompress(compressed_payload)
        logs_json = json.loads(decompressed)
    except Exception as e:
        # If event format different, try raw
        logs_json = event

    # Send to Datadog - for demo only; no batching logic here
    headers = {
        'Content-Type': 'application/json'
    }
    try:
        req = urllib.request.Request(DD_URL, data=json.dumps(logs_json).encode('utf-8'), headers=headers, method='POST')
        with urllib.request.urlopen(req, timeout=10) as resp:
            resp.read()
    except Exception as e:
        print("Error sending to Datadog:", e)

    return {'status': 'ok'}
