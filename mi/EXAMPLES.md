# Sample configurations for WSO2 MI Helm chart

This doc gives the sample configurations which can be used as values for the Helm chart for different use cases.

## Supported Cluster providers

Currently, the MI helm charts are tested with the following cluster providers,

### Amazon Elastic Kubernetes Service (EKS)

To use EKS, set the provider as `aws` and define the necessary configurations under `aws` sections as follows,
```yaml
# -- Kubernetes cluster provider. Supported values: azure, aws
provider: "aws"
# AWS service configurations
aws:
  serviceAccountName: "<service_account_name>"
  secretManager:
    secretProviderClass: "<secret_provider_class_name>"
    secretIdentifiers:
      internalKeystorePassword:
        secretName: "<secret_name>"
        secretKey: "<secret_key>"
```

When running in EKS, [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller) can be used as the ingress controller. To use it as the ingress controller for MI, update the `ingress` section as follows,

**Note**: The current tested version of the controller is 2.6.x.

> [!IMPORTANT]
> 1. Create a SSL certificate using the AWS Certificate Manager (ACM) and replace the `<CERT_ARN>` with the certificate ARN.
> 2. If the AWS Load Balancer Controller is not installed in the cluster, install it using the [installation guide](https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/deploy/installation.md).
> 3. Following annotations are required to be added to enable the AWS Load Balancer Controller. Depending on the use case, additional annotations might be required. Refer [AWS Load Balancer Controller annotations](https://kubernetes-sigs.github.io/aws-load-balancer-controller/latest/guide/ingress/annotations/) for more information.

```yaml
wso2:
  ingress:
    # -- Enable Ingress for MI
    enabled: true
    # -- Ingress class name
    ingressClassName: "alb"
    # -- Ingress annotations
    annotations:
      alb.ingress.kubernetes.io/group.name: mi-dev-alb
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
      alb.ingress.kubernetes.io/certificate-arn: <CERT_ARN>
      alb.ingress.kubernetes.io/backend-protocol: HTTPS
      alb.ingress.kubernetes.io/healthcheck-protocol: 'HTTP'
      alb.ingress.kubernetes.io/healthcheck-port: '9201'
      alb.ingress.kubernetes.io/healthcheck-path: /healthz
```

### Azure Kubernetes Service (AKS)

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
```

## MI User store configurations

By default the file-based user store will be enabled. The following sample configuration shows how to use a RDBMS user store. It is recommended to include the JDBC driver in your Docker image so that MI can connect to the databases without any issues. If you are not adding the driver to the image itself, you might have to modify the helm charts and mount the driver to the deplyoments.

```yaml
wso2:
  config:
    userstore:
      file:
        # Disable file based userstore
        enabled: false
      rdbms:
        url: "jdbc:mysql://<DB_HOST>:<DB_PORT>/<USER_DB_NAME>"
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
        fileSystemId: "<replace_with_filesystem_id>"
        cAppAccessPoint: "<replace_with_accesspoint_id>"
        directoryPerms: "0777"
```

## Enabling MI Dashboard

Using the following sample configuration, the MI node will connect to the MI dashboard running with a service `private-cloud-mi-dash-1`.
By default, the groupId of the MI node will be the release name while the nodeId will be the pod name.

```yaml
wso2:
  config:
    dashboard:
      url: "https://private-cloud-mi-dash-1:9743/dashboard/api/"
```

## Enabling RabbitMQ Listener

Following sample configuration shows how to configure WSO2 Micro Integrator to connect with RabbitMQ listener. Similar configurations can be used to configure JMS transport listeners as well.

```yaml
wso2:
  config:
    transport:
      rabbitmq:
        listener:
        - name: "AMQPConnectionFactory"
          parameters:
            hostname: "<HOST_NAME>"
            port: 5672
            username: "<USERNAME>"
            password: "<PASSWORD>"
```

## Monitoring with OpenTelemetry

Below configurations can be used to enable and view traces through Jaeger.

```yaml
wso2:
  config:
    opentelemetry:
      enable: true
      type: "jaeger"
      host: "<hostname-of-jaeger>"
      port: 14250
    mediation:
      flow:
        statistics:
          captureAll: true
        tracer:
          collectPayloads: true
          collectMediationProperties: true
```

## Configuring a synapse handler

```yaml
wso2:
  config:
    synapseHandlers:
    - name: "TestHandler"
      class: "org.wso2.carbon.test.gateway.TestHandler"
    - name: "SecHandler"
      class: "org.wso2.carbon.test.gateway.SecHandler"
```

## Defining a custom message formatter

Similar configurations can be used to define a custom message builder as well. Refer `wso2.config.messageFormatters` and `wso2.config.messageBuilders` sections in [CONFIG](./CONFIG.md).

```yaml
wso2:
  config:
    messageFormatters:
      custom:
        nonBlocking:
        - contentType: "application/ld+json"
          class: "org.example.CustomJsonFormatter"
```

## Mounting Keystore and Truststore using a Kubernetes Secret

If you are not including the keystore and truststore into the docker image, you can mount them using a Kubernetes secret. The following sample configuration shows how to mount the keystore and truststore using a Kubernetes secret.

**Pre-requisites**

Create a Kubernetes secret with the keystore and truststore files. The secret should contain the primary keystore file, internal keystore file and  truststore file.

> [!IMPORTANT]
> 1. Make sure to use the same secret name when creating the secret and when configuring the helm chart.
> 2. If you are using a different keystore file name and alias, make sure to update the helm chart configurations accordingly.
> 3. In addition to the primary, internal keystores and truststore files, you can also include the keystores for HTTPS tranport as well. Refer [CONFIG](./CONFIG.md) and [Configuring Keystores for the Micro Integrator](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/mi-setup/security/configuring_keystores/) for more information.

Refer the following sample commands to create the secret and use it in the helm chart.

```
kubectl create secret generic mi-jks-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks --from-file=wso2internal.jks -n mi-test
```

```yaml
wso2:
  deployment:
    JKSSecretName: "mi-jks-secret"
  config:
    keyStore:
      primary:
        fileName: "wso2carbon.jks"
        alias: "wso2carbon"
        password: ""
        keyPassword: ""
      internal:
        fileName: "wso2internal.jks"
        alias: "wso2carbon"
        password: ""
        keyPassword: ""
    trustStore:
      primary:
        fileName: "client-truststore.jks"
        password: ""
```
