#!/usr/bin/env bash

PGVECTOR_SERVICE_NAME="vector-db"
PGVECTOR_PLAN_NAME="on-demand-postgres-db"

GENAI_CHAT_SERVICE_NAME="genai-chat" # must be identical to runtime-configs/tpcf/manifest.yaml
GENAI_CHAT_PLAN_NAME="meta-llama/Meta-Llama-3-8B-Instruct" # plan must have chat capabilty

GENAI_EMBEDDINGS_SERVICE_NAME="genai-embed" # must be identical to runtime-configs/tpcf/manifest.yaml
GENAI_EMBEDDINGS_PLAN_NAME="nomic-embed-text" # plan must have Embeddings capabilty


case $1 in
cf)
    cf create-service postgres $PGVECTOR_PLAN_NAME $PGVECTOR_SERVICE_NAME #-c '{"svc_gw_enable": true, "router_group": "default-tcp", "external_port": 1025}' -w
    echo
	printf "Waiting for service $PGVECTOR_SERVICE_NAME to create."
	while [ `cf services | grep 'in progress' | wc -l | sed 's/ //g'` != 0 ]; do
  		printf "."
  		sleep 5
	done
	echo
	echo "$PGVECTOR_SERVICE_NAME creation completed."
	echo
 
	echo
	echo "Creating $GENAI_CHAT_SERVICE_NAME and $GENAI_EMBEDDINGS_SERVICE_NAME GenAI services ..."
	echo

    cf create-service genai $GENAI_CHAT_PLAN_NAME $GENAI_CHAT_SERVICE_NAME #-c '{"svc_gw_enable": true, "router_group": "default-tcp", "external_port": 1025}' -w
    cf create-service genai $GENAI_EMBEDDINGS_PLAN_NAME $GENAI_EMBEDDINGS_SERVICE_NAME #-c '{"svc_gw_enable": true, "router_group": "default-tcp", "external_port": 1025}' -w
 
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
    cf delete-service $GENAI_CHAT_SERVICE_NAME -f
    cf delete-service $GENAI_EMBEDDINGS_SERVICE_NAME -f
    cf delete dekt-metal -f
    kubectl delete -f .tanzu/services
    ;;
*)
    echo "Usage: cf/k8s/cleanup"
    ;;
esac