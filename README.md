# Demo of Tanzu platform and SpringAI

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.1.2-brightgreen.svg)
![AI LLM](https://img.shields.io/badge/AI-LLM-blue.svg)
![PostgreSQL](https://img.shields.io/badge/postgres-15.1-red.svg)
![Tanzu](https://img.shields.io/badge/tanzu-platform-purple.svg)

This repository contains artifacts necessary to build and run generative AI applications using Spring Boot and Tanzu Platform. The instructions below cover setup for both Cloud Foundry (cf) and Kubernetes (k8s) environments.

## Architecture

![Alt text](https://github.com/0pens0/spring-metal/blob/main/image.png?raw=true "Spring-metal AI topology")

## Prerequisites
- Ensure you have the latest version of the Tanzu CLI installed.
- Access to a Route53 domain and necessary AWS permissions.
- Configured egress settings (closed by default) to connect to external services.

## Installation

### Cloud Foundry Runtime
Set up your target environment and create necessary back-end services for the ai demo:

```bash
cf target -o ai-apps -s ai-spring-metal
cf create-service private-ai-service shared-ai-plan ai-service
cf create-service postgres on-demand-postgres-db pgvector
cf push
```

### Kubernetes Runtime

Set up your Kubernetes environment ensuring all prerequisites are met:

#### Set context:

```bash
tanzu login
tanzu context use <my-context>
tanzu project use <my-project>
tanzu space use <my-space>
```
## Build

Follow these commands to build your application:

```bash
tanzu build -o build-output
```

## Deploy

Follow these commands to deploy your application from the build-output folder:

```bash
tanzu deploy --from-build build-output
```

## Bind

### Configuration
Place your configuration files in the `conf/.secret` directory. Adjust the YAML files to match the connection details provided by the external service.

### Binding External Services

#### Create and bind the pre-provisioned services using the secrets:
Create and bind pre-provisioned services:

```bash
tanzu context use <my-context>
kubectl create -f conf/.secret
tanzu service instance bind PreProvisionedService/<genaiservicename> ContainerApp/<appname> --as genai
tanzu services instance bind PostgreSQLInstance/<postgresname> ContainerApp/<appname> --as db
```

### Troubleshooting

#### Issue: Problem with external service binding.
- **Solution:** Ensure that all credentials and connection details in `conf/.secret` are correct and updated.

#### Issue: Application deployment fails.
- **Solution:** Check the build output for errors and verify the Tanzu configuration settings.

Browse your application through the app ingress link provided in the Space UI after deployment.

## Contributing
Contributions to this project are welcome. Please ensure to follow the existing coding style and add unit tests for any new or changed functionality.


