#!/bin/bash

echo "=== Setup Helm ==="
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "=== Create NS secops ==="
kubectl create ns secops

echo "=== Install Falco driver loader for Ebpf ==="
# https://falco.org/docs/event-sources/drivers/#ebpf-probe
# https://falco.org/docs/getting-started/download/
# https://falco.org/docs/getting-started/running/#docker
# https://falco.org/docs/getting-started/running/#docker-least-privileged

docker pull falcosecurity/falco-driver-loader:latest
docker run --rm -i -t --privileged -v /root/.falco:/root/.falco -v /proc:/host/proc:ro -v /boot:/host/boot:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro -v /etc:/host/etc:ro falcosecurity/falco-driver-loader:latest
ls ~/.falco

echo "=== Install falco helm chart as name threatmonit ==="
helm install threatmonit --set falco.jsonOutput=true --set falco.webserver.nodePort=true --set ebpf.enabled=true --set falcosidekick.enabled=true --set falcosidekick.webui.enabled=true --namespace secops falcosecurity/falco

# Tip:
# You can easily forward Falco events to Slack, Kafka, AWS Lambda and more with falcosidekick.
# Full list of outputs: https://github.com/falcosecurity/charts/falcosidekick.
# You can enable its deployment with `--set falcosidekick.enabled=true` or in your values.yaml.
# See: https://github.com/falcosecurity/charts/blob/master/falcosidekick/values.yaml for configuration values."

echo "=== Enable audit events ==="
# https://github.com/falcosecurity/evolution/tree/master/examples/k8s_audit_config
