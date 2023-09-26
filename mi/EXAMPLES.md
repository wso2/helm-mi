# Sample configurations for WSO2 MI Helm chart

This doc gives the sample configurations which can be used as values for the Helm chart for different use cases.

## Supported Cluster providers

Currently, the MI helm charts are tested with the following cluster providers,

* [Amazon Elastic Kubernetes Service (EKS)](https://aws.amazon.com/eks/)

To use EKS, set the provider as `aws` and define the necessary configurations under `aws` sections as follows,
```yaml
# -- Kubernetes cluster provider. Supported values: azure, aws
provider: "aws"
# AWS service configurations
aws:
  serviceAccountName: "<service_account_name>"
  # AWS Elastic Container Registry (ECR) configurations
  ecr:
    # -- AWS Elastic Container Registry
    registry: "<aws_account_id>.dkr.ecr.<region>.amazonaws.com"
  secretManager:
    secretProviderClass: "<secret_provider_class_name>"
    secretIdentifiers:
      internalKeystorePassword:
        secretName: "<secret_name>"
        secretKey: "<secret_key>"
```

* [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/)

To use EKS, set the provider as `azure` and define the necessary configurations under `azure` sections as follows,

```yaml
# -- Kubernetes cluster provider. Supported values: azure, aws
provider: "azure"
# Azure service configurations
azure:
  keyVault:
    # -- Name of the target Azure Key Vault instance
    name: "<>"
    secretProviderClass: "<secret_provider_class_name>"
    secretIdentifiers:
      internalKeystorePassword: "<secret_name>"
    activeDirectory:
      # -- Service Principal created for transacting with the target Azure Key Vault
      servicePrincipal:
        # -- Azure AD application name for fetching secrets via CSI secret store driver
        appId: "<>"
        # -- Client secret of Azure AD application client
        clientSecret: "<>"
      # -- Azure Active Directory tenant ID of the target Key Vault
      tenantId: "<>"
    resourceManager:
      # -- Subscription ID of the target Azure Key Vault
      subscriptionId: "<>"
      # -- Name of the Azure Resource Group to which the target Azure Key Vault belongs
      resourceGroup: "<>"
  # Azure Container Registry service
  acr:
    # -- Azure Container registry
    registry: "<>"
```

## MI User store configurations

By default the file-based user store will be enabled. The following sample configuration shows how to use a RDBMS user store.

```yaml
wso2:
  config:
    userstore:
      file:
        # Disable file based userstore
        enabled: false
      rdbms:
        url: "jdbc:mysql://localhost:3306/userdb"
        username: "root"
        password: "root"
        jdbc:
          driver: "com.mysql.jdbc.Driver"
          poolParameters:
            maxActive: 50
            maxWait: 60000
```

## Mounting CApps using a Persistent Volume

Incase the CApps are not burned into the docker image, We can use a persistent volume to mount the CApps. The following sample configuration shows how to mount the CApps using an EFS.

```yaml
wso2:
  deployment:
    mountCapps:
      storage:
        provisioner: "efs.csi.aws.com"
        storageClass: "efs-sc"
        capacity: "5Gi"
        parameters:
          fileSystemId: "<replace_with_your_file_System_Id>"
          provisioningMode: efs-ap
          directoryPerms: "744"
```

## Enabling MI Dashboard

Using the following sample configuration, the MI node will connect to the MI dashboard running with a service `private-cloud-mi-dash-1`.
The groupId of the MI node will be the release name while the nodeId will be the pod name.

```yaml
wso2:
  config:
    dashboard:
      url: "https://private-cloud-mi-dash-1:9743/dashboard/api/"
```
