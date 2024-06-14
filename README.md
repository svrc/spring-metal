# Demo of Tanzu platform & 
# Gitops with Github Actions

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.1.2-brightgreen.svg)
![AI LLM](https://img.shields.io/badge/AI-LLM-blue.svg)
![PostgreSQL](https://img.shields.io/badge/postgres-15.1-red.svg)
![Tanzu](https://img.shields.io/badge/tanzu-platform-purple.svg)

![Tanzu deploy to K8s](https://github.com/0pens0/spring-metal/actions/workflows/k8sdeploy.yml/badge.svg)
![Tanzu deploy to CF](https://github.com/0pens0/spring-metal/actions/workflows/cfdeploy.yml/badge.svg)

This repository contains artifacts necessary to build and deploy generative AI applications using Spring Boot and Tanzu Platform in a gitops fasion. The instructions below will push the app into both Cloud Foundry (cf) and Kubernetes (k8s) environments.

## Architecture

![Alt text](https://github.com/0pens0/spring-metal/blob/gitops/image.png?raw=true "Spring-metal Github action flow")

## Prerequisites
- Ensure you have the TPK8S organisation, project and space information.
- Ensure you have TPCF organisation and space information to push to the foundation.
- Ensure you have the parameters of the github action defined in a reposiroty level, secrets and env. vars.\

Get in to secrets and vars configuration in the repository level >> https://github.com/0pens0/spring-metal/settings/secrets/actions and configure the following:
- TPK8S parameters:
    - TANZU_CLI_VERSION = tanzu cli version to use
    - API_ENDPOINT = the api end point information and org ID >> https://api.tanzu.cloud.vmware.com/org/ ***org-id***
    - API_TOKEN = tanzu api token to connect to TPK8S service
    - BUILD_REGISTRY_CONF = the configuration of tanzu build for **containerapp-registry** as part of the build plan >> should be ***registry-host-name***/***project***/{name}
    - REGISTRY = the container registry host name used for docker login
    - REGISTRY_USER_NAME = the user used to login to the registry
    - RERGISTRY_PASS = the password used to login to registry
    - PROJECT = the TPK8S project name
    - SPACE = the TPK8S space to deploy to
- TPCF parameters:
    - CF_API_ENDPOINT = CF api of the foundation
    - CF_API_TOKEN = the api token used for api login
    - CF_ORG = TPCF org name
    - CF_SPACE = TPCF space name to push to



## Commit a change on this branch (Gitops) and it will trigger the push

### Troubleshooting

- check the github action logs its details will allow you to trail and error and adjust what is needed to fix the probelm.
an example of logs:

https://github.com/0pens0/spring-metal/actions/runs/9498802336/job/26178300831

## Contributing
Contributions to this project are welcome. Please ensure to follow the existing coding style and add unit tests for any new or changed functionality.


