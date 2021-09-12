#!/bin/bash
helm install falco-exporter --namespace=secops \ 
    --set-file certs.ca.crt=ca.crt,certs.client.key=client.key,certs.client.crt=client.crt \
    falcosecurity/falco-exporter 
#  export POD_NAME=$(kubectl get pods --namespace secops -l "app.kubernetes.io/name=falco-exporter,app.kubernetes.io/instance=threat-exporter" -o jsonpath="{.items[0].metadata.name}")
#  echo "Visit http://127.0.0.1:9376/metrics to use your application"
#  kubectl port-forward --namespace secops $POD_NAME 9376    

kubectl create ns monit
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace=monit
echo "grafana pass: admin/prom-operator"
