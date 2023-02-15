#!/bin/bash

delete_namespace () {

	for i in $(seq 5); do
		echo "Trying to delete Namespace $1 ...."
		timeout 5s kubectl delete ns $1
		out=$(kubectl get ns $1 2>&1)
		if [[ $out == *'Error'* ]]; then
			break
		fi
	done

	out=$(kubectl get ns $1 2>&1)
	if [[ $out == *'Terminating'* ]]; then
		echo "Deleting terminating namespace $1 .."

		ns=$1
		kubectl get namespace $ns -o json \
			| tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
			| kubectl replace --raw /api/v1/namespaces/$ns/finalize -f -
	fi

}

wait_for_delete () {
	eval resource="$1"
	eval namespace="$2"
	wait_period=0
	while true
	do

		out=$(kubectl get $resource -n $namespace 2>&1)
		if [[ $out == *'Terminating'* ]]; then
			echo $out
			echo "Sleeping for 5 seconds"
			sleep 5
		else
			break
		fi

		wait_period=$(($wait_period+5))
		if [[ $wait_period -gt 30 ]];then
			echo "Timed out while waiting for delete..."
			break
		fi
	done
}

delete_static_manifests () {

	if [ ! -z "$1" ] && [ ! -z "$2" ]
	then
		echo "Setting proxy  $1 $2"
		export $1
		export $2
	fi

	timeout 5s wget  https://raw.githubusercontent.com/noironetworks/netop-manifests/cko-mvp-1/workload/netop-manager-openshift.yaml

	if [ ! -z "$1" ] && [ ! -z "$2" ]
	then
		echo "Unset proxy  $1 $2"
		unset http_proxy; unset https_proxy
	fi

	timeout 15s kubectl delete -f netop-manager-openshift.yaml
}

echo "Deleting applications.argoproj.io CR"

kubectl delete applications -A --all
wait_for_delete "applications" "netop-manager-system"

echo "Deleting errorpodsreportings.nettools.debug CR...."

kubectl delete epr --all -n nettools
wait_for_delete "epr" "nettools"

echo "Deleting connectivitycheckers.nettools.debug CR..."

kubectl delete conncheck --all -n nettools
wait_for_delete "conncheck" "nettools"

echo "Deleting connectivitycheckers resources..."

kubectl delete ds test-connectivity-ds -n nettools
wait_for_delete "ds" "nettools"

kubectl delete deploy test-connectivity -n nettools

kubectl delete deploy nginx-deploy -n nettools

kubectl delete deploy  nettools-debug -n nettools
wait_for_delete "deploy" "nettools"

kubectl delete po --all --grace-period=0 --force --namespace nettools

echo "Deleting namespace nettools.."
delete_namespace "nettools"

echo "Deleting installers.controller.netop-manager.io CR..."

kubectl delete installer -A --all
wait_for_delete "installer" "default"

echo "Deleting netop-manager static manifests..."

delete_static_manifests $1 $2

kubectl delete po --all --grace-period=0 --force --namespace netop-manager-system

echo "Deleting namespace netop-manager-system.."
delete_namespace "netop-manager-system"

ns_list=$(kubectl get ns)
aci_cni='aci-containers-system'
calico_cni='calico-system'
installed_cni=''
if [[ "$ns_list" =~ .*"$aci_cni".* ]]; then
	installed_cni="ACI"
elif [[ "$ns_list" =~ .*"$calico_cni".* ]]; then
	installed_cni="Calico"
fi

read -p "Do you want to delete the $installed_cni-CNI ? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo "Deleting CNI ......"

