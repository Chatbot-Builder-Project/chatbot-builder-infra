# chatbot-builder-k8s

This repository contains Kubernetes configuration files and GitHub Actions workflows for deploying the **Chatbot Builder** to Azure Kubernetes Service (AKS).

## Repository Structure

### Folder Overview

- **`manifests/`**: Contains all Kubernetes deployment, service, ConfigMap, and related YAML files that define the application’s desired state in the AKS cluster.
- **`secrets/`**: Contains template YAML files for Kubernetes secrets (such as sensitive configurations like `SENTRY_DSN`). These files do not contain actual secret values by default. They are templates that should be filled with actual values before being applied to the AKS cluster.

### Folder Structure

```plaintext
├── manifests/
│   ├── pre-deployment/
│   ├── deployment/
│   └── post-deployment/
├── secrets/
│   ├── engine-secrets-staging.yaml
│   └── engine-secrets-production.yaml
└── ...
```

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow (`deploy-to-aks.yml`) that automates the deployment process to AKS. The workflow:
1. **Builds and Deploys Docker Images**: Builds the Docker image with the application code, tags it with the specified version, and pushes it to Azure Container Registry (ACR).
2. **Applies Configurations in `manifests/`**: Executes all YAML files in the `manifests/` folder, applying each configuration in sequence to ensure the AKS cluster is up-to-date with the latest deployment specifications.

### Workflow Trigger: Event from Another Repository

This deployment workflow is triggered by an external repository via a **repository_dispatch** event. This setup allows another repository to initiate deployments to staging or production in AKS by dispatching events such as `deploy_chatbot_staging` or `deploy_chatbot_production`. The event payload from the triggering repository can include specific details, like the Docker image tag to deploy, allowing seamless integration and automated deployment for different environments.

### Workflow Details: How `manifests/` Files Are Applied

1. **Pre-Deployment Resources**: The workflow first applies any pre-deployment resources (e.g., Persistent Volume Claims, ConfigMaps) to ensure all necessary resources are available for the application.
   ```yaml
   - name: Apply pre-deployment resources (PVCs, ConfigMaps, Secrets)
     run: |
       echo "Applying all pre-deployment resources recursively."
       find manifests/pre-deployment -type f \( -name "*.yaml" -o -name "*.yml" \) -exec kubectl apply -n $NAMESPACE -f {} \;
   ```
2. **Deployment Resources**: Next, the main deployment YAML files (Deployments, StatefulSets) are applied to AKS, updating the application state based on the latest configurations.
   ```yaml
   - name: Deploy core resources (Deployment, StatefulSet)
     run: |
       echo "Applying all deployment resources recursively."
       find manifests/deployment -type f \( -name "*.yaml" -o -name "*.yml" \) -exec kubectl apply -n $NAMESPACE -f {} \;
   ```
3. **Post-Deployment Resources**: Finally, the workflow applies any post-deployment resources, such as services, ingress configurations, or Horizontal Pod Autoscalers.
   ```yaml
   - name: Apply post-deployment resources (Services, Ingress, HPA)
     run: |
       echo "Applying all post-deployment resources recursively."
       find manifests/post-deployment -type f \( -name "*.yaml" -o -name "*.yml" \) -exec kubectl apply -n $NAMESPACE -f {} \;
   ```

### Execution Order

The workflow uses `find` commands to discover and execute each YAML file in a specified directory recursively. This approach ensures that files are applied in the correct order:
   - **Pre-deployment resources** like PVCs and ConfigMaps are applied first.
   - **Core deployment resources** follow, ensuring the application is deployed with the necessary prerequisites.
   - **Post-deployment resources** are applied last, setting up networking and scaling configurations.

## Handling Secrets

### Storing Secrets Templates in `secrets/`

The `secrets/` folder contains YAML templates for environment-specific secrets, such as `SENTRY_DSN`. These template files are placeholders, with keys but no values, to allow you to securely manage sensitive configurations.

Each file is structured as a Kubernetes Secret YAML but lacks actual values for sensitive data. You should **fill these templates with actual values** before applying them to the AKS cluster.

### Applying Secrets to AKS

To apply the secrets manually:

1. **Edit the Files**: Open each file in the `secrets/` directory and add the necessary values (e.g., `SENTRY_DSN`).
2. **Apply the Secrets**: Use the apply command with the secret file name to apply it to aks.

```bash
kubectl apply -f secrets/engine-secrets-staging.yaml -n staging
kubectl apply -f secrets/engine-secrets-production.yaml -n default
```

> **Note**: Keep your filled secrets files secure and avoid committing them to the repository to prevent accidental exposure of sensitive data.

## Summary

This setup allows for an organized, secure, and automated deployment process using GitHub Actions and Kubernetes best practices. Secrets are managed securely and applied separately to ensure sensitive data is handled appropriately. The `manifests/` folder provides a single source for all configuration files needed for deployment to AKS, making it easy to maintain and update configurations across environments.
