# mi

![Version: 4.2.0-0](https://img.shields.io/badge/Version-4.2.0--0-informational?style=flat-square) ![AppVersion: 4.2.0](https://img.shields.io/badge/AppVersion-4.2.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 Micro Integrator

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.ecr.registry | string | `""` | AWS Elastic Container Registry |
| aws.secretManager.secretIdentifiers.internalKeystorePassword.secretKey | string | `""` | Secret key for internal keystore password |
| aws.secretManager.secretIdentifiers.internalKeystorePassword.secretName | string | `""` | Secret name for internal keystore password |
| aws.secretManager.secretProviderClass | string | `""` | AWS Secret Manager secret provider class name |
| aws.serviceAccountName | string | `""` | AWS IAM serivce account name |
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
| wso2.config.dashboard.heartbeatInterval | int | `5` | The time interval (in seconds) between two heartbeats sent from the Micro Integrator to the dashboard server |
| wso2.config.dashboard.url | string | `""` | MI Dashboard URL |
| wso2.config.keyStore.internal.alias | string | `"wso2carbon"` | Internal keystore alias |
| wso2.config.keyStore.internal.fileName | string | `"wso2carbon.jks"` | Internal keystore file name |
| wso2.config.keyStore.internal.keyPassword | string | `""` | Internal keystore key password |
| wso2.config.keyStore.internal.password | string | `""` | Internal keystore password |
| wso2.config.keyStore.primary.alias | string | `"wso2carbon"` | Primary keystore alias |
| wso2.config.keyStore.primary.fileName | string | `"wso2carbon.jks"` | Primary keystore file name |
| wso2.config.keyStore.primary.keyPassword | string | `""` | Primary keystore key password |
| wso2.config.keyStore.primary.password | string | `""` | Primary keystore password |
| wso2.config.portOffset | int | `10` | Port offset for Micro Integrator (https://apim.docs.wso2.com/en/latest/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-mi-ports) |
| wso2.config.secureVault.enabled | bool | `false` | Enable/Disable secure vault |
| wso2.config.trustStore.primary.fileName | string | `"client-truststore.jks"` | Primary truststore file name |
| wso2.config.trustStore.primary.password | string | `""` | Primary truststore password |
| wso2.config.userstore.file.enabled | bool | `true` | Enable/Disable file based userstore |
| wso2.config.userstore.rdbms.jdbc.driver | string | `""` | JDBC driver class name of the User Database |
| wso2.config.userstore.rdbms.jdbc.poolParameters | list | `nil` | JDBC connection pool parameters of the User Database |
| wso2.config.userstore.rdbms.password | string | `""` | User Database password |
| wso2.config.userstore.rdbms.url | string | `""` | User Database URL |
| wso2.config.userstore.rdbms.username | string | `""` | User Database username |
| wso2.deployment.BuildVersion | string | `"4.2.0"` | Build version of the Micro Integrator |
| wso2.deployment.JKSSecretName | string | `""` | K8s secret name which contains JKS files |
| wso2.deployment.cpuUtilizationPercentage | int | `75` | Average CPU utilization percentage for HPA |
| wso2.deployment.envs | list | `nil` | Environment variables for the Micro integrator deployment |
| wso2.deployment.hostname | string | `""` | Hostname of the Micro Integrator deployment |
| wso2.deployment.image.digest | string | `""` | Container image digest |
| wso2.deployment.image.pullPolicy | string | `"Always"` | Container image pull policy. Refer (https://kubernetes.io/docs/concepts/containers/images/#updating-images) |
| wso2.deployment.image.repository | string | `""` | Container image repository name |
| wso2.deployment.maxReplicas | int | `2` | Max replica count for HPA (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) |
| wso2.deployment.memoryUtilizationPercentage | int | `75` | Average memory utilization percentage for HPA |
| wso2.deployment.minAvailable | int | `1` | Pod disruption budget configurations (https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| wso2.deployment.minReplicas | int | `1` | Min replica count for HPA (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) |
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
| wso2.deployment.securityContext.runAsUser | string | `""` | The UID to run the entrypoint of the container process |
| wso2.deployment.storage.capacity | string | `""` | Persistent volume storage capacity |
| wso2.deployment.storage.storageClass | string | `""` | Persistent volume storage class name |
| wso2.deployment.storage.volumeHandle | string | `""` | EFS volume handle |
| wso2.deployment.strategy.rollingUpdate.maxSurge | int | `1` | The maximum number of pods that can be scheduled above the desired number of pods. |
| wso2.deployment.strategy.rollingUpdate.maxUnavailable | int | `0` | The maximum number of pods that can be unavailable during the update. |
| wso2.deployment.synapseTest.enabled | bool | `false` | Enable/Disable synapse testing |
| wso2.ingress.annotations | list | `nil` | Ingress annotations |
| wso2.ingress.enabled | bool | `true` | Enable Ingress for MI |
| wso2.ingress.ingressClassName | string | `""` | Ingress class name |
| wso2.ingress.tlsSecret | string | `""` | K8s TLS secret for configured hostname |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
