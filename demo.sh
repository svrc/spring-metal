#!/usr/bin/env bash

PGVECTOR_SERVICE_NAME="embeddings"
GENAI_SERVICE_NAME="genai-enpoint"

case $1 in
cf)
    cf create-service postgres on-demand-postgres-db $PGVECTOR_SERVICE_NAME #-c '{"svc_gw_enable": true, "router_group": "default-tcp", "external_port": 1025}' -w
    echo
	printf "Waiting for service $PGVECTOR_SERVICE_NAME to create."
	while [ `cf services | grep 'in progress' | wc -l | sed 's/ //g'` != 0 ]; do
  		printf "."
  		sleep 5
	done
	echo
	echo "$PGVECTOR_SERVICE_NAME creation completed."
	echo
    cf create-service genai shared $GENAI_SERVICE_NAME #-c '{"svc_gw_enable": true, "router_group": "default-tcp", "external_port": 1025}' -w
    cf push -f runtime-configs/tpcf/manifest.yml 
    ;;
k8s)
    echo
    printf "\e[35m▶ tanzu deploy \e[m\n"
    echo
    tanzu deploy -y
    
    echo
    printf "\e[35m▶ tanzu service bind \e[m\n"
    echo
    kubectl apply -f .tanzu/services --validate=false
    ;;
cleanup)
    cf delete-service $PGVECTOR_SERVICE_NAME -f
    cf delete-service $GENAI_SERVICE_NAME -f
    cf delete dekt-metal -f
    kubectl delete -f .tanzu/services
    ;;
*)
    echo "Usage: cf/k8s/cleanup"
    ;;
esac