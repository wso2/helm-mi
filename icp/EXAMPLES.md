# Sample configurations for WSO2 Integration Control Plane (ICP) Helm chart

This doc gives the sample configurations which can be used as values for the Helm chart.

## Gateway API (Recommended)

[Gateway API](https://gateway-api.sigs.k8s.io/) is the successor to Ingress and the recommended standard for traffic management in Kubernetes. Any Gateway API compatible controller can be used (e.g. [Envoy Gateway](https://gateway.envoyproxy.io/), [NGINX Gateway Fabric](https://github.com/nginx/nginx-gateway-fabric)).

> **Important:**
> Gateway API rate limiting (`wso2.gatewayAPI.ratelimit.*`) is **only supported with Envoy Gateway** (`gatewayClassName: "envoy"`).
> For other Gateway controllers (e.g., NGINX Gateway Fabric, Istio, Traefik), this policy will not be applied. Use your controller's native rate limiting features or Ingress annotations instead.

### Prerequisites

1. **Install Gateway API CRDs**:
  ```bash
  kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml
  ```

2. **Install a Gateway controller** (example: Envoy Gateway):
  ```bash
  helm install eg oci://docker.io/envoyproxy/gateway-helm \
    --version v1.2.1 -n envoy-gateway-system --create-namespace
  ```

### Basic Gateway API Configuration (Gateway Created Automatically)

By default, the Helm chart creates a Gateway resource for you. This is the simplest setup:

```yaml
wso2:
  deployment:
    hostname: "icp.example.com"        # Hostname for the Gateway listener
  ingress:
    enabled: false
  gatewayAPI:
    enabled: true
    # createGateway: true              # Default - Gateway is created by the chart
    gatewayClassName: "envoy"          # Must match your installed GatewayClass
    backendTLS:
      enabled: true                    # ICP backend uses HTTPS
```

### Gateway API with TLS

To terminate TLS at the Gateway (required for browser access since ICP sets `Secure` cookies):

```yaml
wso2:
  deployment:
    hostname: "icp.example.com"
  ingress:
    enabled: false
  gatewayAPI:
    enabled: true
    gatewayClassName: "envoy"
    tlsSecret: "icp-tls-secret"        # If empty, a self-signed cert is auto-generated for dev/local. For production, provide a cert-manager managed secret.
    backendTLS:
      enabled: true
```

### Gateway API with External/Shared Gateway

If you have a shared Gateway managed by your infrastructure team, set `createGateway: false`:

```yaml
wso2:
  deployment:
    hostname: "icp.example.com"
  ingress:
    enabled: false
  gatewayAPI:
    enabled: true
    createGateway: false               # Use existing Gateway
    gatewayName: "shared-gateway"      # Name of the external Gateway
    gatewayNamespace: "infrastructure" # Namespace of the external Gateway
    tlsSecret: "icp-tls-secret"        # If empty, a self-signed cert is auto-generated for dev/local. For production, provide a cert-manager managed secret. ReferenceGrant is auto-created for cross-namespace access.
    backendTLS:
      enabled: true
```

### Gateway API with Session Affinity and Rate Limiting

When running ICP with multiple replicas, enable session affinity to maintain login/CSRF state:

```yaml
wso2:
  deployment:
    hostname: "icp.example.com"
  ingress:
    enabled: false
  gatewayAPI:
    enabled: true
    gatewayClassName: "envoy"
    tlsSecret: "icp-tls-secret"
    backendTLS:
      enabled: true
      hostname: "localhost"            # Must match the CN/SAN in ICP's backend TLS certificate
    sessionAffinity:
      cookieName: "ICP_AFFINITY"       # Automatically enabled when replicas > 1
      cookieTTL: "3600s"
    ratelimit:
      enabled: true
      requestsPerSecond: 100
      burst: 50
```

#### Multi-Replica Session Affinity

Cookie-based session affinity is currently **only supported with Envoy Gateway**. If you're using a different Gateway controller (nginx, istio, etc.) with multiple ICP replicas, you have these options:

1. **Recommended: Use Envoy Gateway** - Switch to `gatewayClassName: "envoy"` to get automatic cookie-based session affinity

2. **Single Replica** - Deploy ICP with `replicas: 1` (often sufficient since ICP is a management dashboard, not a high-traffic service)

3. **Gateway-Specific Configuration** - Implement session affinity at your Gateway/Ingress controller level:
  - **NGINX Ingress**: Use `nginx.ingress.kubernetes.io/affinity: "cookie"` annotation
    ```yaml
    annotations:
      nginx.ingress.kubernetes.io/affinity: "cookie"
      nginx.ingress.kubernetes.io/affinity-mode: "persistent"
      nginx.ingress.kubernetes.io/session-cookie-name: "ICP_AFFINITY"
      nginx.ingress.kubernetes.io/session-cookie-max-age: "3600"
    ```
  - **Istio**: Configure `consistentHash` in DestinationRule
    ```yaml
    apiVersion: networking.istio.io/v1beta1
    kind: DestinationRule
    metadata:
      name: icp
    spec:
      host: icp
      trafficPolicy:
        loadBalancer:
          consistentHash:
            httpCookie:
              name: "ICP_AFFINITY"
              ttl: "3600s"
    ```
  - **Traefik**: Use sticky sessions middleware
    ```yaml
    apiVersion: traefik.containo.us/v1alpha1
    kind: Middleware
    metadata:
      name: icp-sticky
    spec:
      affinity:
        sticky:
          cookie:
            name: "ICP_AFFINITY"
            httpOnly: true
    ```
   - Consult your Gateway controller's documentation for cookie-based sticky sessions.

> **Note**: Kubernetes Service-level `sessionAffinity: ClientIP` is NOT suitable for ICP as it relies on source IP, which doesn't work reliably with NAT, proxies, or mobile clients.

### Verify Gateway API Resources

After deployment, verify the resources:

```bash
# Check Gateway (if createGateway: true)
kubectl get gateway -n <namespace>

# Check HTTPRoute status
kubectl get httproute -n <namespace>

# Verify HTTPRoute is attached to Gateway
kubectl describe httproute cloud-<release-name>-httproute -n <namespace>

# Check if policies are applied (Envoy Gateway)
kubectl get backendtlspolicy,backendtrafficpolicy -n <namespace>
```

### Deploy ICP Helm Chart

```bash
# Install ICP chart
helm install <release-name> icp/ -n <namespace> --values values.yaml

# Upgrade ICP chart (if already installed)
helm upgrade <release-name> icp/ -n <namespace> --values values.yaml
```

### Verify ICP Deployment

```bash
kubectl get pods -n <namespace>
kubectl get svc -n <namespace>

# Port-forward for local testing
kubectl port-forward svc/<service-name> 9743:9743 -n <namespace>
```

## Supported Cluster providers

Currently, the ICP helm charts are tested with the following cluster providers,

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

When running in EKS, [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller) can be used as the ingress controller. To use it as the ingress controller for ICP, update the `ingress` section as follows,

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
      alb.ingress.kubernetes.io/healthcheck-port: '9743'
      alb.ingress.kubernetes.io/healthcheck-path: /dashboard/api/healthz
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
