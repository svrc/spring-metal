#!/usr/bin/env bash

CF_APP_NAME=spring-metal
PGVECTOR_EXTERNAL_PORT=1029   # Change this to an open port on your TAS foundation TCP routers
PGVECTOR_SERVICE_NAME="postgres"
GENAI_CHAT_PLAN="meta-llama/Meta-Llama-3-8B-Instruct"
GENAI_EMBED_PLAN="nomic-embed-text"
GENAI_CHAT_SERVICE_NAME="genai-chat"
GENAI_EMBED_SERVICE_NAME="genai-embed"

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
    cf create-service genai $GENAI_CHAT_PLAN $GENAI_CHAT_SERVICE_NAME 
#    cf create-service genai $GENAI_EMBED_PLAN $GENAI_EMBED_SERVICE_NAME 
    cf push $CF_APP_NAME -f runtime-configs/tpcf/manifest.yml 
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
    cf delete-service $GENAI_EMBED_SERVICE_NAME -f
    cf delete $CF_APP_NAME -f
    kubectl delete -f .tanzu/services
    ;;
*)
    echo "Usage: cf/k8s/cleanup"
    ;;
esac
