#!/bin/bash
helm install falco-exporter --namespace=secops \ 
    --set-file certs.ca.crt=ca.crt,certs.client.key=client.key,certs.client.crt=client.crt --set serviceMonitor.enabled=true \
    falcosecurity/falco-exporter 
#  export POD_NAME=$(kubectl get pods --namespace secops -l "app.kubernetes.io/name=falco-exporter,app.kubernetes.io/instance=threat-exporter" -o jsonpath="{.items[0].metadata.name}")
#  echo "Visit http://127.0.0.1:9376/metrics to use your application"
#  kubectl port-forward --namespace secops $POD_NAME 9376    

kubectl create ns monit
# https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#configuration
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace=monit
echo "grafana pass: admin/prom-operator"

# Follow steps to configure falco exporter with prometheus: 
# Issues https://githubmemory.com/repo/falcosecurity/falco-exporter/issues
# Issues https://github.com/falcosecurity/falco-exporter/issues/63

# enable audit events in kubernetes kubeadm
# https://evalle.github.io/blog/20200929-how-to-enable-kubernetes-auditing-with-kubeadm
