#!/bin/env bash
echo "CKO Control Cluster Install"

sudo -E printf "\n"

set -e

# Usage:
# ./deploy_cko_on_kind.sh --repo https://github.com/test/example --dir mydir --branch mybranch --github_pat mypat --git_user myuser --git_email myemail@example.com  --http_proxy http://example.proxy.com:port --https_proxy http://example.proxy.com:port --no_proxy localhost,127.0.0.1
# ./deploy_cko_on_kind.sh -r https://github.com/test/example -d mydir -b mybranch -p mypat -u myuser -e myemail@cisco.com -hp http://example.proxy.com:port -hsp http://example.proxy.com:port -np localhost,127.0.0.1


# Defaults
REPO="https://github.com/test/example"
DIR="mydir"
BRANCH_NAME="mybranch"
GITHUB_PAT="mypat"
GIT_USER="myuser"
GIT_EMAIL="myemail@example.com"
#HTTP_PROXY=http://example.proxy.com:port
#HTTPS_PROXY=http://example.proxy.com:port
#NO_PROXY=<no-proxy>

# Read the input parameters
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -r|--repo)
    REPO="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--dir)
    DIR="$2"
    shift # past argument
    shift # past value
    ;;
    -b|--branch)
    BRANCH_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--github_pat)
    GITHUB_PAT="$2"
    shift # past argument
    shift # past value
    ;;
    -u|--git_user)
    GIT_USER="$2"
    shift # past argument
    shift # past value
    ;;
    -e|--git_email)
    GIT_EMAIL="$2"
    shift # past argument
    shift # past value
    ;;
    -hp|--http_proxy)
    HTTP_PROXY="$2"
    shift # past argument
    shift # past value
    ;;
    -hsp|--https_proxy)
    HTTPS_PROXY="$2"
    shift # past argument
    shift # past value
    ;;
    -np|--no_proxy)
    NO_PROXY="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    echo "Unknown option: $key"
    exit 1
    ;;
  esac
done

#cluster
pod_cidr=10.244.0.0/16
api_server=$(ip addr show | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | tr '\n' ',' | sed 's/,$//')
HOSTNAME=$(hostname)

set -T

trap '! [[ "$BASH_COMMAND" =~ ^(echo|printf|check_proxy_vars) ]] &&
      printf "+ %s\n" "$BASH_COMMAND"' DEBUG

# Set proxy
check_proxy_vars() {
  if [ -n "$HTTP_PROXY" ] || [ -n "$HTTPS_PROXY" ]; then
    return 0 # true
  else
    return 1 # false
  fi
}


check_secret_vars() {
  if [ -n "$REPO" ] || [ -n "$DIR" ] || [ -n "$BRANCH_NAME" ] || [ -n "$GITHUB_PAT" ] || [ -n "$GIT_USER" ] || [ -n "$GIT_EMAIL" ]; then
    return 0 # true
  else
    echo "some or all env variables required to configure cko resources are missing"
    return 1 # false
  fi
}


#please modify values.yaml if required
values_yaml="
# Default values for netops-org-manager.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: quay.io/ckodev/netop-org-manager
  pullPolicy: Always
  # Overrides the image tag whose default is the chart appVersion.
  tag: \"0.9.0.d04f56f\"

## -- Specifies image details for netop-farbic-manager
fabricManagerImage:
  repository: quay.io/ckodev/netop-fabric-manager
  pullPolicy: Always
  # Overrides the image tag whose default is the chart appVersion.
  tag: \"0.9.0.d04f56f\"

imagePullSecrets: []
nameOverride: \"\"
fullnameOverride: \"\"

# -- Specifies whether to enable ValidatingWebhook
webhook:
  enable: true

## -- Specifies the log level. Can be one of ‘debug’, ‘info’, ‘error’, or any integer value > 0.
logLevel: \"info\"

serviceAccount:
  # Specifies whether a service account should be created
  create: true
  # Annotations to add to the service account
  annotations: {}
  # The name of the service account to use.
  # If not set and create is true, a name is generated using the fullname template
  name: \"\"

resources: {}
  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 500m
  #   memory: 128Mi
  # requests:
  #   cpu: 10m
  #   memory: 64Mi

nodeSelector: {}

tolerations: []

affinity: {}

rbac:
  # Specifies whether RBAC resources should be created
  create: true

## -- Specifies managerConfig
managerConfig:
  controller_manager_config.yaml: |
    apiVersion: controller-runtime.sigs.k8s.io/v1alpha1
    kind: ControllerManagerConfig
    health:
      healthProbeBindAddress: :8083
    metrics:
      bindAddress: 127.0.0.1:8082
    webhook:
      port: 9443
    leaderElection:
      leaderElect: true
      resourceName: 2edab99a.

# -- Specifies whether to install a ArgoCD
argocd:
  enabled: true

# -- Specifies whether to install a Kubernetes Dashboard
kubernetes-dashboard:
  enabled: true
  rbac:
    clusterReadOnlyRole: true"

# Update Proxy if required
if check_proxy_vars; then
   echo "Setting Proxy"
   export http_proxy=$HTTP_PROXY
   export https_proxy=$HTTPS_PROXY
   export no_proxy=$api_server,$pod_cidr,$NO_PROXY
fi

# Update packages
echo "Updating Ubuntu..."
# sudo -E apt-get autoremove --purge
sudo -E apt-get -y update

# Install general dependencies
echo "Install required general dependencies(apt-transport-https ca-certificates curl gnupg2 lsb-release jq iptables software-properties-common)"
if ! sudo -E apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release jq iptables software-properties-common; then
    echo "Error: Failed to install general dependencies"
    exit 1
fi
echo "Done"

