# mi

![Version: 4.2.0-0](https://img.shields.io/badge/Version-4.2.0--0-informational?style=flat-square) ![AppVersion: 4.2.0](https://img.shields.io/badge/AppVersion-4.2.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 Micro Integrator

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.secretManager.secretIdentifiers.internalKeystorePassword.secretKey | string | `""` | Secret key for internal keystore password |
| aws.secretManager.secretIdentifiers.internalKeystorePassword.secretName | string | `""` | Secret name for internal keystore password |
| aws.secretManager.secretProviderClass | string | `""` | AWS Secret Manager secret provider class name |
| aws.serviceAccountName | string | `""` | AWS IAM serivce account name |
| azure.keyVault.activeDirectory.servicePrincipal | object | `{"appId":"","clientSecret":""}` | Service Principal created for transacting with the target Azure Key Vault For advanced details refer to official documentation (https://github.com/Azure/secrets-store-csi-driver-provider-azure/blob/master/docs/service-principal-mode.md) |
| azure.keyVault.activeDirectory.servicePrincipal.appId | string | `""` | Azure AD application name for fetching secrets via CSI secret store driver |
| azure.keyVault.activeDirectory.servicePrincipal.clientSecret | string | `""` | Client secret of Azure AD application client |
| azure.keyVault.activeDirectory.tenantId | string | `""` | Azure Active Directory tenant ID of the target Key Vault |
| azure.keyVault.name | string | `""` | Name of the target Azure Key Vault instance |
| azure.keyVault.resourceManager.resourceGroup | string | `""` | Name of the Azure Resource Group to which the target Azure Key Vault belongs |
| azure.keyVault.resourceManager.subscriptionId | string | `""` | Subscription ID of the target Azure Key Vault |
| azure.keyVault.secretIdentifiers.internalKeystorePassword | string | `""` |  |
| azure.keyVault.secretProviderClass | string | `""` |  |
| containerRegistry | string | `""` | Container registry |
| provider | string | `""` | Kubernetes cluster provider. Supported values: azure, aws |
| wso2.config.admin.createAdminAccount | bool | `false` | Create super admin account |
| wso2.config.admin.password | string | `""` | Super admin password |
| wso2.config.admin.username | string | `""` | Super admin username |
| wso2.config.coordination | object | `{"nodeId":"","rdbms":{"jdbc":{"driver":"","poolParameters":null},"password":"","url":"","username":""}}` | Enable/Disable coordination |
| wso2.config.coordination.nodeId | string | `""` | Node ID for coordination |
| wso2.config.coordination.rdbms.jdbc.driver | string | `""` | JDBC driver class name of the Coordination Database |
| wso2.config.coordination.rdbms.jdbc.poolParameters | list | `nil` | JDBC connection pool parameters of the Coordination Database |
| wso2.config.coordination.rdbms.password | string | `""` | Coordination Database password |
| wso2.config.coordination.rdbms.url | string | `""` | Coordination Database URL |
| wso2.config.coordination.rdbms.username | string | `""` | Coordination Database username |
| wso2.config.dashboard.groupId | string | release name | The group ID of the Micro Integrator deployment |
| wso2.config.dashboard.heartbeatInterval | int | `5` | The time interval (in seconds) between two heartbeats sent from the Micro Integrator to the dashboard server |
| wso2.config.dashboard.nodeId | string | pod name | The node ID of the Micro Integrator deployment |
| wso2.config.dashboard.url | string | `""` | MI Dashboard URL |
| wso2.config.keyStore.internal.alias | string | `"wso2carbon"` | Internal keystore alias |
| wso2.config.keyStore.internal.fileName | string | `"wso2carbon.jks"` | Internal keystore file name |
| wso2.config.keyStore.internal.keyPassword | string | `""` | Internal keystore key password |
| wso2.config.keyStore.internal.password | string | `""` | Internal keystore password |
| wso2.config.keyStore.primary.alias | string | `"wso2carbon"` | Primary keystore alias |
| wso2.config.keyStore.primary.fileName | string | `"wso2carbon.jks"` | Primary keystore file name |
| wso2.config.keyStore.primary.keyPassword | string | `""` | Primary keystore key password |
| wso2.config.keyStore.primary.password | string | `""` | Primary keystore password |
| wso2.config.keyStore.transport.listener.alias | string | `"wso2carbon"` | Transport listener keystore alias |
| wso2.config.keyStore.transport.listener.fileName | string | `"wso2carbon.jks"` | Transport listener keystore file name |
| wso2.config.keyStore.transport.listener.keyPassword | string | `""` | Transport listener keystore key password |
| wso2.config.keyStore.transport.listener.password | string | `""` | Transport listener keystore password |
| wso2.config.keyStore.transport.sender.alias | string | `"wso2carbon"` | Transport sender keystore alias |
| wso2.config.keyStore.transport.sender.fileName | string | `"wso2carbon.jks"` | Transport sender keystore file name |
| wso2.config.keyStore.transport.sender.keyPassword | string | `""` | Transport sender keystore key password |
| wso2.config.keyStore.transport.sender.password | string | `""` | Transport sender keystore password |
| wso2.config.portOffset | int | `10` | Port offset for Micro Integrator (https://apim.docs.wso2.com/en/latest/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-mi-ports) |
| wso2.config.secureVault.enabled | bool | `false` | Enable/Disable secure vault |
| wso2.config.serviceCatalog | object | `{"apimHost":"","enabled":false,"password":"","username":""}` | Required if you want the Micro Integrator to publish integation services to the Service Catalog in the API Publisher (https://apim.docs.wso2.com/en/4.1.0/tutorials/integration-tutorials/service-catalog-tutorial/#step-3-configure-the-micro-integrator) |
| wso2.config.serviceCatalog.apimHost | string | `""` | API Manager runtime URL. (https://{hostname/ip}:{port}) |
| wso2.config.serviceCatalog.enabled | bool | `false` | Enable/Disable service catalog |
| wso2.config.serviceCatalog.password | string | `""` | Password for signing in to the API Manager runtime |
| wso2.config.serviceCatalog.username | string | `""` | User name for signing in to the API Manager runtime |
| wso2.config.trustStore.primary.fileName | string | `"client-truststore.jks"` | Primary truststore file name |
| wso2.config.trustStore.primary.password | string | `""` | Primary truststore password |
| wso2.config.trustStore.transport.listener.fileName | string | `"client-truststore.jks"` | Transport listener truststore file name |
| wso2.config.trustStore.transport.listener.password | string | `""` | Transport listener truststore password |
| wso2.config.trustStore.transport.sender.fileName | string | `"client-truststore.jks"` | Transport sender truststore file name |
| wso2.config.trustStore.transport.sender.password | string | `""` | Transport sender truststore password |
| wso2.config.userstore.file.enabled | bool | `true` | Enable/Disable file based userstore |
| wso2.config.userstore.rdbms.jdbc.driver | string | `""` | JDBC driver class name of the User Database |
| wso2.config.userstore.rdbms.jdbc.poolParameters | list | `nil` | JDBC connection pool parameters of the User Database |
| wso2.config.userstore.rdbms.password | string | `""` | User Database password |
| wso2.config.userstore.rdbms.url | string | `""` | User Database URL |
| wso2.config.userstore.rdbms.username | string | `""` | User Database username |
| wso2.deployment.BuildVersion | string | `"4.2.0"` | Build version of the Micro Integrator |
| wso2.deployment.JKSSecretName | string | `""` | K8s secret name which contains JKS files |
| wso2.deployment.envs | list | `nil` | Environment variables for the Micro integrator deployment |
| wso2.deployment.hostname | string | `""` | Hostname of the Micro Integrator deployment |
| wso2.deployment.hpa | object | `{"cpuUtilizationPercentage":75,"enabled":false,"maxReplicas":2,"memoryUtilizationPercentage":75,"minReplicas":1}` | Horizontal Pod Autoscaler (HPA) configurations (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) |
| wso2.deployment.hpa.cpuUtilizationPercentage | int | `75` | Average CPU utilization percentage for HPA |
| wso2.deployment.hpa.enabled | bool | `false` | Enable/Disable Horizontal Pod Autoscaler (HPA) |
| wso2.deployment.hpa.maxReplicas | int | `2` | Max replica count for HPA |
| wso2.deployment.hpa.memoryUtilizationPercentage | int | `75` | Average memory utilization percentage for HPA |
| wso2.deployment.hpa.minReplicas | int | `1` | Min replica count for HPA |
| wso2.deployment.image.digest | string | `""` | Container image digest |
| wso2.deployment.image.pullPolicy | string | `"Always"` | Container image pull policy. Refer (https://kubernetes.io/docs/concepts/containers/images/#updating-images) |
| wso2.deployment.image.repository | string | `""` | Container image repository name |
| wso2.deployment.mountCapps | object | `{"storage":{"capacity":"","parameters":null,"provisioner":"","storageClass":""}}` | Incase the CApps are not burned into the docker image, the following configurations can be used to mount the CApps using a persistent volume |
| wso2.deployment.mountCapps.storage.capacity | string | `""` | Persistent volume storage capacity |
| wso2.deployment.mountCapps.storage.parameters | list | `nil` | Storage class parameters |
| wso2.deployment.mountCapps.storage.provisioner | string | `""` | Storage provisioner |
| wso2.deployment.mountCapps.storage.storageClass | string | `""` | Persistent volume storage class name |
| wso2.deployment.pdb | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget configurations (https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| wso2.deployment.pdb.enabled | bool | `false` | Enable/Disable pod disruption budget |
| wso2.deployment.pdb.minAvailable | int | `1` | Min available pods for pod disruption budget |
| wso2.deployment.probes | object | `{"liveness":{"periodSeconds":10},"readiness":{"initialDelaySeconds":60,"periodSeconds":1},"startup":{"failureThreshold":40,"initialDelaySeconds":5,"periodSeconds":3}}` | Kubernetes Probes (https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| wso2.deployment.probes.liveness | object | `{"periodSeconds":10}` | Indicates whether the container is running |
| wso2.deployment.probes.liveness.periodSeconds | int | `10` | How often (in seconds) to perform the probe |
| wso2.deployment.probes.readiness.initialDelaySeconds | int | `60` | Number of seconds after the container has started before readiness probes are initiated |
| wso2.deployment.probes.readiness.periodSeconds | int | `1` | How often (in seconds) to perform the probe |
| wso2.deployment.probes.startup | object | `{"failureThreshold":40,"initialDelaySeconds":5,"periodSeconds":3}` | Startup probe executed prior to Liveness Probe taking over |
| wso2.deployment.probes.startup.failureThreshold | int | `40` | Number of attempts |
| wso2.deployment.probes.startup.initialDelaySeconds | int | `5` | Number of seconds after the container has started before startup probes are initiated |
| wso2.deployment.probes.startup.periodSeconds | int | `3` | How often (in seconds) to perform the probe |
| wso2.deployment.replicas | int | `1` | Number of deployment replicas |
| wso2.deployment.resources.jvm.memory.xms | string | `"512m"` | The minimum amount of memory that should be allocated for the JVM |
| wso2.deployment.resources.jvm.memory.xmx | string | `"1024m"` | The maximum amount of memory that should be allocated for the JVM |
| wso2.deployment.resources.limits.cpu | string | `"1000m"` | The maximum amount of CPU that should be allocated for a Pod |
| wso2.deployment.resources.limits.memory | string | `"1Gi"` | The maximum amount of memory that should be allocated for a Pod |
| wso2.deployment.resources.requests.cpu | string | `"500m"` | The minimum amount of CPU that should be allocated for a Pod |
| wso2.deployment.resources.requests.memory | string | `"512Mi"` | The minimum amount of memory that should be allocated for a Pod |
| wso2.deployment.securityContext.apparmor | bool | `true` | Enable/Disable AppArmor (https://kubernetes.io/docs/tutorials/security/apparmor/) |
| wso2.deployment.securityContext.runAsUser | string | `""` | The UID to run the entrypoint of the container process |
| wso2.deployment.securityContext.seccompProfile | bool | `true` | Enable/Disable seccomp profile (https://kubernetes.io/docs/tutorials/security/seccomp/) |
| wso2.deployment.strategy.rollingUpdate.maxSurge | int | `1` | The maximum number of pods that can be scheduled above the desired number of pods. |
| wso2.deployment.strategy.rollingUpdate.maxUnavailable | int | `0` | The maximum number of pods that can be unavailable during the update. |
| wso2.deployment.synapseTest.enabled | bool | `false` | Enable/Disable synapse testing |
| wso2.ingress.annotations | list | `nil` | Ingress annotations |
| wso2.ingress.enabled | bool | `true` | Enable Ingress for MI |
| wso2.ingress.ingressClassName | string | `""` | Ingress class name |
| wso2.ingress.ratelimit.burstLimit | string | `""` | Ingress ratelimit burst limit |
| wso2.ingress.ratelimit.enabled | bool | `false` | Ingress rate limit |
| wso2.ingress.ratelimit.zoneName | string | `""` | Ingress ratelimit zone name |
| wso2.ingress.tlsSecret | string | `""` | K8s TLS secret for configured hostname |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
