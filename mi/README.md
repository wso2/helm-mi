# Helm chart for the deployment of WSO2 Integrator: MI - v4.5.0

This module contains the Helm resources required to deploy WSO2 Integrator: MI v4.5.0 in a Kubernetes environment.

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
        hostname: "mi.example.com"     # Hostname for the Gateway listener
      ingress:
        enabled: false
      gatewayAPI:
        enabled: true
        # createGateway: true          # Default - creates Gateway automatically
        gatewayClassName: "envoy"      # Must match your installed GatewayClass
        # If tlsSecret is empty, a self-signed cert is auto-generated for dev/local. For production, provide a cert-manager managed secret.
        backendTLS:
          enabled: true                # MI backend uses HTTPS
    ```

    Or use an existing shared Gateway:
    ```yaml
    wso2:
      deployment:
        hostname: "mi.example.com"
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
    
    See [EXAMPLES.md](./EXAMPLES.md#gateway-api-recommended) for detailed Gateway API configurations.

- If you are enabling secure vault configurations for the product, you need to configure the secret manager service of the respective cloud provider. Since the secrets are encrypted using the internal keystore password, that password should be included in the key vault so that it can be resolved using a CSI driver when the helm charts are deployed.

- For AWS, you need to deploy the `secrets-store-csi-driver-provider` and create the necessary IAM policies, OIDC providers, and IAM service accounts. Please refer the [documentation](https://github.com/aws/secrets-store-csi-driver-provider-aws) for more information and steps to follow.

## Supported Cluster providers

Currently, the MI helm charts are tested with the following cluster providers,

* [Amazon Elastic Kubernetes Service (EKS)](https://aws.amazon.com/eks/)

    Refer [EKS Configs](./EXAMPLES.md#amazon-elastic-kubernetes-service-eks) section to configure the required parameters to run MI in EKS.

* [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/)

    Refer [AKS Configs](./EXAMPLES.md#azure-kubernetes-service-aks) section to configure the required parameters to run MI in AKS.

* [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine)

    Refer [GKE Configs](./EXAMPLES.md#google-kubernetes-engine-gke) section to configure the required parameters to run MI in GKE.

## Connecting MI to the Integration Control Plane (ICP)

WSO2 MI can be connected to the [WSO2 Integration Control Plane (ICP)](https://wso2.com/integration/integration-control-plane/) for centralized monitoring and management of MI deployments.

Enable the `icp` configuration block and provide the required connection details:

```yaml
wso2:
  config:
    icp:
      enabled: true
      # Shared secret obtained from the ICP management console
      secret: "<secret-key>"         
      icpUrl: "https://<icp-host>:9445"
```

**`secret`** — The shared secret key generated by ICP when registering a new MI runtime group. Obtain it from the ICP management console under **MI Groups → Add Group**.

**`icpUrl`** — The HTTPS URL of the ICP management API (port `9445`). This URL must be reachable from within the MI pods.

- **ICP deployed in the same Kubernetes cluster** — Use the Kubernetes service DNS name:

    ```
    https://<cloudName>-<icp-release-name>:9445
    ```

    The ICP service name is `<cloudName>-<release-name>`, where `cloudName` defaults to `cloud`. For example, if ICP is installed with release name `icp`, the service name is `cloud-icp` and the URL is:

    ```
    https://cloud-icp:9445
    ```

    If ICP was installed with a custom `cloudName` (e.g. `cloudName: prod`) and release name `icp`, the service name is `prod-icp`.

- **ICP deployed externally** (different cluster, on-premises, or managed endpoint) — Provide the full reachable URL:

    ```
    https://icp.example.com:9445
    ```

> **Note:** Ensure the Kubernetes NetworkPolicy (if any) allows egress from MI pods to the ICP host on port `9445`.

### Trusting ICP's Certificate

ICP uses HTTPS for its management API (port `9445`). By default it uses a self-signed certificate, which MI's JVM will reject with an SSL handshake error. Choose one of the following approaches:

#### Local Development — Disable SSL verification

```yaml
wso2:
  config:
    icp:
      sslVerify: false
```

> **Warning:** Never use `sslVerify: false` in production. It disables all certificate validation.

#### Production Deployment — Trust ICP's CA certificate

> **Note:** If ICP's certificate is signed by a **publicly trusted CA** (Let's Encrypt, DigiCert, etc.), no configuration is needed. MI's JVM already trusts all major public CAs and the SSL handshake will succeed automatically. The steps below are only required when ICP uses a **self-signed or private CA certificate**.

**Step 1 — Extract ICP's CA certificate (if you don't already have it)**

```bash
kubectl exec -n <namespace> deployment/<icp-deployment-name> -- \
  keytool -export -noprompt -alias wso2carbon \
    -keystore /home/wso2carbon/wso2-integration-control-plane-2.0.0/conf/security/wso2carbon.jks \
    -storepass wso2carbon -rfc \
  > icp.crt
```

**Step 2 — Create a Kubernetes secret with the certificate:**

```bash
kubectl create secret generic <any-name-you-choose> \
  --from-file=ca.crt=icp.crt \
  -n <namespace>
```

> **Note:** The secret must expose the CA certificate under the key `ca.crt`. This is the standard key name used by Kubernetes TLS secrets and cert-manager CA secrets.

**Step 3 — Set `caCertSecretName` in your values:**

```yaml
wso2:
  config:
    icp:
      caCertSecretName: "<created-secret-name>"
```

The chart mounts that secret into the MI pod and imports the certificate into MI's truststore at startup. If `caCertSecretName` is not set, no cert is mounted and SSL will fail unless you set `sslVerify: false`.

> **Note:** If you use a custom JKS via `wso2.deployment.JKSSecretName`, ensure the truststore password in `wso2.config.trustStore.primary.password` matches your JKS password.

## Helm chart configurations

The [values.yaml](./values.yaml) file contains the basic required parameters to deploy MI in a Kubernetes environment.

The [values_full.yaml](./values_full.yaml) file contains all the parameterize configurations. You may refer [CONFIG](./CONFIG.md) for full chart configurations. 

The [EXAMPLES](./EXAMPLES.md) file contains sample configurations which can be used as values for the Helm chart for different use cases.

## Contributing

1. Update the necessary k8s template file in [templates](./templates/) or the configuration file in [confs](./confs/). If the new paramter is optional, make sure to add the necessary check conditions.

2. Update the [values_full.yaml](./values_full.yaml) accordingly.

3. Run the following command to generate the docs.

    >**Note**: If `helm-docs` is not installed, refer [Installation](https://github.com/norwoodj/helm-docs#installation) first.
    >
    >```
    >helm-docs -f values_full.yaml -o CONFIG.md
    >```
