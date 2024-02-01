# Helm Chart for SafeLine

## Prerequisites

- Kubernetes cluster storage support RWX.

## Installation

Install the SafeLine helm chart with a release name `safeline`:
```bash
helm repo add jangrui https://github.com/jangrui/SafeLine --force-update
helm -n safeline upgrade -i safeline jangrui/safeline --create-namespace
```

## Uninstallation

To uninstall/delete the `safeline` deployment:
```bash
helm -n safeline uninstall safeline
```
