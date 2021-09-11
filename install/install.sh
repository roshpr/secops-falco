#!/bin/bash

echo "=== Setup Helm ==="
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "=== Setup Falco ==="
helm install falco falcosecurity/falco

# Tip:
# You can easily forward Falco events to Slack, Kafka, AWS Lambda and more with falcosidekick.
# Full list of outputs: https://github.com/falcosecurity/charts/falcosidekick.
# You can enable its deployment with `--set falcosidekick.enabled=true` or in your values.yaml.
# See: https://github.com/falcosecurity/charts/blob/master/falcosidekick/values.yaml for configuration values."
