# CKO
Cisco Kubernetes Operator (CKO) - An Operator for managing networking for Kubernetes clusters and more

# Table of Contents

- [Deploying CKO](#deploying-cko)
  - [Control Cluster](#control-cluster)
    - [Prequisites](#prequisites)
    - [Install cert-manager](#install-cert-manager)
    - [Create a config file for Helm install](#create-a-config-file-for-helm-install)
    - [Deploy using Helm](#deploy-using-helm)
  - [Workload Cluster](#workload-cluster)

## Deploying CKO

### Control Cluster

#### Prequisites
* A functional Kubernetes cluster with reachability to the ACI Fabric. (A single node cluster is adequate.)
* kubectl
* Helm

#### Install cert-manager

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

#### Create a config file for Helm install

``` bash

cat > my_values.yaml << EOF
extraEnv: []
  - name: HTTP_PROXY
    value: <add-your-http-proxy-addr:port>
  - name: HTTPS_PROXY
    value: <add-your-https-proxy-addr:port>
  - name: NO_PROXY
    value: 10.96.0.1 

gitConfig:
  cko_git_config: |-
    git_repo: <git-repo-addr>
    git_dir: <top-level-git-dir>
    git_branch: <git-branch-name>
    git_token: <git-pat>
    git_user: <git-user>
    git_email: <git-email>
EOF
```

#### Deploy using Helm

``` bash

helm repo add cko https://noironetworks.github.io/netop-helm
helm repo update
helm install netop-org-manager cko/netop-org-manager -n netop-org-manager --create-namespace --version 0.9.0 -f my_values.yaml
```

### Workload Cluster

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