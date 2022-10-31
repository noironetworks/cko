# CKO
Cisco Kubernetes Operator (CKO) - An Operator for managing networking for Kubernetes clusters and more.

# Table of Contents

- [1. Introduction](#1-introduction)
- [2. Features](#2-features)
  - [2.1 Supported Integrations](#21-supported-integrations)
  - [2.2 Under Development](#22-under-development)
- [3. Deploying CKO](#3-deploying-cko)
  - [3.1 Control Cluster](#31-control-cluster)
    - [3.1.1 Prequisites](#311-prequisites)
    - [3.1.2 Install cert-manager](#312-install-cert-manager)
    - [3.1.3 Create a config file for Helm install](#313-create-a-config-file-for-helm-install)
    - [3.1.4 Deploy using Helm](#314-deploy-using-helm)
  - [3.2 Workload Cluster](#32-workload-cluster)
    - [3.2.1 Create Secret for Github access:](#321-create-secret-for-github-access)
    - [3.2.2 Deploy Manifests](#322-deploy-manifests)
- [4. Using CKO](#4-using-cko)
  - [4.1 Workflows](#41-workflows)
    - [4.1.1 Fabric Onboarding](#411-fabric-onboarding)
    - [4.1.2 Brownfield Clusters](#412-brownfield-clusters)
      - [4.1.2.1 Unmanaged CNI](#4121-unmanaged-cni)
      - [4.1.2.2 Managed CNI](#4122-managed-cni)
    - [4.1.3 Greenfield Clusters](#413-greenfield-clusters)
    - [4.1.4 Managing Clusters as a Group](#414-managing-clusters-as-a-group)
    - [4.1.5 Managing Clusters Individually](#415-managing-clusters-individually)
    - [4.1.6 Customizing Default Behaviors](#416-customizing-default-behaviors)
    - [4.1.7 Upgrade Managed CNI Operators](#417-upgrade-managed-cni-operators)
    - [4.1.8 Upgrade CKO in Workload Cluster](#418-upgrade-cko-in-workload-cluster)
    - [4.1.9 Upgrade Control Cluster](#419-upgrade-control-cluster)
  - [4.2 API Reference](#42-api-reference)
  - [4.3 Sample Configuration](#43-sample-configuration)
- [5. Observability & Diagnostics](#5-observability--diagnostics)
  - [5.1 Tracking CKO Status](#51-tracking-cko-status)
  - [5.2 Tracking Workload Clusters](#52-tracking-workload-clusters)
    - [5.2.1 Connectivity Checker](#521-connectivity-checker)
- [6. Troubleshooting](#6-troubleshooting)
- [7. Contributing](#7-contributing)
  - [7.1 Repositories](#71-repositories)
  - [7.2 Contributing to CKO](#72-contributing-to-cko)

## 1. Introduction

![Control and Workload Cluster](docs/user-guide/diagrams/control-and-workload-clusters.drawio.png)

## 2. Features

### 2.1 Supported Integrations

### 2.2 Under Development

## 3. Deploying CKO

### 3.1 Control Cluster

#### 3.1.1 Prequisites
* A functional Kubernetes cluster with reachability to the ACI Fabric. (A single node cluster is adequate.)
* kubectl
* Helm

#### 3.1.2 Install cert-manager

``` bash
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.10.0 \
  --set installCRDs=true
```

#### 3.1.3 Create a config file for Helm install
CKO follows the Gitops model for syncing configuration between Control and Workload clusters. The Git repository details can be provided as shown below (you can optionally add the HTTP_PROXY details if your clusters require it to communicate with Github).

``` bash

cat > my_values.yaml << EOF
image:
  repository: quay.io/ckodev/netop-org-manager
  pullPolicy: Always
  # Overrides the image tag whose default is the chart appVersion.
  tag: "0.9.0.d04f56f"

## -- Specifies image details for netop-farbic-manager
fabricManagerImage:
  repository: quay.io/ckodev/netop-fabric-manager
  pullPolicy: Always
  # Overrides the image tag whose default is the chart appVersion.
  tag: "0.9.0.d04f56f"

gitConfig:
  cko_git_config: |-
    git_repo: https://github.com/<OWNER>/<REPO>
    git_dir: <DIR>
    git_branch: <BRANCH NAME>
    git_token: <GIT PAT>
    git_user: <GIT USER>
    git_email: <GIT EMAIL>

extraEnv: []
  - name: HTTP_PROXY
    value: <add-your-http-proxy-addr:port>
  - name: HTTPS_PROXY
    value: <add-your-https-proxy-addr:port>
  - name: NO_PROXY
    value: 10.96.0.1

EOF
```

#### 3.1.4 Deploy using Helm

``` bash

helm repo add cko https://noironetworks.github.io/netop-helm
helm repo update
helm install netop-org-manager cko/netop-org-manager -n netop-org-manager --create-namespace --version 0.9.0 -f my_values.yaml
```

### 3.2 Workload Cluster

#### 3.2.1 Create Secret for Github access:
Provide the same Git repository details as those in the Control Cluster.

```bash
kubectl create secret generic cko-config -n netop-manager-system \
--from-literal=repo=https://github.com/<OWNER>/<REPO> \
--from-literal=dir=<DIR> \
--from-literal=branch=<BRANCH NAME> \
--from-literal=token=<GIT PAT> \
--from-literal=user=<GIT USER> \
--from-literal=email=<GIT EMAIL> \
--from-literal=systemid=<SYSTEM ID> \
--from-literal=http_proxy=<HTTP_PROXY> \
--from-literal=https_proxy=<HTTPS_PROXY> \
--from-literal=no_proxy=<NO_PROXY>
```

#### 3.2.2 Deploy Manifests

For OpenShift Cluster:

``` bash

kubectl apply -f https://raw.githubusercontent.com/noironetworks/netop-manifests/0.9.0/workload/netop-manager-openshift.yaml
kubectl apply -f https://raw.githubusercontent.com/noironetworks/netop-manifests/0.9.0/workload/platformInstaller.yaml
```

For non-OpenShift Cluster:

``` bash

kubectl apply -f https://raw.githubusercontent.com/noironetworks/netop-manifests/0.9.0/workload/netop-manager.yaml
kubectl apply -f https://raw.githubusercontent.com/noironetworks/netop-manifests/0.9.0/workload/platformInstaller.yaml
```

## 4. Using CKO

### 4.1 Workflows

#### 4.1.1 Fabric Onboarding

#### 4.1.2 Brownfield Clusters

##### 4.1.2.1 Unmanaged CNI

##### 4.1.2.2 Managed CNI

#### 4.1.3 Greenfield Clusters

#### 4.1.4 Managing Clusters as a Group

#### 4.1.5 Managing Clusters Individually

#### 4.1.6 Customizing Default Behaviors

#### 4.1.7 Upgrade Managed CNI Operators

#### 4.1.8 Upgrade CKO in Workload Cluster

#### 4.1.9 Upgrade Control Cluster

### 4.2 API Reference

### 4.3 Sample Configurations

## 5. Observability & Diagnostics

### 5.1 Tracking CKO Status

### 5.2 Tracking Workload Clusters

#### 5.2.1 Connectivity Checker

## 6. Troubleshooting

## 7. Contributing

### 7.1 Repositories

### 7.2 Contributing to CKO

[Developer Guide](docs/dev-guide/dev-and-contribute.md)