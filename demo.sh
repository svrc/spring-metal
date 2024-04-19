#!/usr/bin/env bash

case $1 in
create)
    cf create-service genai-service  shared-ai-plan ai-service
    cf create-service postgres on-demand-postgres-db pgvector
    ;;
delete)
    cf delete-service ai-service -f
    cf delete-service pgvector -f
    cf delete spring-metal -f
    ;;
*)
    echo "Please use create or delete"
    ;;
esac
