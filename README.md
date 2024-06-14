# Demo of Tanzu platform Innerloop Gitops with Github

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.1.2-brightgreen.svg)
![AI LLM](https://img.shields.io/badge/AI-LLM-blue.svg)
![PostgreSQL](https://img.shields.io/badge/postgres-15.1-red.svg)
![Tanzu](https://img.shields.io/badge/tanzu-platform-purple.svg)
![Tanzu deploy to K8s](https://github.com/0pens0/spring-metal/actions/workflows/k8sdeploy.yml/badge.svg)
![Tanzu deploy to CF](https://github.com/0pens0/spring-metal/actions/workflows/cfdeploy.yml/badge.svg)

This repository contains artifacts necessary to build and run generative AI applications using Spring Boot and Tanzu Platform. The instructions below cover setup for both Cloud Foundry (cf) and Kubernetes (k8s) environments.

## Architecture

![Alt text](https://github.com/0pens0/spring-metal/blob/main/image.jpg?raw=true "Spring-metal Github action flow")

## Prerequisites
- Ensure you have the Tanzu organisation, project and space information.
- Ensure you have access to TPCF and information on the Organisation and space to push to the foundation and you configured the API token.
- Ensure you have the parameters of the github action defined in a reposiroty level, secrets and env. vars.

## Commit a change on this branch (Gitops) and it will trigger the push

### Troubleshooting

- check the github action logs its details will allow you to trail and error and adjust what is needed to fix the probelm.
an example of logs:

https://github.com/0pens0/spring-metal/actions/runs/9498802336/job/26178300831

## Contributing
Contributions to this project are welcome. Please ensure to follow the existing coding style and add unit tests for any new or changed functionality.


