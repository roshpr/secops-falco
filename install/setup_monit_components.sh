#!/bin/bash
helm install falco-exporter --namespace=secops \ 
    --set-file certs.ca.crt=ca.crt,certs.client.key=client.key,certs.client.crt=client.crt \
    falcosecurity/falco-exporter 
kubectl create ns monit
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace=monit
echo "grafana pass: admin/prom-operator"
