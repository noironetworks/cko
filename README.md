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
    - [Create Secret for Github access:](#create-secret-for-github-access)
    - [Deploy Manifests](#deploy-manifests)

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
CKO follows the Gitops model for syncing configuration between Control and Workload clusters. The Git repository details can be provided as shown below (you can optionally add the HTTP_PROXY details if your clusters require it to communicate with Github).

``` bash

cat > my_values.yaml << EOF
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

#### Deploy using Helm

``` bash

helm repo add cko https://noironetworks.github.io/netop-helm
helm repo update
helm install netop-org-manager cko/netop-org-manager -n netop-org-manager --create-namespace --version 0.9.0 -f my_values.yaml
```

### Workload Cluster

#### Create Secret for Github access:
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

#### Deploy Manifests

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