#Step 3: Ensure swap is disabled
echo "Disable swap, firewall and load netfilter framework to linux kernal"
sudo -E swapoff -a
sudo -E systemctl disable --now ufw
sudo -E modprobe br_netfilter
sudo -E sysctl -p /etc/sysctl.conf
echo "Done"

# Step 3: Install docker
echo "Installing docker and containerd"

# Remove all other versions of docker from your system
sudo -E dpkg --purge docker docker-engine docker.io containerd runc

# Add docker GPG key
if ! sudo -E curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo -E gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg; then
    echo "Error: Failed to add docker GPG key"
    exit 1
fi

# Add docker apt repository
if ! echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo -E tee /etc/apt/sources.list.d/docker.list; then
    echo "Error: Failed to add docker apt repository"
    exit 1
fi

# Fetch the package lists from docker repository
if ! sudo -E apt-get -y update; then
    echo "Error: Failed to fetch package lists from docker repository"
    exit 1
fi

# Install docker and containerd
if ! sudo -E apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin; then
    echo "Error: Failed to install docker and containerd"
    exit 1
fi

#rm -f /etc/containerd/config.toml
#sudo -E systemctl restart containerd


echo "Set docker proxy"
# Create required dirs
sudo -E mkdir -p /etc/systemd/system/docker.service.d

# add proxy
if check_proxy_vars; then
    echo -e "[Service]\nEnvironment=HTTP_PROXY=${http_proxy}\nEnvironment=HTTPS_PROXY=${https_proxy}\nEnvironment=NO_PROXY=${no_proxy}" |sudo tee -a /etc/systemd/system/docker.service.d/http-proxy.conf > /dev/null
fi

sudo -E systemctl daemon-reload
sudo -E systemctl restart docker

echo "Done"

# Step 5: Install Kind
echo "Installing Kind"

sudo -E curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64
sudo chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind


# Step 6: Install kubelet & kubectl
echo "Installing  kubelet & kubectl"

# Add Kubernetes GPG key
if ! sudo -E curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg; then
    echo "Error: Failed to add Kubernetes GPG key"
    exit 1
fi

# Add Kubernetes apt repository
if ! echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo -E tee /etc/apt/sources.list.d/kubernetes.list; then
    echo "Error: Failed to add Kubernetes apt repository"
    exit 1
fi

# Fetch package list
if ! sudo -E apt-get -y update; then
    echo "Error: Failed to fetch package list"
    exit 1
fi

# Install kubeadm, kubelet & kubectl
if ! sudo -E apt-get install -y kubelet kubectl; then
    echo "Error: Failed to install kubeadm, kubelet & kubectl"
    exit 1
fi

echo "Done"


# Step 7: Create the cluster with kind

sudo -E kind create cluster --name control-cluster
sudo chmod +r /home/cko/.kube/config


# Step 8: Untaint node
echo "Untainting node"

# Untaint node
kubectl taint nodes --all node.kubernetes.io/not-ready- || true
kubectl taint nodes --all node-role.kubernetes.io/control-plane- || true

echo "Done"


# Step 9: Install helm
echo "Installing helm"

# Download and install helm
if ! sudo -E curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash; then
    echo "Error: Failed to install helm"
    exit 1
fi

echo "Done"

echo "Completed single node cluster setup"

set +x

# Step 10: Install cko control cluster
echo "Installing CKO"

if check_secret_vars; then
    echo "Creating cert-manager resources via helm chart"
    sudo -E helm repo add jetstack https://charts.jetstack.io
    sudo -E helm repo update
    if ! sudo -E helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.10.0 --set installCRDs=true --wait; then
      echo "Helm timed out waiting for condition. Please check if cert-manager resources are running"
    fi
    
    echo "Creating 'netop-manager' namespace"
    kubectl create ns netop-manager

    echo "Creating control cluster secrets"

    kubectl create secret generic cko-config -n netop-manager \
    --from-literal=repo=$REPO \
    --from-literal=dir=$DIR \
    --from-literal=branch=$BRANCH_NAME \
    --from-literal=token=$GITHUB_PAT \
    --from-literal=user=$GIT_USER \
    --from-literal=email=$GIT_EMAIL \
    --from-literal=http_proxy=$HTTP_PROXY \
    --from-literal=https_proxy=$HTTPS_PROXY \
    --from-literal=no_proxy=$NO_PROXY,10.96.0.1,.netop-manager.svc,.svc,.cluster.local,localhost,127.0.0.1,10.96.0.0/16,10.244.0.0/16,control-cluster-control-plane,.svc,.svc.cluster,.svc.cluster.local

    kubectl create secret generic cko-argo -n netop-manager \
    --from-literal=url=$REPO \
    --from-literal=type=git  \
    --from-literal=password=$GIT_PAT \
    --from-literal=username=$GIT_USER \
    --from-literal=proxy=$HTTP_PROXY

    kubectl label secret cko-argo -n netop-manager 'argocd.argoproj.io/secret-type'=repository

    echo "Creating netop-manager resources via helm chart"
    sudo -E helm repo add cko https://noironetworks.github.io/netop-helm
    sudo -E helm repo update
    
    # Write values.yaml
    echo "$values_yaml" | sudo -E tee values.yaml > /dev/null
    if ! sudo -E helm install netop-org-manager cko/netop-org-manager -n netop-manager --create-namespace --version 0.9.0 -f $(pwd)/values.yaml --wait; then
     echo "Helm timed out waiting for condition. Please check that netop-org-manager resources are running"
    fi
else
    echo "Error: Some or all required variables to configure cko resources are missing"
fi

printf "\nControl Cluster with CKO install complete, you can now use your cluster with:\nkubectl cluster-info --context kind-control-cluster\n"
