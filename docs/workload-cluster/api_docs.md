# API Reference

## Packages
- [controller.netop-manager.io/v1alpha1](#controllernetop-manageriov1alpha1)
- [network-function.netop-manager.io/v1alpha1](#network-functionnetop-manageriov1alpha1)


## controller.netop-manager.io/v1alpha1

Package v1alpha1 contains API Schema definitions for the controller v1alpha1 API group

### Resource Types
- [Installer](#installer)
- [InstallerList](#installerlist)



#### Installer



Installer is the Schema for the installers API

_Appears in:_
- [InstallerList](#installerlist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `controller.netop-manager.io/v1alpha1`
| `kind` _string_ | `Installer`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[InstallerSpec](#installerspec)_ |  |


#### InstallerList



InstallerList contains a list of Installer.



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `controller.netop-manager.io/v1alpha1`
| `kind` _string_ | `InstallerList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[Installer](#installer) array_ |  |


#### InstallerSpec



InstallerSpec defines the desired state of Installer.

_Appears in:_
- [Installer](#installer)

| Field | Description |
| --- | --- |
| `operatorConfigs` _[OperatorConfigs](#operatorconfigs)_ |  |




#### NFState





_Appears in:_
- [InstallerStatus](#installerstatus)

| Field | Description |
| --- | --- |
| `type` _[OPSubType](#opsubtype)_ |  |
| `state` _string_ |  |


#### NetworkingOperators

_Underlying type:_ `string`



_Appears in:_
- [OperatorConfigs](#operatorconfigs)



#### OPSubType

_Underlying type:_ `string`



_Appears in:_
- [NFState](#nfstate)
- [OperatorInfo](#operatorinfo)



#### OperatorConfigs





_Appears in:_
- [InstallerSpec](#installerspec)

| Field | Description |
| --- | --- |
| `platform` _object (keys:[PlatformOperators](#platformoperators), values:[OperatorInfo](#operatorinfo))_ |  |
| `networking` _object (keys:[NetworkingOperators](#networkingoperators), values:[OperatorInfo](#operatorinfo))_ |  |


#### OperatorInfo





_Appears in:_
- [OperatorConfigs](#operatorconfigs)

| Field | Description |
| --- | --- |
| `type` _[OPSubType](#opsubtype)_ |  |
| `options` _object (keys:string, values:string)_ |  |
| `arrayOptions` _object (keys:string, values:string array)_ |  |
| `version` _string_ |  |
| `managedComponent` _boolean_ | ManagedComponent field is ignored for platform components and must be set to false to adopt networking components without managing them. |


#### Phase

_Underlying type:_ `string`



_Appears in:_
- [InstallerStatus](#installerstatus)



#### PlatformOperators

_Underlying type:_ `string`



_Appears in:_
- [OperatorConfigs](#operatorconfigs)




## network-function.netop-manager.io/v1alpha1

Package v1alpha1 contains API Schema definitions for the network-function v1alpha1 API group

### Resource Types
- [CniOps](#cniops)
- [CniOpsList](#cniopslist)
- [DiagnosticOps](#diagnosticops)
- [DiagnosticOpsList](#diagnosticopslist)
- [GitOps](#gitops)
- [GitOpsList](#gitopslist)
- [ObservedOps](#observedops)
- [ObservedOpsList](#observedopslist)



#### CniManagedState

_Underlying type:_ `string`



_Appears in:_
- [CniOpsStatus](#cniopsstatus)



#### CniOps



CniOps is the Schema for the cniops API

_Appears in:_
- [CniOpsList](#cniopslist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `CniOps`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[CniOpsSpec](#cniopsspec)_ |  |


#### CniOpsList



CniOpsList contains a list of CniOps.



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `CniOpsList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[CniOps](#cniops) array_ |  |


#### CniOpsSpec



CniOpsSpec defines the desired state of CniOps.

_Appears in:_
- [CniOps](#cniops)

| Field | Description |
| --- | --- |
| `config` _[Config](#config)_ |  |




#### CniUpgradeState

_Underlying type:_ `string`



_Appears in:_
- [CniUpgradeStatus](#cniupgradestatus)



#### CniUpgradeStatus





_Appears in:_
- [CniOpsStatus](#cniopsstatus)

| Field | Description |
| --- | --- |
| `cniUpgradeState` _[CniUpgradeState](#cniupgradestate)_ |  |
| `previousVersion` _string_ |  |
| `currentVersion` _string_ |  |


#### Config





_Appears in:_
- [CniOpsSpec](#cniopsspec)
- [DiagnosticOpsSpec](#diagnosticopsspec)
- [GitOpsSpec](#gitopsspec)

| Field | Description |
| --- | --- |
| `workload` _[WorkloadInfo](#workloadinfo)_ | First key should be internal child api |


#### DiagnosticOps



DiagnosticOps is the Schema for the diagnosticops API.

_Appears in:_
- [DiagnosticOpsList](#diagnosticopslist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `DiagnosticOps`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[DiagnosticOpsSpec](#diagnosticopsspec)_ |  |


#### DiagnosticOpsList



DiagnosticOpsList contains a list of DiagnosticOps.



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `DiagnosticOpsList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[DiagnosticOps](#diagnosticops) array_ |  |


#### DiagnosticOpsSpec



DiagnosticOpsSpec defines the desired state of DiagnosticOps.

_Appears in:_
- [DiagnosticOps](#diagnosticops)

| Field | Description |
| --- | --- |
| `config` _[Config](#config)_ |  |




#### GitOps



GitOps is the Schema for the gitops API.

_Appears in:_
- [GitOpsList](#gitopslist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `GitOps`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[GitOpsSpec](#gitopsspec)_ |  |


#### GitOpsList



GitOpsList contains a list of GitOps.



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `GitOpsList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[GitOps](#gitops) array_ |  |


#### GitOpsSpec



GitOpsSpec defines the desired state of GitOps.

_Appears in:_
- [GitOps](#gitops)

| Field | Description |
| --- | --- |
| `config` _[Config](#config)_ |  |




#### ObservedOps



ObservedOps is the Schema for the observedops API.

_Appears in:_
- [ObservedOpsList](#observedopslist)

| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `ObservedOps`
| `metadata` _[ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#objectmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `spec` _[ObservedOpsSpec](#observedopsspec)_ |  |


#### ObservedOpsList



ObservedOpsList contains a list of ObservedOps.



| Field | Description |
| --- | --- |
| `apiVersion` _string_ | `network-function.netop-manager.io/v1alpha1`
| `kind` _string_ | `ObservedOpsList`
| `metadata` _[ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#listmeta-v1-meta)_ | Refer to Kubernetes API documentation for fields of `metadata`. |
| `items` _[ObservedOps](#observedops) array_ |  |


#### ObservedOpsSpec



ObservedOpsSpec defines the desired state of ObservedOps.

_Appears in:_
- [ObservedOps](#observedops)

| Field | Description |
| --- | --- |
| `cniMountPath` _string_ |  |
| `cniConfPath` _string array_ |  |
| `forceReconcile` _integer_ |  |




#### State

_Underlying type:_ `string`



_Appears in:_
- [CniOpsStatus](#cniopsstatus)
- [DiagnosticOpsStatus](#diagnosticopsstatus)
- [GitOpsStatus](#gitopsstatus)



#### WorkloadInfo





_Appears in:_
- [Config](#config)

| Field | Description |
| --- | --- |
| `type` _string_ |  |
| `options` _object (keys:string, values:string)_ |  |
| `version` _string_ |  |
| `managedComponent` _boolean_ |  |

