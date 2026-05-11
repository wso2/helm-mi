# wso2-integration-control-plane

![Version: 2.0.0-0](https://img.shields.io/badge/Version-2.0.0--0-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 Integration Control Plane (ICP)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.region | string | `""` | AWS region |
| aws.secretManager.secretIdentifiers.internalKeystorePassword.secretKey | string | `""` | Secret key for internal keystore password |
| aws.secretManager.secretIdentifiers.internalKeystorePassword.secretName | string | `""` | Secret name for internal keystore password |
| aws.secretManager.secretProviderClass | string | `""` | AWS Secret Manager secret provider class name |
| aws.serviceAccountName | string | `""` | AWS IAM service account name |
| azure.keyVault.activeDirectory.servicePrincipal | object | `{"appId":"","clientSecret":""}` | Service Principal created for transacting with the target Azure Key Vault |
| azure.keyVault.activeDirectory.servicePrincipal.appId | string | `""` | Azure AD application name for fetching secrets via CSI secret store driver |
| azure.keyVault.activeDirectory.servicePrincipal.clientSecret | string | `""` | Client secret of Azure AD application client |
| azure.keyVault.activeDirectory.tenantId | string | `""` | Azure Active Directory tenant ID of the target Key Vault |
| azure.keyVault.name | string | `""` | Name of the target Azure Key Vault instance |
| azure.keyVault.resourceManager.resourceGroup | string | `""` | Name of the Azure Resource Group to which the target Azure Key Vault belongs |
| azure.keyVault.resourceManager.subscriptionId | string | `""` | Subscription ID of the target Azure Key Vault |
| azure.keyVault.secretIdentifiers.internalKeystorePassword | string | `""` | Secret name for internal keystore password |
| azure.keyVault.secretProviderClass | string | `""` | Azure Secret Manager secret provider class name |
| containerRegistry | string | `"docker.wso2.com"` | Container registry (When running on a local Kubernetes cluster using local image, make this empty) |
| provider | string | `""` | Kubernetes cluster provider. Supported values: azure, aws |
| wso2.config.additionalPorts | list | `[{"name":"icp-port-3","port":9447},{"name":"icp-port-5","port":9449}]` | Additional ICP ports exposed by the container |
| wso2.config.artifactsApiAllowInsecureTLS | bool | `false` | Allow insecure TLS for MI artifacts API |
| wso2.config.authBackendUrl | string | `"https://localhost:9447"` | Authentication backend URL |
| wso2.config.authPort | int | `9447` | Auth API port |
| wso2.config.credentialsDb | object | `{}` |  |
| wso2.config.enableAuditLogging | bool | `true` | Enable audit logging |
| wso2.config.enableMetrics | bool | `true` | Enable metrics |
| wso2.config.frontendJwtHMACSecret | string | `""` | Frontend JWT HMAC secret (at least 32 characters for HS256) |
| wso2.config.graphqlPort | int | `9446` | GraphQL API port |
| wso2.config.logLevel | string | `"INFO"` | Log level (DEBUG, INFO, WARN, ERROR) |
| wso2.config.observabilityPort | int | `9448` | Observability API port |
| wso2.config.schedulerIntervalSeconds | int | `30` | Scheduler interval in seconds |
| wso2.config.secureVault.enabled | bool | `false` | Enable/Disable secure vault |
| wso2.config.serverPort | int | `9445` | ICP server port |
| wso2.config.sso.enabled | bool | `false` | Enable/Disable SSO authentication |
| wso2.config.storage | object | `{}` |  |
| wso2.deployment.BuildVersion | string | `"2.0.0"` | Build version of the ICP |
| wso2.deployment.JKSSecretName | string | `""` | K8s secret name which contains JKS files |
| wso2.deployment.configMaps | object | `{"entryPoint":{"defaultMode":"0407"}}` | Set UNIX permissions over the startup scripts |
| wso2.deployment.cpuUtilizationPercentage | int | `75` | Average CPU utilization percentage for HPA |
| wso2.deployment.envs | list | `nil` | Environment variables for the ICP deployment |
| wso2.deployment.hostname | string | `"icp.wso2.com"` | Hostname of the ICP deployment |
| wso2.deployment.image.digest | string | `""` | Container image digest |
| wso2.deployment.image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy. Refer (https://kubernetes.io/docs/concepts/containers/images/#updating-images) |
| wso2.deployment.image.repository | string | `"wso2-integration-control-plane"` | Container image repository name |
| wso2.deployment.image.tag | string | `"2.0.0"` | Container image tag |
| wso2.deployment.imagePullSecrets | string | `""` | imagePullSecrets for private docker registry |
| wso2.deployment.maxReplicas | int | `2` | Max replica count for HPA (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) |
| wso2.deployment.memoryUtilizationPercentage | int | `75` | Average memory utilization percentage for HPA |
| wso2.deployment.minAvailable | int | `1` | Pod disruption budget configurations (https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| wso2.deployment.minReplicas | int | `1` | Min replica count for HPA (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) |
| wso2.deployment.probes | object | `{"liveness":{"periodSeconds":10},"readiness":{"initialDelaySeconds":60,"periodSeconds":1},"startup":{"failureThreshold":40,"initialDelaySeconds":15,"periodSeconds":3}}` | Kubernetes Probes (https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| wso2.deployment.probes.liveness | object | `{"periodSeconds":10}` | Indicates whether the container is running |
| wso2.deployment.probes.liveness.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.probes.readiness.initialDelaySeconds | int | `60` | Number of seconds after the container has started before readiness probes are initiated |
| wso2.deployment.probes.readiness.periodSeconds | int | `1` | How often (in seconds) to perform the probe |
| wso2.deployment.probes.startup | object | `{"failureThreshold":40,"initialDelaySeconds":15,"periodSeconds":3}` | Startup probe executed prior to Liveness Probe taking over |
| wso2.deployment.probes.startup.failureThreshold | int | `40` | Number of attempts |
| wso2.deployment.probes.startup.initialDelaySeconds | int | `15` | Number of seconds after the container has started before startup probes are initiated |
| wso2.deployment.probes.startup.periodSeconds | int | `3` | How often (in seconds) to perform the probe |
| wso2.deployment.replicas | int | `1` | Number of deployment replicas |
| wso2.deployment.resources.jvm.memory.xms | string | `"512m"` | The minimum amount of memory that should be allocated for the JVM |
| wso2.deployment.resources.jvm.memory.xmx | string | `"1024m"` | The maximum amount of memory that should be allocated for the JVM |
| wso2.deployment.resources.limits.cpu | string | `"1000m"` | The maximum amount of CPU that should be allocated for a Pod |
| wso2.deployment.resources.limits.memory | string | `"1Gi"` | The maximum amount of memory that should be allocated for a Pod |
| wso2.deployment.resources.requests.cpu | string | `"500m"` | The minimum amount of CPU that should be allocated for a Pod |
| wso2.deployment.resources.requests.memory | string | `"512Mi"` | The minimum amount of memory that should be allocated for a Pod |
| wso2.deployment.securityContext.apparmor | bool | `true` | Enable/Disable AppArmor (https://kubernetes.io/docs/tutorials/security/apparmor/) |
| wso2.deployment.securityContext.enableRunAsUser | bool | `true` |  |
| wso2.deployment.securityContext.runAsUser | string | `"10802"` | The UID to run the entrypoint of the container process |
| wso2.deployment.securityContext.seLinux.enabled | bool | `false` | Enable SELinux MCS labels on pods. Enable on RHEL/CentOS nodes with SELinux enforcing. |
| wso2.deployment.securityContext.seLinux.level | string | `"s0:c26,c0"` | MCS label: s0=sensitivity, c26,c0=categories. Isolates pod file access to matching labels. |
| wso2.deployment.securityContext.seccompProfile | object | `{"enabled":true,"type":"RuntimeDefault"}` | Enable/Disable seccomp profile (https://kubernetes.io/docs/tutorials/security/seccomp/) |
| wso2.deployment.securityContext.seccompProfile.enabled | bool | `true` | Enable/Disable seccomp profile |
| wso2.deployment.securityContext.seccompProfile.type | string | `"RuntimeDefault"` | Seccomp profile type |
| wso2.deployment.strategy.rollingUpdate.maxSurge | int | `1` | The maximum number of pods that can be scheduled above the desired number of pods. |
| wso2.deployment.strategy.rollingUpdate.maxUnavailable | int | `0` | The maximum number of pods that can be unavailable during the update. |
| wso2.gatewayAPI.backendTLS.caCertConfigMap | string | `""` | ConfigMap containing ca.crt for backend TLS verification. When empty, the chart creates a ConfigMap from the bundled backend-ca.crt file. Set this when using a custom keystore (e.g. via JKSSecretName) so the CA matches. |
| wso2.gatewayAPI.backendTLS.enabled | bool | `false` | Enable backend TLS policy |
| wso2.gatewayAPI.backendTLS.hostname | string | `"localhost"` | Hostname to validate against the backend's TLS certificate CN/SAN (must match the CN in your keystore) |
| wso2.gatewayAPI.createGateway | bool | `true` | gatewayName and gatewayNamespace values defined below are used in creating the new Gateway. |
| wso2.gatewayAPI.enabled | bool | `true` | Enable Gateway API resources (set to true to use Gateway API instead of Ingress) |
| wso2.gatewayAPI.gatewayClassName | string | `"envoy"` | GatewayClass name (must exist in cluster - e.g., envoy for Envoy Gateway) |
| wso2.gatewayAPI.gatewayName | string | `"envoy"` | Name of the Gateway |
| wso2.gatewayAPI.gatewayNamespace | string | `"envoy-gateway"` | Namespace where the Gateway resides |
| wso2.gatewayAPI.httpListener.enabled | bool | `false` | Enable HTTP listener on port 80. Disable for production to only expose HTTPS. |
| wso2.gatewayAPI.ratelimit.enabled | bool | `false` | Enable Gateway API rate limiting |
| wso2.gatewayAPI.ratelimit.requestsPerSecond | int | `10` | Requests per second limit |
| wso2.gatewayAPI.sessionAffinity.cookieName | string | `"ICP_AFFINITY"` | Name of the affinity cookie set by Envoy Gateway |
| wso2.gatewayAPI.sessionAffinity.cookieTTL | string | `"3600s"` | TTL of the affinity cookie |
| wso2.gatewayAPI.tlsSecret | string | `""` | K8s TLS secret for configured hostname (for Gateway API) TLS secret for Gateway HTTPS listener If tlsSecret is empty, a self-signed TLS certificate will be generated automatically for local/dev use. MANDATORY : For production, provide a cert-manager managed secret via tlsSecret. |
| wso2.ingress.annotations | list | `nil` | Ingress annotations ICP serves HTTPS natively; you must configure your ingress controller for backend HTTPS. For NGINX: nginx.ingress.kubernetes.io/backend-protocol: "HTTPS" For Traefik: traefik.ingress.kubernetes.io/service.serversscheme: "https" |
| wso2.ingress.enabled | bool | `false` | Enable Ingress for ICP |
| wso2.ingress.ingressClassName | string | `""` | Ingress class name |
| wso2.ingress.ratelimit.burstLimit | string | `""` | Ingress ratelimit burst limit |
| wso2.ingress.ratelimit.enabled | bool | `false` | Ingress rate limit |
| wso2.ingress.ratelimit.zoneName | string | `""` | Ingress ratelimit zone name |
| wso2.ingress.tlsSecret | string | `""` | K8s TLS secret for configured hostname |
| wso2.openshift | object | `{"enabled":false,"route":{"tls":{"insecureEdgeTerminationPolicy":"Redirect","termination":"reencrypt"}}}` | Standard Ingress cannot carry a destinationCACertificate field; OpenShift Routes support this natively. |
| wso2.openshift.route.tls.insecureEdgeTerminationPolicy | string | `"Redirect"` | Insecure traffic policy (None, Allow, Redirect) |
| wso2.openshift.route.tls.termination | string | `"reencrypt"` | passthrough: raw TLS forwarded to pod; path-based routing is NOT possible with this mode |
| wso2.subscription.password | string | `""` | WSO2 subscription password |
| wso2.subscription.username | string | `""` | WSO2 subscription username |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
