#!/bin/bash
helm install falco-exporter --namespace=secops \ 
    --set-file certs.ca.crt=ca.crt,certs.client.key=client.key,certs.client.crt=client.crt \
    falcosecurity/falco-exporter 
