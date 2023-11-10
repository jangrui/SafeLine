# Helm Chart for SafeLine

## Introduction

This [Helm](https://github.com/kubernetes/helm) chart installs [SafeLine](https://github.com/chaitin/SafeLine) in a Kubernetes cluster.

## Prerequisites

- Kubernetes cluster 1.20+
- Helm v3.2.0+

## Installation

### Add Helm repository

```bash
helm repo add safeline https://jangrui.com/SafeLine
```

### Install the chart

Install the SafeLine helm chart with a release name `safeline`:

```bash
helm -n safeline upgrade -i safeline helm --create-namespace -f - <<EOF
nameOverride: "safeline"
fullnameOverride: "safeline"

imagePullPolicy: Always

global:
  image:
    registry: uhub.service.ucloud.cn/silkdo
    tag: 3.11.1

persistence:
  enabled: true
  resourcePolicy: "keep"
  persistentVolumeClaim:
    database:
      storageClass: nfs-sc
      accessMode: ReadWriteMany

    logs:
      storageClass: nfs-sc
      accessMode: ReadWriteMany

    nginx:
      storageClass: nfs-sc
      accessMode: ReadWriteMany

    management:
      storageClass: nfs-sc
      accessMode: ReadWriteMany

    detector:
      storageClass: nfs-sc
      accessMode: ReadWriteMany

    mario:
      storageClass: nfs-sc
      accessMode: ReadWriteMany

    tengine:
      storageClass: nfs-sc
      accessMode: ReadWriteMany
EOF
```
