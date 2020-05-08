  #!/bin/bash

echo "Running: helm repo update"
helm repo list && helm repo update || true

echo 'Running: helm plugin uninstall'
helm plugin remove secrets

echo 'Running: helm plugin install'
helm plugin install https://github.com/futuresimple/helm-secrets

echo 'Running: helm repo add'
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add appuio https://charts.appuio.ch