if [[ "$installed_cni" == "ACI" ]]; then

	kubectl -n aci-containers-system delete --all deploy
	wait_for_delete "deploy" "aci-containers-system"

	timeout 10s kubectl -n aci-containers-system delete all --all
	kubectl -n aci-containers-system delete --all ds
	wait_for_delete "all" "aci-containers-system"


	kubectl delete priorityclass acicni-priority
	declare -a crd=("acicontainersoperators.aci.ctrl" "nodepodifs.aci.aw" "snatglobalinfos.aci.snat" "snatlocalinfos.aci.snat"  "snatpolicies.aci.snat" "nodeinfos.aci.snat" "rdconfigs.aci.snat" "networkpolicies.aci.netpol" "dnsnetworkpolicies.aci.dnsnetpol" "qospolicies.aci.qos" "netflowpolicies.aci.netflow" "erspanpolicies.aci.erspan" "enabledroplogs.aci.droplog" "prunedroplogs.aci.droplog" "accprovisioninputs.aci.ctrl")
	crdlength=${#crd[@]}

	for (( i=0; i<${crdlength}; i++ ));
	do
		timeout 10s kubectl delete --all ${crd[$i]} -n aci-containers-system
		timeout 10s kubectl delete crd ${crd[$i]}
	done

	kubectl delete clusterrole aci-containers:controller
	kubectl delete clusterrole aci-containers:host-agent
	kubectl delete clusterrole aci-containers-operator

	kubectl delete clusterrolebinding aci-containers:controller
	kubectl delete clusterrolebinding aci-containers:host-agent
	kubectl delete clusterrolebinding aci-containers-operator

	kubectl delete po --all --grace-period=0 --force --namespace aci-containers-system
	echo "Deleting NameSpace aci-containers-system ..."
	delete_namespace "aci-containers-system"


elif [[ "$installed_cni" == "Calico" ]]; then

	timeout 30s kubectl delete installation default
	kubectl patch crd/installations.operator.tigera.io -p '{"metadata":{"finalizers":[]}}' --type=merge

	kubectl -n calico-api-server delete --all deploy
	wait_for_delete "deploy" "calico-api-server"

	timeout 10s kubectl -n calico-api-server delete all --all

	kubectl -n calico-system delete --all deploy
	wait_for_delete "deploy" "calico-system"

	timeout 10s kubectl -n calico-system delete all --all
	timeout 10s kubectl -n tigera-operator delete all --all

	kubectl delete --all BGPConfiguration -A
	kubectl delete --all BGPPeer -A
	kubectl delete --all BlockAffinity -A
	kubectl delete --all CalicoNodeStatus -A
	kubectl delete --all FelixConfiguration -A
	kubectl delete --all GlobalNetworkPolicy -A
	kubectl delete --all GlobalNetworkSet -A
	kubectl delete --all HostEndpoint -A
	kubectl delete --all IPAMBlock -A
	kubectl delete --all IPAMConfig -A
	kubectl delete --all IPAMHandle -A
	kubectl delete --all IPPool -A
	kubectl delete --all IPReservation -A
	kubectl delete --all KubeControllersConfiguration -A
	kubectl delete --all NetworkPolicy -A
	kubectl delete --all NetworkSet -A
	kubectl delete --all APIServer -A
	kubectl delete --all ImageSet -A
	kubectl delete --all TigeraStatus -A
	kubectl delete --all PodSecurityPolicy -A

	wait_for_delete "all" "tigera-operator"
	wait_for_delete "all" "calico-apiserver"
	wait_for_delete "all" "calico-system"

	kubectl delete po --all --grace-period=0 --force --namespace tigera-operator
	kubectl delete po --all --grace-period=0 --force --namespace calico-apiserver
	kubectl delete po --all --grace-period=0 --force --namespace calico-system

	echo "Deleting NameSpace tigera-operator ..."
	delete_namespace "tigera-operator"

	echo "Deleting NameSpace calico-apiserver ..."
	delete_namespace "calico-apiserver"

	echo "Deleting NameSpace calico-system ..."
	delete_namespace "calico-system"

	timeout 10s kubectl delete po -l k8s-app=kube-dns -n kube-system
	kubectl delete po  -l k8s-app=kube-dns --grace-period=0 --force --namespace kube-system
fi
