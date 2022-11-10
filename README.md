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
    - [3.1.3 Create Secret for Github access](#313-create-secret-for-github-access)
    - [3.1.4 Create a config file for Helm install](#314-create-a-config-file-for-helm-install)
    - [3.1.5 Deploy using Helm](#315-deploy-using-helm)
  - [3.2 Workload Cluster](#32-workload-cluster)
    - [3.2.1 Create Secret for Github access](#321-create-secret-for-github-access)
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
  - [5.1 Diagnostics on the Control Cluster](#51-diagnostics-on-the-control-cluster)
  - [5.2 Diagnosticson on the Workload Clusters](#52-diagnostics-on-the-workload-cluster)
- [6. Troubleshooting](#6-troubleshooting)
- [7. Contributing](#7-contributing)
  - [7.1 Repositories](#71-repositories)
  - [7.2 Contributing to CKO](#72-contributing-to-cko)
  - [7.3 Experimenting with Control Cluster](#73-experimenting-with-control-cluster)

## 1. Introduction

The [CNCF Cloud Native Landscape](https://landscape.cncf.io/?grouping=category) illustrates the rich and rapidly evolving set of projects and compnents in the Cloud Native Networking domain. Using these components requires installation and operational knowledge of each one of those. It also leaves the burden on the user to harmonize the configuration across the networking layers and components to ensure that everything works in sync. This gets even more complicated when you consider that most production solutions run applications which are deployed across multiple Kubernetes clusters.

CKO aims to alleviate this complexity and reduce the operational overhead by:
* Automation - Providing resource management across network resources and automating the composition of networks and services
* Observability - Providing observability by correlating between clusters and infrastructure, by centralized data collection and eventing, and by health check and reporting at global level
* Operations - Providing operational benefits via centralized network governance, migration of workloads, and cost optimization across cluster sprawl
* Security - Providing multi-cluster security by federating identity across domains

CKO achieves this by defining simple abstractions to meet the needs of he following persona:
* Kubernetes Admin - responsible for managing the cluster
* Cloud Admin - responsible for the coordinating the infrastructure needs of a cluster
* Network Admin - responsible for the network infrastructure

These abstractions are modeled to capture the user's intent and then consistently apply it across the infrastructure components. The abstractions are:
* ClusterProfle - defined by the Kubernetes Admin to express the network needs for the cluster they intend to manage
* ClusterGroupProfile - defined by the Cloud Admin to match the networking needs of all matching clusters with network and other infrastructure
* ClusterNetworkProfile - defined by the Cloud Admin to match the specific needs of one cluster
* FabricInfra - defined by the Network Admin to model each discrete physical or virtual network infrastructure unit that provides pod, node and external networking capabilities to the cluster

The diagram below illustrates the relationship between these abstactions.

![CKO Resources](docs/user-guide/diagrams/class-diagram.drawio.png)

The abstractions ensure that these persona can seamlessly collaborate to dynamically satisfy the networking needs of the set of clusters they manage. The abstractions are flexible and can be applied to a group of clusters which can be managed as a whole, or can be used to create individual snowflakes. 

The diagram below illustrates a typical CKO deployment comprising of one Control Cluster and one or more Workload Clusters with the following CKO components:
* A centralized "Org Operator" for identity and resource management 
* One or more "Fabric Operators" for network infrastructure automation and kubernetes manifest generation
* "Per Cluster Operators" for managing the lifecycle of network components in the Workload Cluster

The Workload Cluster runs the user's applications. The lifecycle of all the clusters is managed by the user; CKO only requires that specific operators be run in these. The lifecycle of CKO in the Workload Cluster, once deployed, is managed by the Control Cluster.

![Control and Workload Cluster](docs/user-guide/diagrams/control-and-workload-clusters.drawio.png)

## 2. Features
This release includes the following features:

* An Extensible Framework for CNI Lifecycle Management and Reporting
* Centralized Management comprising of
    * Network Data Model
    * CNI Asset Generation
    * CNI Upgrades
    * Connectivity Reporting

### 2.1 Supported Integrations
This release has support for:

* ACI Fabric 5.2
* ACI-CNI 5.2.3.4
* Calico CNI with Tigera Operator 3.23
* OCP 4.10
* Kubernetes 1.22 or later

### 2.2 Roadmap Items Under Development
Support for the following technologies and products is being actively pursued:

| Feature       |  Product                                                 |
|---------------|----------------------------------------------------------|
| Network Infra | * Cisco Nexus Standalone (NDFC)<br> * AWS EKS            |
| CNI           | * AWS VPC<br> * Cilium<br> * OpenShift SDN               |
| Distributions | * Rancher                                                |
| Service Mesh  | * Cisco Calisti<br> * Istio<br> * OpenShift Service Mesh |
| Loadbalancer  | * MetalLB                                                |
| Ingress       | * NGINX                                                  |
| Monitoring    | * Prometheus<br> * Open Telemetry                        |
| DPU           | * Nvidia Bluefield                                       |

The above list is not comprehensive and we are constantly evaluating and adding new features for support based on user demand.

## 3. Deploying CKO
CKO requires one Control Cluster to be deployed with the CKO operators before any Workload Clusters can be managed by CKO. Existing Workload Clusters with a functioning CNI can be imported into CKO.

### 3.1 Control Cluster

#### 3.1.1 Prequisites
* A functional Kubernetes cluster with reachability to the ACI Fabric that will serve as the Control Cluster. (A single node cluster is adequate.)
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

#### 3.1.3 Create Secret for Github access
CKO follows the [GitOps](https://www.weave.works/technologies/gitops/) model using [Argo CD](https://github.com/argoproj/argo-cd) for syncing configuration between Control and Workload clusters. The Git repository details can be provided as shown below. The configuration below assumes that the Git repository is hosted in Github. You can optionally add the HTTP_PROXY details if your clusters require it to communicate with Github.

```bash
kubectl create ns netop-manager

kubectl create secret generic git-config -n netop-manager \
--from-literal=repo=https://github.com/<ORG>/<REPO> \
--from-literal=dir=<DIR> \
--from-literal=branch=<BRANCH NAME> \
--from-literal=token=<GITHUB PAT> \
--from-literal=user=<GIT USER> \
--from-literal=email=<GIT EMAIL> \
--from-literal=http_proxy=<HTTP_PROXY> \
--from-literal=https_proxy=<HTTPS_PROXY> \
--from-literal=no_proxy=<NO_PROXY>

kubectl create secret generic cko-argo -n netop-manager \
--from-literal=url=https://github.com/<ORG>/<REPO> \
--from-literal=type=git  \
--from-literal=password=<GIT PAT> \
--from-literal=username=<GIT USER> \
--from-literal=proxy=<HTTP_PROXY>

kubectl label secret cko-argo -n netop-manager 'argocd.argoproj.io/secret-type'=repository
```

#### 3.1.4 Create a config file for Helm install
Setting the relevant image registries and tags for this release.

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

extraEnv:
  - name: HTTP_PROXY
    value: <add-your-http-proxy-addr:port>
  - name: HTTPS_PROXY
    value: <add-your-https-proxy-addr:port>
  - name: NO_PROXY
    value: 10.96.0.1

EOF
```

Argo CD is automatically deployed in the Control Cluster (in the netop-manager namespace) and in the Workload Cluster (in the netop-manager-system namespace). By default Argo CD reconciles with the git repository every [180s](https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/argocd-cm.yaml#L283). If quicker synchronization is required you can follow the process described [here](https://www.buchatech.com/2022/08/how-to-set-the-application-reconciliation-timeout-in-argo-cd/).

#### 3.1.5 Deploy using Helm

``` bash

helm repo add cko https://noironetworks.github.io/netop-helm
helm repo update
helm install netop-org-manager cko/netop-org-manager -n netop-manager --create-namespace --version 0.9.0 -f my_values.yaml
```

### 3.2 Workload Cluster

#### 3.2.1 Create Secret for Github access
Provide the same Git repository details as those in the Control Cluster.

```bash
kubectl create ns netop-manager-system

kubectl create secret generic cko-config -n netop-manager-system \
--from-literal=repo=https://github.com/<ORG>/<REPO> \
--from-literal=dir=<DIR> \
--from-literal=branch=<BRANCH NAME> \
--from-literal=token=<GITHUB PAT> \
--from-literal=user=<GIT USER> \
--from-literal=email=<GIT EMAIL> \
--from-literal=systemid=<SYSTEM ID> \
--from-literal=http_proxy=<HTTP_PROXY> \
--from-literal=https_proxy=<HTTPS_PROXY> \
--from-literal=no_proxy=<NO_PROXY>

kubectl create secret generic cko-argo -n netop-manager-system \
--from-literal=url=https://github.com/<ORG>/<REPO> \
--from-literal=type=git  \
--from-literal=password=<GIT PAT> \
--from-literal=username=<GIT USER> \
--from-literal=proxy=<HTTP_PROXY>

kubectl label secret cko-argo -n netop-manager-system 'argocd.argoproj.io/secret-type'=repository
```

For ACI-CNI, in case if importing a cluster which has a functioning CNI, the system-id is corresponds to the one mentioned in the acc-provision input file. For all other cases, you can chose a name to assign an identity to this cluster.

#### 3.2.2 Deploy Manifests

For OpenShift Cluster:

``` bash

kubectl apply -f https://raw.githubusercontent.com/noironetworks/netop-manifests/cko-mvp-1/workload/netop-manager-openshift.yaml
kubectl create -f https://raw.githubusercontent.com/noironetworks/netop-manifests/cko-mvp-1/workload/platformInstaller.yaml
```

For non-OpenShift Cluster:

``` bash

kubectl apply -f https://raw.githubusercontent.com/noironetworks/netop-manifests/cko-mvp-1/workload/netop-manager.yaml
kubectl create -f https://raw.githubusercontent.com/noironetworks/netop-manifests/cko-mvp-1/workload/platformInstaller.yaml
```

## 4. Using CKO

### 4.1 Workflows

#### 4.1.1 Fabric Onboarding
Each network infrasructure unit (referred to as a fabric), and that is managed as an independent entity, is modeled in CKO using the FabricInfra CRD. The network admin creates a FabricInfra CR to establish the identity of the of that fabric, and allows the network admin to specify the set of resources available to be consumed on that fabric. CKO reserves these resources in the FabricInfra on the cluster's behalf, and performs the necessary provisioning on the fabric to enable the networking for the cluster.

The following fields are required when creating the FabricInfra:

```bash
  credentials:
    hosts:
    - <APIC-IP-1>
    - ...
    secretRef:
      name: apic-credentials
  fabric_type: aci
  infra_vlan: <infra-vlan-value>
```

The secretRef property refers to a secret which needs to be created with the referenced name as follows:

```bash
kubectl create secret -n netop-manager generic apic-credentials --from-literal=username=<APIC_USERNAME> --from-literal=password=<APIC_PASSWORD>
```

The username provided above should have privileges to access at least the "common" tenant on the APIC.

IPAM, VLANs and other such enumerated resources can be specified in the FabricInfr as pools:

```bash
  ...
  mcast_subnets:
    - 225.114.0.0/16
    - 225.115.0.0/16
  internal_subnets:
    - 1.100.101.1/16
    - 2.100.101.1/16
    - 10.5.0.1/16
    - 10.6.0.1/16
    - 20.2.0.1/16
    - 20.5.0.1/16
  external_subnets:
    - 10.3.0.1/16
    - 10.4.0.1/16
    - 20.3.0.1/16
    - 20.4.0.1/16
  vlans:
    - 101
    - 102
    - 103
    - 104
    ...
```

At least four internal subnets (for pod, node and services networks), one multicast subnet, and two external subnets need to be available for every cluster.

Note: The minimum requirements vary across the deployment scenarios and supported CNIs. Not all the resources dictated by the minimum requriements will be used. The optimization is underway to validate the minimum requirements for each of these cases separately and will relax this minimum requirements in an uppcoming release.

CKO will automatically pick available resources from resource pools. Resources are picked in round-robin fashion. CKO currently does not partition the subnets, so each subnet specified in the resource pool is treated as an indivisible pool. If smaller subnets are desired, they should be listed as individual subnets.

The kubernetes_node-to-fabric and fabric-to-external connectivity on each fabric is encapsulated in the context property of the FabricInfra. For example in the case of the ACI fabric, the following example shows the context and its constituent properties:

```bash
  ...
  contexts:
    context-1:
      aep: bm-srvrs-aep
      l3out:
        name: l3out-1
        external_networks:
        - l3out-1_epg
      vrf:
        name: l3out-1_vrf
        tenant: common
    ...
```

At least one context is required for each cluster, and all fields in the context are required. CKO currently does not create ACI AEP, VRF, and L3out; they have to be created by the network admin and referenced in the above configuration.

The kubernetes_nodes and top-of-the-racks interconnection topology per fabric is captured in the topology section as shown below:

```bash
  topology:
    rack:
    - id: 1
      aci_pod_id: 1
      leaf:
      - id: 101
      - id: 102
      node:
      - name: k8s-node1
      - name: k8s-node2
    - id: 2
      aci_pod_id: 1
      leaf:
      - id: 103
      - id: 104
      node:
      - name: k8s-node3
      - name: k8s-node4
```

The specification of the topology section is required when the fabric is intended to be used for the Calico CNI, its optional if only the ACI-CNI is intended to be deployed. The rack and aci_pod_id properties are user defined, where as the lead IDs correspond to their correponding values on the fabric.

The BGP configuration for the fabric can be specified as follows:

```bash
  bgp:
    remote_as_numbers:
      - 64512
    aci_as_number: 2
```

The specification of the bgp section is required when the fabric is intended to be used for the Calico CNI, its optional if only the ACI-CNI is intended to be deployed.

All avaliable and allocated resource are refelected in the status field of the FabricInfra as shown in the example below:

```bash
status:
  allocated:
  - cluster_profile: bm2acicni
    context:
      aep: bm-srvrs-aep
      l3out:
        external_networks:
        - sauto_l3out-1_epg
        name: sauto_l3out-1
      vrf:
        name: sauto_l3out-1_vrf
        tenant: common
    external_subnets:
    - 10.3.0.1/16
    - 10.4.0.1/16
    internal_subnets:
    - 1.100.101.1/24
    - 10.6.0.1/16
    - 10.5.0.1/16
    mcast_subnets:
    - 225.114.0.0/16
    vlans:
    - 101
    - 102
  available:
    contexts:
      context-2:
        aep: bm-srvrs-calico-aep
        l3out:
          external_networks:
          - sauto_l3out-3_epg
          name: sauto_l3out-3
        vrf:
          name: sauto_l3out-3_vrf
          tenant: common
    external_subnets:
    - 20.3.0.1/16
    - 20.4.0.1/16
    internal_subnets:
    - 1.100.101.1/16
    - 2.100.101.1/16
    - 20.2.0.1/16
    - 20.5.0.1/16
    mcast_subnets:
    - 225.115.0.0/16
    remote_as_numbers:
    - 64512
    vlans:
    - 103
    - 104
```

Note: Subnet, VLAN and context resources do not need to be explicitly defined in the FabricInfra spec for imported clusters. Since these resources are already in use on the fabric, CKO will learn them at the time of importing the cluster, and automatically reserve those resources in the FabricInfra. These resources will however not be release to the available pool when the cluster is deleted.

The complete API spec for the FabricInfra can be found here: [CRD](docs/control-cluster/api_docs.md#fabricinfra)

An exmaple of the FabricInfra CR can be found here: [Example CR](config/samples/aci-cni/kubernetes/fabricinfra.yaml)

#### 4.1.2 Brownfield Clusters
Existing clusters with a functional CNI can be imported into CKO. The imported cluster starts off with its CNI in an observed, but unmanaged, state by CKO. After succesfully importing the cluster, the CNI can be transitioned to a managed state after which the CNI's configuration and lifecycle can be completely controlled from the Control Cluster.

##### 4.1.2.1 Unmanaged CNI
Pre-requisite: The network admin has on-boarded the fabric by creating a FabricInfra CR.

This worfklow is initiated in the cluster which needs to be imported.

The first step is to create the secrets to access a Github repo as shown [here](#321-create-secret-for-github-access).

Then apply the CKO workload cluster operator manifests as show [here](#322-deploy-manifests).

Once applied, the notification to import the cluster will be sent to the Control Cluster via Gitops. Once Argo CD syncs on the Control Cluster you will see the following following two resources getting created:

- [ClusterProfile](config/samples/aci-cni/kubernetes/imported/auto-clusterprofile.yaml) with name: ```auto-<cluster-name>```
- [ClusterNetworkProfile](config/samples/aci-cni/kubernetes/imported/auto-clusternetworkprofile.yaml) with name: ```auto-<cluster-name>```

The status of the imported cluster can now be tracked in the Control Cluster. 

##### 4.1.2.2 Managed CNI
Pre-requisite: A cluster with an associated ClusterProfile is present. 

Change the following in the ClusterProfile:

```bash
...
  operator_config:
    mode: unmanaged
...
```

to:


```bash
...
  operator_config:
    mode: managed
...
```

This will trigger the workflow on the workload cluster once Argo CD syncs, such that the installed CNI will be managed by the Control Cluster.

#### 4.1.3 Greenfield Clusters
Pre-requisite: The network admin has on-boarded the fabric by creating a FabricInfra CR.

Unlike in the brownfield case, this workflow starts in the Control Cluster.

The user creates a simple ClusterProfile with CNI choice.

For ACI-CNI:
```bash
apiVersion: netop.mgr/v1alpha1
kind: ClusterProfile
metadata:
  name: <cluster-name>
  namespace: netop-manager
spec:
  cni: aci
```

For Calico-CNI:
```bash
apiVersion: netop.mgr/v1alpha1
kind: ClusterProfile
metadata:
  name: <cluster-name>
  namespace: netop-manager
spec:
  cni: calico
```

This will result in a choice of an available FabricInfra and the allocation of relevant resource on that fabric. On success, the ClusterProfile status will reflect the allocated resources such that it can be used in the cluster installation. For example:

```bash
...
status:
  aci_cni_config:
    version: 5.2.3.4
  cluster_network_profile_name: bm2acicni
  context:
    aep: bm-srvrs-aep
    l3out:
      external_networks:
      - sauto_l3out-1_epg
      name: sauto_l3out-1
    vrf:
      name: sauto_l3out-1_vrf
      tenant: common
  external_subnets:
  - 10.3.0.1/16
  - 10.4.0.1/16
  fabricinfra:
    context: context-1
    name: k8s-bm-2
  internal_subnets:
  - 1.100.101.1/24
  - 10.6.0.1/16
  - 10.5.0.1/16
  mcast_subnets:
  - 225.114.0.0/16
  node_subnet: 1.100.101.1/24
  node_vlan: 101
  operator_config:
    mode: unmanaged
    version: 0.8.0
  pod_subnet: 10.6.0.1/16
  ready: true
  vlans:
  - 101
  - 102
  workload_cluster_manifest_locations:
  - 'argo: https://github.com/networkoperator/ckogitrepo/tree/test/workload/argo/bm2acicni'
  - 'operator: https://github.com/networkoperator/ckogitrepo/tree/test/workload/config/bm2acicni' 
```

When the ClusterProfile is deleted, the allocated resources are returned to the avaliable pool.

The ClusterProfile API also allows to specify all the configurable details with regards to the CNI if the user wants to choose specific values for the fields. For resources that are chosen from the FrabricInfra, those resources will have to be available in the FabricInfra.

The complete API spec for the ClusterProfile can be found here: [CRD](docs/control-cluster/api_docs.md#clusterprofile)

An exmaple of the ClusterProfile CR can be found here: [Example CR](config/samples/aci-cni/kubernetes/clusterprofile_aci.yaml)

#### 4.1.4 Managing Clusters as a Group

Create ClusterGroupProfile with common properties like CNI, Distro etc, set labels.

After creating the ClusterProfile for a cluster, set ClusterGroupProfileSelector to match ClusterGroupProfile's labels.

Also updates to properties such as CNI management modes (managed versus unmanaged), CKO version, and CNI versions can be done in the ClusterGroupProfile instead of individual clusters.

The complete API spec for the ClusterGroupProfile can be found here: [CRD](docs/control-cluster/api_docs.md#clustergroupprofile)

An exmaple of the ClusterGroupProfile CR can be found here: [Example CR](config/samples/aci-cni/kubernetes/clustergroupprofile_aci.yaml)

#### 4.1.5 Managing Clusters Individually

Create ClusterNetworkProfile ConfigMap with all the specific desired properties for this cluster.

Create ClusterProfile for cluster, set ClusterNetworkProfileSelector to match ClusterNetworkProfile's labels.

An exmaple of the ClusterNetworkProfile ConfigMap can be found here: [Example CR](config/samples/aci-cni/kubernetes/config_maps.yaml)

#### 4.1.6 Customizing Default Behaviors
* ConfigMap for ClusterProfle global default settings: defaults-cluster-profile.yaml
* ConfigMap for FabricInfra global default settings: defaults-global-fabricinfra.yaml

#### 4.1.7 Upgrade Managed CNI Operators
Update CNI version in ClusterProfile,

For ACI CNI:

```bash
...
           config_overrides:
                  aci_cni_config:
                      ...
                      target_version: <>
                        ...
```

For Calico CNI:

```bash
...
           config_overrides:
                  calico_cni_config:
                      ...
                      target_version: <>
                        ...
```

#### 4.1.8 Upgrade CKO in Workload Cluster
Update CKO version in ClusterProfile by changing the following:

```bash
...
  operator_config:
    ...
    target_version: 0.9.1
...
```

#### 4.1.9 Upgrade Control Cluster

```bash
	helm upgrade --install netop-org-manager deploy/charts/netops-org-manager -n netop-manager --create-namespace \
	--set image.tag=${VERSION} --set image.repository=${IMAGE_TAG_BASE} \
	--set fabricManagerImage.repository=quay.io/ckodev/netop-fabric-manager \
	--set image.pullPolicy=IfNotPresent
```

### 4.2 API Reference
* [User API](docs/control-cluster/api_docs.md_)
* [Editable Properties](docs/control-cluster/property_update_docs.md)

### 4.3 Sample Configurations
* [ACI-CNI](config/samples/aci-cni)
* [Calico](config/samples/calico)

## 5. Observability & Diagnostics

CKO has built-in diagnostic tools that provides insights in to the state of network configuration on both control and workload cluster sides. 

### 5.1 Diagnostics on the Control Cluster

#### 5.1.1 Workload cluster configuration state on Control Cluster:

After creating new FabricInfra Custom Resource for new Data Center Fabric, the new POD will be created with a name: *netop-fabric-manager-<FABRIC_NAME>-<RANDOM_NUMBER>* in the *netop-manager* namespace. 

Verify whether the POD has been created, using following command:

```
kubectl get pods -n netop-manager
```

After applying ClusterGroupProfile, ClusterProfile Custom Resources (CR) and optionally Config_Map for ClusterNetworkProfile, the workload cluster's network configuration is represented as a Custom Resource *clusterinfoes.netop.mgr* in the Control Cluster. 

*Note* this is namespaced resouce, which will be created in the namespace you specified during creation of control cluster. Use following command to verify network configuration for workload cluster:

```
kubectl describe clusterinfoes.netop.mgr -n netop-manager <WORKLOAD_CLUSTER_NAME> 
```

In addition, ClusterProfile Custom Resource (CR) should be populated with the network details in the *.status* field. Artifacts are picked up from the FabricInfra or ClusterNetworkProfile (Config_Map). In addition, the *.status.deployment_script* field of the FabricInfra CR, consist of the URL links to the specific files pushed to the Git repository. Those files will be later used to deploy network configuration to the workload cluster.

#### 5.1.2 Verify network resources used from the common pools:

FabricInfra Custom Resource defines pools of resources such as subnets or VLANs available to use by Workload Clusters. Verify allocated resources by checking FabricInfra Custom Resource status field:

```
kubectl describe fabricinfras.netop.mgr -n netop-manager <FABRIC_INFRA_NAME>
```

#### 5.1.3 Verification of connectivity to Git

Configuration of the workload cluster is packaged in to following files and pushed to the Git repository:
The folder structure is the following:

```
`-- workload
    |-- argo
    |   |-- <workload_cluster_name>
    |   |   `-- argo_app.yaml
    `-- config
        `-- <workload_cluster_name>
            |-- installer-networking.yaml
            |-- installer-platform.yaml
            |-- installer.yaml
            `-- netop-manager-deployment.yaml
```

After successfully creation of the workload cluster network configuration in the Control Cluster, those files will be pushed to the Git repository. New folder with the name of the workload cluster will be created.


### 5.2 Diagnostics on the Workload Cluster


#### 5.2.1 Verify CNI installation

Regardless of the CNI installed, verify that all PODs get IP address and are in the Running or Completed state.

**Note**, that some pods running in the host network namespace and share node IP addresses - those will be running even without CNI installed. 


#### 5.2.2 View summary of CNI network configuration of Worlkoad Cluster

The CniOps Custom Resource tracks usage of the network resources, IP pools allocations to nodes. It also tracks and checks for any inconsitencies and stale objects. 

Use following commang to verify status of the CNI:

```
kubectl describe cniops <CNIOPS_NAME>
```

This resource is not namespaced. Use *get* to list available resources.
The output consists of some base64 encrypted configuration, however check the *.Status* field for allocated IP's per node, or inconsistencies reported.

Example output:

```
Status:
  Cni Status:
    Ipam - Scan:  Checking IPAM for inconsistencies...

Loading all IPAM blocks...
Found 3 IPAM blocks.
 IPAM block 10.4.189.0/26 affinity=host:calico-gf-master:
 IPAM block 10.4.190.192/26 affinity=host:calico-gf-worker1:
 IPAM block 10.4.251.0/26 affinity=host:calico-gf-worker2:
IPAM blocks record 13 allocations.

Loading all IPAM pools...
  10.4.0.0/16
Found 1 active IP pools.

Loading all nodes.
Found 0 node tunnel IPs.

Loading all workload endpoints.
Found 13 workload IPs.
Workloads and nodes are using 13 IPs.

Looking for top (up to 20) nodes by allocations...
  calico-gf-worker1 has 9 allocations
  calico-gf-worker2 has 2 allocations
  calico-gf-master has 2 allocations
Node with most allocations has 9; median is 2

Scanning for IPs that are allocated but not actually in use...
Found 0 IPs that are allocated in IPAM but not actually in use.
Scanning for IPs that are in use by a workload or node but not allocated in IPAM...
Found 0 in-use IPs that are not in active IP pools.
Found 0 in-use IPs that are in active IP pools but have no corresponding IPAM allocation.

Check complete; found 0 problems.

    Ipam - Status:
+----------+-------------+-----------+------------+--------------+
| GROUPING |    CIDR     | IPS TOTAL | IPS IN USE |   IPS FREE   |
+----------+-------------+-----------+------------+--------------+
| IP Pool  | 10.4.0.0/16 |     65536 | 13 (0%)    | 65523 (100%) |
+----------+-------------+-----------+------------+--------------+

    Version:  Client Version:    v3.23.2
Git commit:        a52cb86db
Cluster Version:   v3.23.2
Cluster Type:      typha,kdd,k8s,operator,bgp,kubeadm

  Cni Type:     calico
  Cni Version:  3.23
  Ipam:
+----------+-------------+-----------+------------+--------------+
| GROUPING |    CIDR     | IPS TOTAL | IPS IN USE |   IPS FREE   |
+----------+-------------+-----------+------------+--------------+
| IP Pool  | 10.4.0.0/16 |     65536 | 13 (0%)    | 65523 (100%) |
+----------+-------------+-----------+------------+--------------+

  Managed State:        New
  Observed Generation:  1
  State:                Running
  Upgrade Status:
    Cni Upgrade State:  None
Events:                 <none>
```

#### 5.2.3 Connectivity Checker and Error Pods Reporting

*Connectivity Checker* is a tool that constatly verifies and reports various connectivity paths like:
- node to External
- node to LB_VIP
- node to NodePort
- node to clusterIP
- node to node
- node to pod
- pod to External
- pod to LB_VIP
- pod to NodePort
- pod to clusterIP
- pod to node
- pod to pod
- pod to service

Verify connectivity using following command:

```
kubectl -n nettools get conncheck -oyaml
```

*Error Pods Reporting* is another tool that reports Pods in the failed state:

```
kubectl -n nettools get epr -oyaml
```

It collects outputs from various fields like events and logs and displays in single place. 

## 6. Troubleshooting

For Brownfield case:
Following notifications are required from workload cluster to initiate cluster profile creation.

Observedops:
Type should be aci-cni to initiate the process.
 
Canary Installer:
This is only a notification and will be active only as long as there is no installer with CNI spec available on the workload cluster. Type should be aci-cni to initiate the process.
 
Configmaps:
Acc-provision config: All of the fields here are important.
 
Aci-operator-config: Flavor field is important here to reconstruct acc-provision input.
 
Once all these notifications are available, the ClusterProfile and ClusterNetworkProfile will be automatically created:

```auto-<clustername>``` - [ClusterProfile](config/samples/aci-cni/kubernetes/imported/auto-clusterprofile.yaml)

```auto-<clustername>``` - [ClusterNetworkProfile](config/samples/aci-cni/kubernetes/imported/auto-clusternetworkprofile.yaml)
 

## 7. Contributing

### 7.1 Repositories
* Org Operator: [netop-org-manager](https://github.com/noironetworks/netop-org-manager)

* Fabric Operator: [netop-fabric-manager](https://github.com/noironetworks/netop-fabric-manager)

* Workload Cluster Operator: [netop-manager](https://github.com/noironetworks/netop-manager)

* Notification Types: [netop-types](https://github.com/noironetworks/netop-types)

* Manifest Generation: [acc-provision](https://github.com/noironetworks/acc-provision)

* Connectivity Checker: [nettools](https://github.com/noironetworks/nettools)

* System Tests: [acc-pytests](https://github.com/noironetworks/acc-pytests/commits/cko-mvp-1)

* Control Cluster Helm Chart: [netop-helm](https://github.com/noironetworks/netop-helm)

* Workload Cluster Manifests: [netop-manifests](https://github.com/noironetworks/netop-manifests)

* User Documentation: [cko](https://github.com/noironetworks/cko)

### 7.2 Contributing to CKO

[Developer Guide](docs/dev-guide/dev-and-contribute.md)

### 7.3 Experimenting with Control Cluster
CKO Control Cluster can be deployed in a disconnected mode from all fabrics. Edit defaults-global-fabricinfra ConfigMap:

```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: defaults-global-fabricinfra
  namespace: netop-manager
data:
  provision_fabric: "false"
```

This can also be set per fabric in the fabricinfra CR as "spec.provision_fabric: false":

```bash
apiVersion: netop.mgr/v1alpha1
kind: FabricInfra
metadata:
  name: k8s-bm-2
  namespace: netop-manager
  labels:
    fabric: on-prem-dev-infra
    site: bldg-15-lab
spec:
  ...
  provision_fabric: "false"
  ...
```