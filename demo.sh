#!/usr/bin/env bash

case $1 in
create)
    cf create-service genai-service shared-ai-plan dekt-genai
    cf create-service postgres on-demand-postgres-db dekt-embeddings
    ;;
delete)
    cf delete-service dekt-genai -f
    cf delete-service dekt-embeddings -f
    cf delete dekt-ai -f
    ;;
*)
    echo "Please use create or delete"
    ;;
esac
