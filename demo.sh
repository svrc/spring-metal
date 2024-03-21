#!/usr/bin/env bash

case $1 in
create)
    cf create-service genai-service shared-ai-plan dekt-genai
    cf create-service postgres on-demand-postgres-db dekt-secret-sauce
    #cf create-service postgres on-demand-postgres-small dekt-secret-sauce 
    ;;
delete)
    cf delete-service dekt-genai -f
    cf delete-service dekt-secret-sauce -f
    cf delete dekt-ai -f
    ;;
*)
    echo "Please use create or delete"
    ;;
esac
