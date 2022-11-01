# API Reference

## Packages
- [netop.mgr/v1alpha1](#netopmgrv1alpha1)


## netop.mgr/v1alpha1

Package v1alpha1 contains API Schema definitions for the netop.mgr v1alpha1 API group

### Resource Types
- [FabricInfra](#fabricinfra)
- [ClusterProfile](#clusterprofile)
- [ClusterGroupProfile](#clustergroupprofile)



#### AciCniConfigSpec





_Appears in:_
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `target_version` _string_ |  |
| `reboot_opflex_with_ovs` _string_ |  |
| `snat_operator` _[SnatSpec](#snatspec)_ |  |
| `aci_config` _[AciConfigStruct](#aciconfigstruct)_ |  |
| `net_config` _[AciNetConfigSpec](#acinetconfigspec)_ |  |
| `registry` _[AciRegistryStruct](#aciregistrystruct)_ |  |
| `kube_config` _[KubeConfigSpec](#kubeconfigspec)_ |  |
| `logging` _[LoggingSpec](#loggingspec)_ |  |


#### AciConfigSpec





_Appears in:_
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `fabric_infra` _string_ |  |
| `system_id` _string_ |  |
| `l3out` _[L3OutSpec](#l3outspec)_ |  |
| `cluster_l3out` _[ClusterL3OutSpec](#clusterl3outspec)_ |  |
| `sync_login` _[SyncLoginSpec](#syncloginspec)_ |  |
| `client_ssl` _boolean_ |  |
| `vrf` _[VrfSpec](#vrfspec)_ |  |
| `physical_domain` _[PhysicalDomainSpec](#physicaldomainspec)_ |  |


#### AciConfigStruct





_Appears in:_
- [AciCniConfigSpec](#acicniconfigspec)

| Field | Description |
| --- | --- |
| `vmm_domain` _[VmmDomainSpec](#vmmdomainspec)_ |  |
| `aep` _string_ |  |


#### AciNetConfigSpec





_Appears in:_
- [AciCniConfigSpec](#acicniconfigspec)

| Field | Description |
| --- | --- |
| `interface_mtu` _integer_ |  |
| `extern_static` _string_ |  |
| `service_vlan` _integer_ |  |
| `node_svc_subnet` _string_ |  |


#### AciRegistryStruct





_Appears in:_
- [AciCniConfigSpec](#acicniconfigspec)

| Field | Description |
| --- | --- |
| `acc_provision_operator_version` _string_ |  |
| `aci_cni_operator_version` _string_ |  |
| `aci_containers_operator_version` _string_ |  |
| `aci_containers_controller_version` _string_ |  |
| `aci_containers_host_version` _string_ |  |
| `cnideploy_version` _string_ |  |
| `opflex_agent_version` _string_ |  |
| `openvswitch_version` _string_ |  |
| `gbp_version` _string_ |  |


#### AllocatedSpec





_Appears in:_
- [FabricInfraStatus](#fabricinfrastatus)

| Field | Description |
| --- | --- |
| `cluster_group_profile` _string_ |  |
| `cluster_profile` _string_ |  |
| `mcast_subnets` _string array_ |  |
| `external_subnets` _string array_ |  |
| `internal_subnets` _string array_ |  |
| `vlans` _integer array_ |  |
| `context` _[ContextSpec](#contextspec)_ |  |
| `remote_as_numbers` _integer array_ |  |


#### ApicSecretRef





_Appears in:_
- [CredentialsSpec](#credentialsspec)

| Field | Description |
| --- | --- |
| `name` _string_ | Secret name |
| `username` _string_ | Key name that contains username |
| `password` _string_ | Key name that contains password |


#### AvailableSpec





_Appears in:_
- [FabricInfraStatus](#fabricinfrastatus)

| Field | Description |
| --- | --- |
| `mcast_subnets` _string array_ |  |
| `external_subnets` _string array_ |  |
| `internal_subnets` _string array_ |  |
| `vlans` _integer array_ |  |
| `contexts` _object (keys:string, values:[ContextSpec](#contextspec))_ |  |
| `remote_as_numbers` _integer array_ |  |


#### BGPSpec





_Appears in:_
- [FabricInfraSpec](#fabricinfraspec)

| Field | Description |
| --- | --- |
| `remote_as_numbers` _integer array_ |  |
| `aci_as_number` _integer_ |  |


#### BgpSpec





_Appears in:_
- [ClusterL3OutSpec](#clusterl3outspec)

| Field | Description |
| --- | --- |
| `peering` _[PeeringSpec](#peeringspec)_ |  |


#### CalicoCniConfigSpec





_Appears in:_
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `target_version` _string_ |  |


#### ClToFabMap





_Appears in:_
- [ClusterGroupProfileStatus](#clustergroupprofilestatus)

| Field | Description |
| --- | --- |
| `cluster` _string_ |  |
| `fabric` _string_ |  |


#### ClusterGroupProfile



ClusterGroupProfile is the Schema for the clustergroupprofiles API

_Appears in:_
- [ClusterGroupProfileList](#clustergroupprofilelist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterGroupProfile`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[ClusterGroupProfileSpec](#clustergroupprofilespec)_ |  |


#### ClusterGroupProfileList



ClusterGroupProfileList contains a list of ClusterGroupProfile



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterGroupProfileList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[ClusterGroupProfile](#clustergroupprofile) array_ |  |


#### ClusterGroupProfileSpec



ClusterGroupProfileSpec defines the desired state of ClusterGroupProfile

_Appears in:_
- [ClusterGroupProfile](#clustergroupprofile)

| Field | Description |
| --- | --- |
| `selector` _[LabelSelector](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#labelselector-v1-meta)_ |  |
| `config_overrides` _[ClusterInfoConfigSpec](#clusterinfoconfigspec)_ |  |




#### ClusterInfo



ClusterInfo is the Schema for the clusterinfoes API

_Appears in:_
- [ClusterInfoList](#clusterinfolist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterInfo`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[ClusterInfoSpec](#clusterinfospec)_ |  |


#### ClusterInfoConfigSpec





_Appears in:_
- [ClusterGroupProfileSpec](#clustergroupprofilespec)
- [ClusterInfoSpec](#clusterinfospec)

| Field | Description |
| --- | --- |
| `aci_config` _[AciConfigSpec](#aciconfigspec)_ |  |
| `aci_cni_config` _[AciCniConfigSpec](#acicniconfigspec)_ |  |
| `net_config` _[NetConfigSpec](#netconfigspec)_ |  |
| `registry` _[RegistrySpec](#registryspec)_ |  |
| `calico_cni_config` _[CalicoCniConfigSpec](#calicocniconfigspec)_ |  |
| `profile` _[ProfileSpec](#profilespec)_ |  |
| `service_mesh_config` _[ServiceMeshSpec](#servicemeshspec)_ |  |
| `service_mesh_topology` _[ServiceMeshSpec](#servicemeshspec) array_ |  |
| `cko_git_config` _[GitConfigSpec](#gitconfigspec)_ |  |
| `monitoring_config` _[MonitoringConfigSpec](#monitoringconfigspec)_ |  |
| `lb_config` _[LbConfigSpec](#lbconfigspec)_ |  |
| `cni` _string_ |  |
| `cko_proxy_config` _[ProxyConfigSpec](#proxyconfigspec)_ |  |
| `topology` _[TopologyConfigSpec](#topologyconfigspec)_ |  |
| `context` _[ContextSpec](#contextspec)_ |  |
| `distro` _[DistroSpec](#distrospec)_ |  |
| `operator_config` _[OperatorSpec](#operatorspec)_ |  |
| `connectivity_checker` _[ConnCheckerConfigSpec](#conncheckerconfigspec)_ |  |
| `fabricinfra` _[FabricContext](#fabriccontext)_ |  |


#### ClusterInfoList



ClusterInfoList contains a list of ClusterInfo



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterInfoList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[ClusterInfo](#clusterinfo) array_ |  |


#### ClusterInfoSpec





_Appears in:_
- [ClusterInfo](#clusterinfo)

| Field | Description |
| --- | --- |
| `config_overrides` _[ClusterInfoConfigSpec](#clusterinfoconfigspec)_ |  |




#### ClusterL3OutSpec





_Appears in:_
- [AciConfigSpec](#aciconfigspec)

| Field | Description |
| --- | --- |
| `aep` _string_ |  |
| `svi` _[SviSpec](#svispec)_ |  |
| `bgp` _[BgpSpec](#bgpspec)_ |  |


#### ClusterOutput



ClusterOutput is the Schema for the clusteroutputs API

_Appears in:_
- [ClusterOutputList](#clusteroutputlist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterOutput`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[ClusterOutputSpec](#clusteroutputspec)_ |  |


#### ClusterOutputConfigSpec





_Appears in:_
- [ClusterOutputSpec](#clusteroutputspec)

| Field | Description |
| --- | --- |
| `artifacts` _[ArtifactsSpec](#artifactsspec)_ |  |


#### ClusterOutputList



ClusterOutputList contains a list of ClusterOutput



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterOutputList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[ClusterOutput](#clusteroutput) array_ |  |


#### ClusterOutputSpec



ClusterOutputSpec defines the desired state of ClusterOutput

_Appears in:_
- [ClusterOutput](#clusteroutput)

| Field | Description |
| --- | --- |
| `cluster_output` _[ClusterOutputConfigSpec](#clusteroutputconfigspec)_ | INSERT ADDITIONAL SPEC FIELDS - desired state of cluster Important: Run "make" to regenerate code after modifying this file |




#### ClusterProfile



ClusterProfile is the Schema for the clusterprofiles API

_Appears in:_
- [ClusterProfileList](#clusterprofilelist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterProfile`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[ClusterProfileSpec](#clusterprofilespec)_ |  |


#### ClusterProfileList



ClusterProfileList contains a list of ClusterProfile



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `ClusterProfileList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[ClusterProfile](#clusterprofile) array_ |  |


#### ClusterProfileSpec



ClusterProfileSpec defines the desired state of ClusterProfile

_Appears in:_
- [ClusterProfile](#clusterprofile)

| Field | Description |
| --- | --- |
| `cluster_group_profile_selector` _[LabelSelector](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#labelselector-v1-meta)_ |  |
| `cluster_network_profile_selector` _[LabelSelector](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#labelselector-v1-meta)_ |  |
| `cni` _string_ |  |
| `cluster_name` _string_ |  |
| `service_mesh` _string_ |  |
| `loadbalancer` _string_ |  |
| `ingress` _string_ |  |
| `monitoring` _string_ |  |
| `config_overrides` _[ConfigOverridesSpec](#configoverridesspec)_ |  |
| `fabricinfra` _[FabricContext](#fabriccontext)_ |  |
| `distro` _[DistroSpec](#distrospec)_ |  |
| `operator_config` _[OperatorSpec](#operatorspec)_ |  |



#### ConfigOverridesSpec





_Appears in:_
- [ClusterProfileSpec](#clusterprofilespec)

| Field | Description |
| --- | --- |
| `aci_config` _[AciConfigSpec](#aciconfigspec)_ |  |
| `aci_cni_config` _[AciCniConfigSpec](#acicniconfigspec)_ |  |
| `net_config` _[NetConfigSpec](#netconfigspec)_ |  |
| `registry` _[RegistrySpec](#registryspec)_ |  |
| `calico_cni_config` _[CalicoCniConfigSpec](#calicocniconfigspec)_ |  |
| `service_mesh_config` _[ServiceMeshSpec](#servicemeshspec)_ |  |
| `service_mesh_topology` _[ServiceMeshSpec](#servicemeshspec) array_ |  |
| `cko_git_config` _[GitConfigSpec](#gitconfigspec)_ |  |
| `monitoring_config` _[MonitoringConfigSpec](#monitoringconfigspec)_ |  |
| `lb_config` _[LbConfigSpec](#lbconfigspec)_ |  |
| `cko_proxy_config` _[ProxyConfigSpec](#proxyconfigspec)_ |  |
| `connectivity_checker` _[ConnCheckerConfigSpec](#conncheckerconfigspec)_ |  |


#### ConnCheckerConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `error_pods_reporting_enable` _boolean_ |  |
| `reachability_test_enable` _[ReachabilityTestSpec](#reachabilitytestspec)_ |  |
| `reachability_tests` _string array_ |  |


#### ContextSpec





_Appears in:_
- [AllocatedSpec](#allocatedspec)
- [AvailableSpec](#availablespec)
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ClusterProfileStatus](#clusterprofilestatus)
- [FabricInfraSpec](#fabricinfraspec)

| Field | Description |
| --- | --- |
| `aep` _string_ |  |
| `vrf` _[VrfSpec](#vrfspec)_ |  |
| `l3out` _[L3OutSpec](#l3outspec)_ |  |


#### CredentialsSpec





_Appears in:_
- [FabricInfraSpec](#fabricinfraspec)

| Field | Description |
| --- | --- |
| `hosts` _string array_ |  |
| `secretRef` _[ApicSecretRef](#apicsecretref)_ |  |


#### DistroSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ClusterProfileSpec](#clusterprofilespec)

| Field | Description |
| --- | --- |
| `type` _string_ |  |
| `release` _string_ |  |
| `platform` _string_ |  |
| `flavor` _string_ |  |


#### DropLogConfigSpec





_Appears in:_
- [KubeConfigSpec](#kubeconfigspec)

| Field | Description |
| --- | --- |
| `enable` _boolean_ |  |


#### ExternalUrlSpec





_Appears in:_
- [ReachabilityTestSpec](#reachabilitytestspec)

| Field | Description |
| --- | --- |
| `url` _string_ |  |


#### FabricContext





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ClusterProfileSpec](#clusterprofilespec)
- [ClusterProfileStatus](#clusterprofilestatus)

| Field | Description |
| --- | --- |
| `name` _string_ |  |
| `context` _string_ |  |
| `type` _string_ |  |


#### FabricInfra



FabricInfra is the Schema for the fabricinfras API

_Appears in:_
- [FabricInfraList](#fabricinfralist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `FabricInfra`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[FabricInfraSpec](#fabricinfraspec)_ |  |


#### FabricInfraList



FabricInfraList contains a list of FabricInfra



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `netop.mgr/v1alpha1`
| `kind` _string_ | `FabricInfraList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[FabricInfra](#fabricinfra) array_ |  |


#### FabricInfraSpec



FabricInfraSpec defines the desired state of FabricInfra

_Appears in:_
- [FabricInfra](#fabricinfra)

| Field | Description |
| --- | --- |
| `credentials` _[CredentialsSpec](#credentialsspec)_ | INSERT ADDITIONAL SPEC FIELDS - desired state of cluster Important: Run "make" to regenerate code after modifying this file |
| `fabric_type` _string_ |  |
| `leafs` _integer_ |  |
| `spines` _integer_ |  |
| `infra_vlan` _integer_ |  |
| `mcast_subnets` _string array_ |  |
| `external_subnets` _string array_ |  |
| `internal_subnets` _string array_ |  |
| `vlans` _integer array_ |  |
| `bgp` _[BGPSpec](#bgpspec)_ |  |
| `contexts` _object (keys:string, values:[ContextSpec](#contextspec))_ |  |
| `topology` _[TopologySpec](#topologyspec)_ |  |
| `provision_fabric` _boolean_ |  |




#### GitConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `git_repo` _string_ |  |
| `git_dir` _string_ |  |
| `git_branch` _string_ |  |
| `git_token` _string_ |  |
| `git_user` _string_ |  |
| `git_email` _string_ |  |
| `sleep_duration` _integer_ |  |


#### IstioConfigSpec





_Appears in:_
- [KubeConfigSpec](#kubeconfigspec)

| Field | Description |
| --- | --- |
| `install_istio` _boolean_ |  |
| `install_profile` _string_ |  |


#### KubeConfigSpec





_Appears in:_
- [AciCniConfigSpec](#acicniconfigspec)

| Field | Description |
| --- | --- |
| `use_privileged_containers` _boolean_ |  |
| `image_pull_policy` _string_ |  |
| `operator_managed_config` _[OperatorConfigSpec](#operatorconfigspec)_ |  |
| `ovs_memory_limit` _string_ |  |
| `istio_config` _[IstioConfigSpec](#istioconfigspec)_ |  |
| `drop_log_config` _[DropLogConfigSpec](#droplogconfigspec)_ |  |
| `multus` _[MultusSpec](#multusspec)_ |  |
| `sriov_config` _[SriovConfigSpec](#sriovconfigspec)_ |  |
| `nodepodif_config` _[NodePodIFConfigSpec](#nodepodifconfigspec)_ |  |
| `allow_pods_external_access` _boolean_ |  |
| `opflex_agent_prometheus` _boolean_ |  |


#### L3OutSpec





_Appears in:_
- [AciConfigSpec](#aciconfigspec)
- [ContextSpec](#contextspec)

| Field | Description |
| --- | --- |
| `name` _string_ |  |
| `external_networks` _string array_ |  |


#### LbConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `lb_type` _string_ |  |


#### LeafConfigSpec





_Appears in:_
- [RackConfigSpec](#rackconfigspec)

| Field | Description |
| --- | --- |
| `id` _integer_ |  |
| `local_ip` _string_ |  |


#### LeafSpec





_Appears in:_
- [RackSpec](#rackspec)

| Field | Description |
| --- | --- |
| `id` _integer_ |  |


#### LoggingSpec





_Appears in:_
- [AciCniConfigSpec](#acicniconfigspec)

| Field | Description |
| --- | --- |
| `controller_log_level` _string_ |  |
| `hostagent_log_level` _string_ |  |
| `opflexagent_log_level` _string_ |  |


#### McastRangeSpec





_Appears in:_
- [VmmDomainSpec](#vmmdomainspec)

| Field | Description |
| --- | --- |
| `start` _string_ |  |
| `end` _string_ |  |


#### MonitoringConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `monitoring_type` _string_ |  |
| `remote_write_ip` _string_ |  |
| `remote_write_port` _integer_ |  |


#### MultusSpec





_Appears in:_
- [KubeConfigSpec](#kubeconfigspec)

| Field | Description |
| --- | --- |
| `disable` _boolean_ |  |


#### NestedInsideSpec





_Appears in:_
- [VmmDomainSpec](#vmmdomainspec)

| Field | Description |
| --- | --- |
| `type` _string_ |  |
| `name` _string_ |  |
| `installer_provisioned_lb_ip` _string_ |  |
| `vlan_pool` _string_ |  |


#### NetConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `node_subnet` _string_ |  |
| `pod_subnet` _string_ |  |
| `extern_dynamic` _string_ |  |
| `kubeapi_vlan` _integer_ |  |
| `cluster_svc_subnet` _string_ |  |


#### NodePodIFConfigSpec





_Appears in:_
- [KubeConfigSpec](#kubeconfigspec)

| Field | Description |
| --- | --- |
| `enable` _boolean_ |  |


#### NodeSpec





_Appears in:_
- [RackConfigSpec](#rackconfigspec)
- [RackSpec](#rackspec)

| Field | Description |
| --- | --- |
| `name` _string_ |  |


#### OperatorConfigSpec





_Appears in:_
- [KubeConfigSpec](#kubeconfigspec)

| Field | Description |
| --- | --- |
| `enable_updates` _boolean_ |  |


#### OperatorSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ClusterProfileSpec](#clusterprofilespec)

| Field | Description |
| --- | --- |
| `target_version` _string_ |  |
| `mode` _string_ |  |


#### OperatorStatusSpec





_Appears in:_
- [ClusterProfileStatus](#clusterprofilestatus)

| Field | Description |
| --- | --- |
| `version` _string_ |  |
| `mode` _string_ |  |


#### PeeringSpec





_Appears in:_
- [BgpSpec](#bgpspec)

| Field | Description |
| --- | --- |
| `remote_as_number` _integer_ |  |
| `aci_as_number` _integer_ |  |
| `prefixes` _integer_ |  |


#### PeriodicSyncSpec





_Appears in:_
- [ReachabilityTestSpec](#reachabilitytestspec)

| Field | Description |
| --- | --- |
| `enable_updates` _boolean_ |  |
| `interval` _integer_ |  |


#### PhysicalDomainSpec





_Appears in:_
- [AciConfigSpec](#aciconfigspec)

| Field | Description |
| --- | --- |
| `domain` _string_ |  |


#### PortRangeSpec





_Appears in:_
- [SnatSpec](#snatspec)

| Field | Description |
| --- | --- |
| `start` _integer_ |  |
| `end` _integer_ |  |
| `ports_per_node` _integer_ |  |


#### ProfileSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)

| Field | Description |
| --- | --- |
| `service_mesh` _string_ |  |
| `loadbalancer` _string_ |  |
| `ingress` _string_ |  |
| `monitoring` _string_ |  |


#### ProxyConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `https_proxy` _string_ |  |
| `http_proxy` _string_ |  |
| `no_proxy` _string_ |  |


#### RackConfigSpec





_Appears in:_
- [TopologyConfigSpec](#topologyconfigspec)

| Field | Description |
| --- | --- |
| `id` _integer_ |  |
| `aci_pod_id` _integer_ |  |
| `leaf` _[LeafConfigSpec](#leafconfigspec) array_ |  |
| `node` _[NodeSpec](#nodespec) array_ |  |


#### RackSpec





_Appears in:_
- [TopologySpec](#topologyspec)

| Field | Description |
| --- | --- |
| `id` _integer_ |  |
| `aci_pod_id` _integer_ |  |
| `leaf` _[LeafSpec](#leafspec) array_ |  |
| `node` _[NodeSpec](#nodespec) array_ |  |


#### ReachabilityTestSpec





_Appears in:_
- [ConnCheckerConfigSpec](#conncheckerconfigspec)

| Field | Description |
| --- | --- |
| `periodic_sync` _[PeriodicSyncSpec](#periodicsyncspec)_ |  |
| `external_url` _[ExternalUrlSpec](#externalurlspec)_ |  |


#### RegistrySpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)
- [ConfigOverridesSpec](#configoverridesspec)

| Field | Description |
| --- | --- |
| `image_prefix` _string_ |  |
| `image_pull_secret` _string_ |  |
| `network_operator_version` _string_ |  |


#### SnatSpec





_Appears in:_
- [AciCniConfigSpec](#acicniconfigspec)

| Field | Description |
| --- | --- |
| `port_range` _[PortRangeSpec](#portrangespec)_ |  |
| `contract_scope` _string_ |  |
| `disable_periodic_snat_global_info_sync` _boolean_ |  |


#### SriovConfigSpec





_Appears in:_
- [KubeConfigSpec](#kubeconfigspec)

| Field | Description |
| --- | --- |
| `enable` _boolean_ |  |


#### SviSpec





_Appears in:_
- [ClusterL3OutSpec](#clusterl3outspec)

| Field | Description |
| --- | --- |
| `node_profile_name` _string_ |  |
| `int_prof_name` _string_ |  |
| `floating_ip` _string_ |  |
| `secondary_ip` _string_ |  |
| `vlan_id` _integer_ |  |
| `mtu` _integer_ |  |


#### SyncLoginSpec





_Appears in:_
- [AciConfigSpec](#aciconfigspec)

| Field | Description |
| --- | --- |
| `certfile` _string_ |  |
| `keyfile` _string_ |  |


#### TopologyConfigSpec





_Appears in:_
- [ClusterInfoConfigSpec](#clusterinfoconfigspec)

| Field | Description |
| --- | --- |
| `rack` _[RackConfigSpec](#rackconfigspec) array_ |  |


#### TopologySpec





_Appears in:_
- [FabricInfraSpec](#fabricinfraspec)

| Field | Description |
| --- | --- |
| `rack` _[RackSpec](#rackspec) array_ |  |


#### VmmDomainSpec





_Appears in:_
- [AciConfigStruct](#aciconfigstruct)

| Field | Description |
| --- | --- |
| `encap_type` _string_ |  |
| `mcast_range` _[McastRangeSpec](#mcastrangespec)_ |  |
| `nested_inside` _[NestedInsideSpec](#nestedinsidespec)_ |  |


#### VrfSpec





_Appears in:_
- [AciConfigSpec](#aciconfigspec)
- [ContextSpec](#contextspec)

| Field | Description |
| --- | --- |
| `name` _string_ |  |
| `tenant` _string_ |  |

