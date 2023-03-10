# API Update Reference

### Resource Types
- [FabricInfra](#fabricinfra)
- [ClusterProfile](#clusterprofile)
- [ClusterGroupProfile](#clustergroupprofile)
- [ClusterNetworkProfile](#clusternetworkprofile)


#### FabricInfra


| Property                            | Update Allowed | Update Behavior                                      |
|-------------------------------------|----------------|------------------------------------------------------|
| `hosts` _string array_              | No             | Update apic hosts after deploying cluster            |
| `name` _string_                     | No             | Apic secret name update                              |
| `username` _string_                 | No             | Update of apic username is supported only via secret |
| `password` _string_                 | No             | Update of apic password is supported only via secret |
| `fabric_type` _string_              | No             |                                                      |
| `leafs` _integer_                   | Yes            |                                                      |
| `spines` _integer_                  | Yes            |                                                      |
| `infra_vlan` _integer_              | No             |                                                      |
| `mcast_subnets` _string array_      | Yes            |                                                      |
| `external_subnets` _string array_   | Yes            |                                                      |
| `internal_subnets` _string array_   | Yes            |                                                      |
| `vlans` _integer array_             | Yes            |                                                      |
| `remote_as_numbers` _integer array_ | Yes            |                                                      |
| `aci_as_number` _integer_           | No             |                                                      |
| `id` _integer_                      | No             | Rack id update                                       |
| `aci_pod_id` _integer_              | No             |                                                      |
| `id` _integer_                      | No             | Leaf id update                                       |
| `name` _string_                     | No             | Anchor node name update                              |
| `provision_fabric` _boolean_        | Yes            | Enable/Disable provisioning of fabric                |


#### ClusterProfile

| Property                                             | Update Allowed | Update Behavior                                    |
|------------------------------------------------------|----------------|----------------------------------------------------|
| `cluster_group_profile_selector` _[LabelSelector]_   | No             | cluster group profile selector update              |
| `cluster_network_profile_selector` _[LabelSelector]_ | No             | cluster network profile selector update            |
| `cni` _string_                                       | No             | Cni update                                         |
| `cluster_name` _string_                              | No             | cluster name update                                |
| `monitoring` _string_                                | No             |                                                    |
| `system_id` _string_                                 | No             |                                                    |
| `name` _string_                                      | No             | L3Out name update                                  |
| `external_networks` _string array_                   | No             | L3Out external networks Update                     |
| `aep` _string_                                       | No             | AEP name update                                    |
| `name` _string_                                      | No             | VRF name update                                    |
| `tenant` _string_                                    | No             | VRF tenant update                                  |
| `prefixes` _integer_                                 | No             | BGP prefixes update                                |
| `node_profile_name` _string_                         | No             |                                                    |
| `int_prof_name` _string_                             | No             |                                                    |
| `floating_ip` _string_                               | No             |                                                    |
| `secondary_ip` _string_                              | No             |                                                    |
| `vlan_id` _integer_                                  | No             |                                                    |
| `mtu` _integer_                                      | No             |                                                    |
| `certfile` _string_                                  | No             |                                                    |
| `keyfile` _string_                                   | No             |                                                    |
| `client_ssl` _boolean_                               | No             |                                                    |
| `domain` _string_                                    | No             | Physical domain update                             |
| `target_version` _string_                            | Yes            | Aci cni target version update                      |
| `reboot_opflex_with_ovs` _string_                    | No             |                                                    |
| `contract_scope` _string_                            | No             | Snat contract scope update                         |
| `disable_periodic_snat_global_info_sync` _boolean_   | No             |
| `start` _integer_                                    | No             | Snat port range start update                       |
| `end` _integer_                                      | No             | Snat port range end update                         |
| `ports_per_node ` _integer_                          | No             | Snat ports per node update                         |
| `encap_type ` _string_                               | No             | Vmm domain encap type update                       |
| `start ` _string_                                    | No             | Mcast range start update                           |
| `end ` _string_                                      | No             | Mcast range end update                             |
| `type ` _string_                                     | No             | Vmm domain nested inside type update               |
| `name ` _string_                                     | No             | Vmm domain nested inside name update               |
| `installer_provisioned_lb_ip ` _string_              | No             |                                                    |
| `vlan_pool ` _string_                                | No             | Vmm domain vlan pool update                        |
| `aep` _string_                                       | No             |                                                    |
| `interface_mtu` _integer_                            | No             |                                                    |
| `extern_static` _string_                             | No             |                                                    |
| `service_vlan` _integer_                             | No             |                                                    |
| `node_svc_subnet` _string_                           | No             |                                                    |
| `acc_provision_operator_version` _string_            | No            |                                                    |
| `aci_cni_operator_version` _string_                  | No            |                                                    |
| `aci_containers_operator_version` _string_           | No            |                                                    |
| `aci_containers_controller_version` _string_         | No            |                                                    |
| `aci_containers_host_version` _string_               | No            |                                                    |
| `cnideploy_version` _string_                         | No            |                                                    |
| `opflex_agent_version` _string_                      | No            |                                                    |
| `openvswitch_version` _string_                       | No            |                                                    |
| `gbp_version` _string_                               | No            |                                                    |
| `use_privileged_containers` _boolean_                | No             |                                                    |
| `image_pull_policy` _string_                         | No            |                                                    |
| `enable_updates` _boolean_                           | Yes            | operator managed config enable update              |
| `ovs_memory_limit` _string_                          | Yes            |                                                    |
| `allow_pods_external_access` _boolean_               | Yes            |                                                    |
| `opflex_agent_prometheus` _boolean_                  | Yes            |                                                    |
| `install_istio` _boolean_                            | No             |                                                    |
| `install_profile` _string_                           | No             |                                                    |
| `node_subnet` _string_                               | No             |                                                    |
| `pod_subnet` _string_                                | No             |                                                    |
| `extern_dynamic` _string_                            | No             |                                                    |
| `kubeapi_vlan` _integer_                             | No             |                                                    |
| `cluster_svc_subnet` _string_                        | No             |                                                    |
| `image_prefix` _string_                              | Yes            |                                                    |
| `image_pull_secret` _string_                         | Yes            |                                                    |
| `network_operator_version` _string_                  | Yes            |                                                    |
| `type` _string_                                      | No             | Distro type update                                 |
| `release` _string_                                   | Yes            | Distro release update                              |
| `platform` _string_                                  | No             | Distro platform update                             |
| `flavor` _string_                                    | Yes            | Cni flavor update                                  |
| `target_version` _string_                            | Yes            | Network operator target version update             |
| `mode` _string_                                      | Yes            | CKO unmanaged vs managed modes update              |
| `enable` _boolean_                                   | Yes            | Droplog config enable/disbale update               |
| `disable` _boolean_                                  | Yes            | Multus config enable/disbale update                |
| `enable` _boolean_                                   | Yes            | Sriov config enable/disbale update                 |
| `enable` _boolean_                                   | Yes            | NodePodIF config enable/disbale update             |
| `controller_log_level` _string_                      | Yes            |                                                    |
| `hostagent_log_level` _string_                       | Yes            |                                                    |
| `opflexagent_log_level` _string_                     | Yes            |                                                    |
| `target_version` _string_                            | Yes            | Calico cni target version update                   |
| `service_mesh` _string_                              | No             | service mesh profile update                        |
| `loadbalancer` _string_                              | No             | loadbalancer profile update                        |
| `ingress` _string_                                   | No             | ingress profile update                             |
| `monitoring` _string_                                | No             | monitoring profile update                          |
| `name ` _string_                                     | No             | service mesh name update                           |
| `mesh_id` _string_                                   | No             | service mesh id update                             |
| `network` _string_                                   | No             | service mesh network update                        |
| `role` _string_                                      | No             | service mesh role update                           |
| `kubeconfig` _string_                                | No             | service mesh kubeconfig update                     |
| `monitoring_type` _string_                           | Yes            |                                                    |
| `remote_write_ip` _string_                           | Yes            |                                                    |
| `remote_write_port` _integer_                        | Yes            |                                                    |
| `lb_type` _string_                                   | No             |                                                    |
| `error_pods_reporting_enable` _boolean_              | Yes            | Connectivity checker update                        |
| `reachability_tests` _string array_                  | Yes            | Connectivity checker update                        |
| `enable_updates` _boolean_                           | Yes            | Connectivity checker Periodic sync update          |
| `interval` _integer_                                 | Yes            | Connectivity checker Periodic sync interval update |
| `url` _string_                                       | Yes            | Connectivity checker external url update           |
| `name` _string_                                      | No             | Fabric context name update                         |
| `context` _string_                                   | No             | Fabric context update                              |
| `type` _string_                                      | No             | Fabric context type update                         |



#### ClusterGroupProfile

| Property                                           | Update Allowed | Update Behavior                                    |
|----------------------------------------------------|----------------|----------------------------------------------------|
| `selector` _[LabelSelector]_                       | No             | Updates cluster group profile label selectors      |
| `type` _string_                                    | No             | Distro type update                                 |
| `release` _string_                                 | Yes            | Distro release update                              |
| `platform` _string_                                | No             | Distro platform update                             |
| `flavor` _string_                                  | Yes            | Cni flavor update                                  |
| `cni` _string_                                     | No             | Cni update                                         |
| `system_id` _string_                               | No             |                                                    |
| `name` _string_                                    | No             | L3Out name update                                  |
| `external_networks` _string array_                 | No             | L3Out external networks Update                     |
| `aep` _string_                                     | No             | AEP name update                                    |
| `node_profile_name` _string_                       | No             |                                                    |
| `int_prof_name` _string_                           | No             |                                                    |
| `floating_ip` _string_                             | No             |                                                    |
| `secondary_ip` _string_                            | No             |                                                    |
| `vlan_id` _integer_                                | No             |                                                    |
| `mtu` _integer_                                    | Yes            |                                                    |
| `remote_as_numbers` _integer array_                | Yes            |                                                    |
| `aci_as_number` _integer_                          | No             |                                                    |
| `certfile` _string_                                | No             |                                                    |
| `keyfile` _string_                                 | No             |                                                    |
| `client_ssl` _boolean_                             | No             |                                                    |
| `name` _string_                                    | No             | VRF name update                                    |
| `tenant` _string_                                  | No             | VRF tenant update                                  |
| `domain` _string_                                  | No             | Physical domain update                             |
| `target_version` _string_                          | Yes            | Aci cni target version update                      |
| `reboot_opflex_with_ovs` _string_                  | Yes            |                                                    |
| `contract_scope` _string_                          | Yes            | Snat contract scope update                         |
| `disable_periodic_snat_global_info_sync` _boolean_ | Yes            |
| `start` _integer_                                  | Yes            | Snat port range start update                       |
| `end` _integer_                                    | Yes            | Snat port range end update                         |
| `ports_per_node` _integer_                         | Yes            | Snat ports per node update                         |
| `encap_type` _string_                              | No             | Vmm domain encap type update                       |
| `start` _string_                                   | No             | Mcast range start update                           |
| `end` _string_                                     | No             | Mcast range end update                             |
| `type` _string_                                    | No             | Vmm domain nested inside type update               |
| `name` _string_                                    | No             | Vmm domain nested inside name update               |
| `installer_provisioned_lb_ip` _string_             | No             |                                                    |
| `vlan_pool ` _string_                              | No             | Vmm domain vlan pool update                        |
| `elag_name ` _string_                              | No             | Elag update                                        |
| `interface_mtu` _integer_                          | Yes            |                                                    |
| `extern_static` _string_                           | No             |                                                    |
| `service_vlan` _integer_                           | No             |                                                    |
| `node_svc_subnet` _string_                         | No             |                                                    |
| `acc_provision_operator_version` _string_          | Yes            |                                                    |
| `aci_cni_operator_version` _string_                | Yes            |                                                    |
| `aci_containers_operator_version` _string_         | Yes            |                                                    |
| `aci_containers_controller_version` _string_       | Yes            |                                                    |
| `aci_containers_host_version` _string_             | Yes            |                                                    |
| `cnideploy_version` _string_                       | Yes            |                                                    |
| `opflex_agent_version` _string_                    | Yes            |                                                    |
| `openvswitch_version` _string_                     | Yes            |                                                    |
| `gbp_version` _string_                             | Yes            |                                                    |
| `use_privileged_containers` _boolean_              | No             |                                                    |
| `image_pull_policy` _string_                       | Yes            |                                                    |
| `enable_updates` _boolean_                         | Yes            | operator managed config enable update              |
| `ovs_memory_limit` _string_                        | Yes            |                                                    |
| `allow_pods_external_access` _boolean_             | No             |                                                    |
| `opflex_agent_prometheus` _boolean_                | No             |                                                    |
| `install_istio` _boolean_                          | No             |                                                    |
| `install_profile` _string_                         | No             |                                                    |
| `enable` _boolean_                                 | Yes            | Droplog config enable/disbale update               |
| `disable` _boolean_                                | Yes            | Multus config enable/disbale update                |
| `enable` _boolean_                                 | Yes            | Sriov config enable/disbale update                 |
| `enable` _boolean_                                 | Yes            | NodePodIF config enable/disbale update             |
| `controller_log_level` _string_                    | Yes            |                                                    |
| `hostagent_log_level` _string_                     | Yes            |                                                    |
| `opflexagent_log_level` _string_                   | Yes            |                                                    |
| `node_subnet` _string_                             | No             |                                                    |
| `pod_subnet` _string_                              | No             |                                                    |
| `extern_dynamic` _string_                          | No             |                                                    |
| `kubeapi_vlan` _integer_                           | No             |                                                    |
| `cluster_svc_subnet` _string_                      | No             |                                                    |
| `image_prefix` _string_                            | Yes            |                                                    |
| `image_pull_secret` _string_                       | Yes            |                                                    |
| `network_operator_version` _string_                | Yes            |                                                    |
| `target_version` _string_                          | Yes            | Calico cni target version update                   |
| `service_mesh` _string_                            | No             | service mesh profile update                        |
| `loadbalancer` _string_                            | No             | loadbalancer profile update                        |
| `ingress` _string_                                 | No             | ingress profile update                             |
| `monitoring` _string_                              | No             | monitoring profile update                          |
| `name ` _string_                                   | No             | service mesh name update                           |
| `mesh_id` _string_                                 | No             | service mesh id update                             |
| `network` _string_                                 | No             | service mesh network update                        |
| `role` _string_                                    | No             | service mesh role update                           |
| `kubeconfig` _string_                              | No             | service mesh kubeconfig update                     |
| `monitoring_type` _string_                         | Yes            |                                                    |
| `remote_write_ip` _string_                         | Yes            |                                                    |
| `remote_write_port` _integer_                      | Yes            |                                                    |
| `lb_type` _string_                                 | No             |                                                    |
| `cni` _string_                                     | No             | Cni update                                         |
| `https_proxy` _string_                             | No             | https_proxy update                                 |
| `http_proxy` _string_                              | No             | http_proxy update                                  |
| `no_proxy` _string_                                | No             | no_proxy update                                    |
| `id` _integer_                                     | No             | Rack id update                                     |
| `aci_pod_id` _integer_                             | No             |                                                    |
| `id` _integer_                                     | No             | Leaf id update                                     |
| `name` _string_                                    | No             | Anchor node name update                            |
| `type` _string_                                    | No             | Distro type update                                 |
| `release` _string_                                 | Yes            | Distro release update                              |
| `platform` _string_                                | No             | Distro platform update                             |
| `flavor` _string_                                  | Yes            | Cni flavor update                                  |
| `target_version` _string_                          | Yes            | Network operator target version update             |
| `mode` _string_                                    | Yes            | CKO unmanaged vs managed modes update              |
| `error_pods_reporting_enable` _boolean_            | Yes            | Connectivity checker update                        |
| `reachability_tests` _string array_                | Yes            | Connectivity checker update                        |
| `enable_updates` _boolean_                         | Yes            | Connectivity checker Periodic sync update          |
| `interval` _integer_                               | Yes            | Connectivity checker Periodic sync interval update |
| `url` _string_                                     | Yes            | Connectivity checker external url update           |
| `name` _string_                                    | No             | Fabric context name update                         |
| `context` _string_                                 | No             | Fabric context update                              |
| `type` _string_                                    | No             | Fabric context type update                         |
| `base64_encoded_argo_manifests` _string_           | No             | base64_encoded_argo_manifests update                         |
| `cluster_profile_name` _string_                    | No             | cluster_profile_name update                         |



#### ClusterNetworkProfile

| Property                                           | Update Allowed | Update Behavior                                    |
|----------------------------------------------------|----------------|----------------------------------------------------|
| `system_id` _string_                               | No             |                                                    |
| `name` _string_                                    | No             | L3Out name update                                  |
| `external_networks` _string array_                 | No             | L3Out external networks Update                     |
| `aep` _string_                                     | No             | AEP name update                                    |
| `node_profile_name` _string_                       | No             |                                                    |
| `int_prof_name` _string_                           | No             |                                                    |
| `floating_ip` _string_                             | No             |                                                    |
| `secondary_ip` _string_                            | No             |                                                    |
| `vlan_id` _integer_                                | No             |                                                    |
| `mtu` _integer_                                    | No            |                                                    |
| `remote_as_numbers` _integer array_                | No            |                                                    |
| `aci_as_number` _integer_                          | No             |                                                    |
| `prefixes` _integer_                               | No             | BGP prefixes update                                |
| `certfile` _string_                                | No             |                                                    |
| `keyfile` _string_                                 | No             |                                                    |
| `client_ssl` _boolean_                             | No             |                                                    |
| `name` _string_                                    | No             | VRF name update                                    |
| `tenant` _string_                                  | No             | VRF tenant update                                  |
| `domain` _string_                                  | No             | Physical domain update                             |
| `target_version` _string_                          | No            | Aci cni target version update                      |
| `reboot_opflex_with_ovs` _string_                  | No            |                                                    |
| `contract_scope` _string_                          | No            | Snat contract scope update                         |
| `disable_periodic_snat_global_info_sync` _boolean_ | No            |                                                    |
| `start` _integer_                                  | No            | Snat port range start update                       |
| `end` _integer_                                    | No            | Snat port range end update                         |
| `ports_per_node` _integer_                         | No            | Snat ports per node update                         |
| `encap_type` _string_                              | No             | Vmm domain encap type update                       |
| `start` _string_                                   | No             | Mcast range start update                           |
| `end` _string_                                     | No             | Mcast range end update                             |
| `type` _string_                                    | No             | Vmm domain nested inside type update               |
| `name` _string_                                    | No             | Vmm domain nested inside name update               |
| `installer_provisioned_lb_ip` _string_             | No             |                                                    |
| `vlan_pool ` _string_                              | No             | Vmm domain vlan pool update                        |
| `elag_name ` _string_                              | No             | Elag update                                        |
| `interface_mtu` _integer_                          | No            |                                                    |
| `extern_static` _string_                           | No             |                                                    |
| `service_vlan` _integer_                           | No             |                                                    |
| `node_svc_subnet` _string_                         | No             |                                                    |
| `acc_provision_operator_version` _string_          | No            |                                                    |
| `aci_cni_operator_version` _string_                | No            |                                                    |
| `aci_containers_operator_version` _string_         | No            |                                                    |
| `aci_containers_controller_version` _string_       | No            |                                                    |
| `aci_containers_host_version` _string_             | No            |                                                    |
| `cnideploy_version` _string_                       | No            |                                                    |
| `opflex_agent_version` _string_                    | No            |                                                    |
| `openvswitch_version` _string_                     | No            |                                                    |
| `gbp_version` _string_                             | No            |                                                    |
| `use_privileged_containers` _boolean_              | No             |                                                    |
| `image_pull_policy` _string_                       | No            |                                                    |
| `enable_updates` _boolean_                         | No            | operator managed config enable update              |
| `ovs_memory_limit` _string_                        | No            |                                                    |
| `install_istio` _boolean_                          | No             |                                                    |
| `install_profile` _string_                         | No             |                                                    |
| `enable` _boolean_                                 | No            | Droplog config enable/disbale update               |
| `disable` _boolean_                                | No            | Multus config enable/disbale update                |
| `enable` _boolean_                                 | No            | Sriov config enable/disbale update                 |
| `enable` _boolean_                                 | No            | NodePodIF config enable/disbale update             |
| `allow_pods_external_access` _boolean_             | No             |                                                    |
| `opflex_agent_prometheus` _boolean_                | No             |                                                    |
| `controller_log_level` _string_                    | No            |                                                    |
| `hostagent_log_level` _string_                     | No            |                                                    |
| `opflexagent_log_level` _string_                   | No            |                                                    |
| `node_subnet` _string_                             | No             |                                                    |
| `pod_subnet` _string_                              | No             |                                                    |
| `extern_dynamic` _string_                          | No             |                                                    |
| `kubeapi_vlan` _integer_                           | No             |                                                    |
| `cluster_svc_subnet` _string_                      | No             |                                                    |
| `image_prefix` _string_                            | No            |                                                    |
| `image_pull_secret` _string_                       | No            |                                                    |
| `network_operator_version` _string_                | No            |                                                    |
| `target_version` _string_                          | No            | Calico cni target version update                   |
| `service_mesh` _string_                            | No             | service mesh profile update                        |
| `loadbalancer` _string_                            | No             | loadbalancer profile update                        |
| `ingress` _string_                                 | No             | ingress profile update                             |
| `monitoring` _string_                              | No             | monitoring profile update                          |
| `name ` _string_                                   | No             | service mesh name update                           |
| `mesh_id` _string_                                 | No             | service mesh id update                             |
| `network` _string_                                 | No             | service mesh network update                        |
| `role` _string_                                    | No             | service mesh role update                           |
| `kubeconfig` _string_                              | No             | service mesh kubeconfig update                     |
| `monitoring_type` _string_                         | No            |                                                    |
| `remote_write_ip` _string_                         | No            |                                                    |
| `remote_write_port` _integer_                      | No            |                                                    |
| `lb_type` _string_                                 | No             |                                                    |
| `cni` _string_                                     | No             | Cni update                                         |
| `https_proxy` _string_                             | No             | https_proxy update                                 |
| `http_proxy` _string_                              | No             | http_proxy update                                  |
| `no_proxy` _string_                                | No             | no_proxy update                                    |
| `id` _integer_                                     | No             | Rack id update                                     |
| `aci_pod_id` _integer_                             | No             |                                                    |
| `id` _integer_                                     | No             | Leaf id update                                     |
| `name` _string_                                    | No             | Anchor node name update                            |
| `type` _string_                                    | No             | Distro type update                                 |
| `release` _string_                                 | No            | Distro release update                              |
| `platform` _string_                                | No             | Distro platform update                             |
| `flavor` _string_                                  | No            | Cni flavor update                                  |
| `target_version` _string_                          | No            | Network operator target version update             |
| `mode` _string_                                    | No            | CKO unmanaged vs managed modes update              |
| `error_pods_reporting_enable` _boolean_            | No            | Connectivity checker update                        |
| `reachability_tests` _string array_                | No            | Connectivity checker update                        |
| `enable_updates` _boolean_                         | No            | Connectivity checker Periodic sync update          |
| `interval` _integer_                               | No            | Connectivity checker Periodic sync interval update |
| `url` _string_                                     | No            | Connectivity checker external url update           |
| `name` _string_                                    | No             | Fabric context name update                         |
| `context` _string_                                 | No             | Fabric context update                              |
| `type` _string_                                    | No             | Fabric context type update                         |
| `base64_encoded_argo_manifests` _string_           | No             | base64_encoded_argo_manifests update               |
| `cluster_profile_name` _string_                    | No             | cluster_profile_name update                        |
