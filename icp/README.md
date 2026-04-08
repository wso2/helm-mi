# Helm chart for the deployment of WSO2 Integration Control Plane (ICP) - v1.2.0

This module contains the Helm resources required to deploy WSO2 Integration Control Plane (ICP) v1.2.0 in a Kubernetes environment.

## Prerequisites

- WSO2 Product Docker images required for the deployment.
- It is recommended to push your own images to the cloud provider's container registry (ACR, ECR, etc.) as a best practice. Refer [U2 documentation](https://updates.docs.wso2.com/en/latest/updates/how-to-use-docker-images-to-receive-updates/) for any additional information. 

**Note** that you need a valid WSO2 subscription to obtain the U2 updated docker images from the WSO2 private registry.

- A running Kubernetes cluster (AKS, EKS, etc.)

- **Traffic Routing**: You can use either Ingress or Gateway API for routing traffic:

    **Option 1: Ingress (Enabled by Default)** - Using [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/):

    ```yaml
    wso2:
      ingress:
        enabled: true
        ingressClassName: "nginx"
        annotations:
          nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
      gatewayAPI:
        enabled: false
    ```

    **Option 2: Gateway API (Recommended)** - Using a [Gateway API](https://gateway-api.sigs.k8s.io/) compatible controller (e.g. [Envoy Gateway](https://gateway.envoyproxy.io/), [NGINX Gateway Fabric](https://github.com/nginx/nginx-gateway-fabric)):
    > Gateway API is the successor to Ingress and the recommended standard for traffic management in Kubernetes.

    Prerequisites:
    ```bash
    # Install Gateway API CRDs
    kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml

    # Install a Gateway controller (example: Envoy Gateway)
    helm install eg oci://docker.io/envoyproxy/gateway-helm \
      --version v1.2.1 -n envoy-gateway-system --create-namespace
    ```

    Configuration (Gateway created automatically by the chart):
    ```yaml
    wso2:
      deployment:
        hostname: "icp.example.com"    # Hostname for the Gateway listener
      ingress:
        enabled: false
      gatewayAPI:
        enabled: true
        # createGateway: true          # Default - creates Gateway automatically
        gatewayClassName: "envoy"      # Must match your installed GatewayClass
        # If tlsSecret is empty, a self-signed cert is auto-generated for dev/local. For production, provide a cert-manager managed secret.
        backendTLS:
          enabled: true                # ICP backend uses HTTPS
    ```

    Or use an existing shared Gateway:
    ```yaml
    wso2:
      deployment:
        hostname: "icp.example.com"
      ingress:
        enabled: false
      gatewayAPI:
        enabled: true
        createGateway: false           # Use external Gateway
        gatewayName: "shared-gateway"      # Name of the Gateway resource (user-defined or shared)
        gatewayNamespace: "infrastructure" # Namespace of the Gateway resource (user-defined or shared)
    ```

    > **Gateway Rate limiting Support**
    > - Gateway API rate limiting (`wso2.gatewayAPI.ratelimit.*`) is only supported with **Envoy Gateway** (`gatewayClassName: "envoy"`).
    > The chart now renders an Envoy Gateway-compatible BackendTrafficPolicy for rate limiting. NGINX Gateway Fabric is not supported.
    >
    > - If you use the default settings, rate limiting will be applied via Envoy Gateway.

    > **Gateway Session Affinity Support**
    >
    > - Session affinity (sticky sessions) via Gateway API is only supported with **Envoy Gateway** (`gatewayClassName: "envoy"`).
    > The chart renders an Envoy Gateway-compatible BackendTrafficPolicy for session affinity when you run more than one replica (`replicas > 1`).
    > For single-replica deployments, session affinity is not needed and is not applied.
    > If you use the default settings, session affinity will be automatically enabled when you scale to multiple replicas with Envoy Gateway.
    > - Normally single replica deployment will be often sufficient for ICP since ICP is a management dashboard, not a high-traffic service.

    See [EXAMPLES.md](./EXAMPLES.md#gateway-api-recommended) for detailed Gateway API configurations.

- If you are enabling secure vault configurations for the product, you need to configure the secret manager service of the respective cloud provider. Since the secrets are encrypted using the internal keystore password, that password should be included in the key vault so that it can be resolved using a CSI driver when the helm charts are deployed.

- For AWS, you need to deploy the `secrets-store-csi-driver-provider` and create the necessary IAM policies, OIDC providers, and IAM service accounts. Please refer the [documentation](https://github.com/aws/secrets-store-csi-driver-provider-aws) for more information and steps to follow.

## Supported Cluster providers

Currently, the ICP helm charts are tested with the following cluster providers,

* [Amazon Elastic Kubernetes Service (EKS)](https://aws.amazon.com/eks/)

    Refer [EKS Configs](./EXAMPLES.md#amazon-elastic-kubernetes-service-eks) section to configure the required parameters to run ICP in EKS.

* [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/)

    Refer [AKS Configs](./EXAMPLES.md#azure-kubernetes-service-aks) section to configure the required parameters to run ICP in AKS.

## Helm chart configurations

The [values.yaml](values.yaml) file contains the basic required parameters to deploy ICP in a Kubernetes environment. 

The [values_full.yaml](./values_full.yaml) file contains all the parameterize configurations. You may refer [CONFIG](./CONFIG.md) for full chart configurations.

The [EXAMPLES](./EXAMPLES.md) file contains sample configurations which can be used as values for the Helm chart.

## Contributing

1. Update the necessary k8s template file in [templates](./templates/) or the configuration file in [confs](./confs/). If the new paramter is optional, make sure to add the necessary check conditions.

2. Update the [values.yaml](values_full.yaml) accordingly.

3. Run the following command to generate the docs.

    > **Note**: If `helm-docs` is not installed, refer [Installation](https://github.com/norwoodj/helm-docs#installation) first.
    >
    > ```
    > helm-docs -f values_full.yaml -o CONFIG.md
    > ```
