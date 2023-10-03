# mi

![Version: 4.2.0-0](https://img.shields.io/badge/Version-4.2.0--0-informational?style=flat-square) ![AppVersion: 4.2.0](https://img.shields.io/badge/AppVersion-4.2.0-informational?style=flat-square)

A Helm chart for the deployment of WSO2 Micro Integrator

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws.region | string | `""` | AWS region |
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
| wso2.config.analytics.apiAnalytics | bool | `true` | Enable/Disable publishing API analytics data |
| wso2.config.analytics.enabled | bool | `false` | Enable/Disable analytics |
| wso2.config.analytics.endpointAnalytics | bool | `true` | Enable/Disable publishing endpoint analytics data |
| wso2.config.analytics.id | string | `""` | An identifier that will be published with the analytic |
| wso2.config.analytics.prefix | string | `"SYNAPSE_ANALYTICS_DATA"` | Prefix added when Elasticsearch analytics are being published |
| wso2.config.analytics.proxyServiceAnalytics | bool | `true` | Enable/Disable publishing proxy service analytics data |
| wso2.config.analytics.publisher | string | `"log"` | Analytics publisher (Publisher types supported are log and databridge) |
| wso2.config.analytics.sequenceAnalytics | bool | `true` | Enable/Disable publishing sequence analytics data |
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
| wso2.config.mediation.flow.statistics.captureAll | bool | `false` |  |
| wso2.config.mediation.flow.statistics.enable | bool | `false` |  |
| wso2.config.mediation.flow.tracer.collectMediationProperties | bool | `false` |  |
| wso2.config.mediation.flow.tracer.collectPayloads | bool | `false` |  |
| wso2.config.mediation.inbound.coreThreads | int | `20` |  |
| wso2.config.mediation.inbound.maxThreads | int | `100` |  |
| wso2.config.mediation.inbound.portOffsetEnable | bool | `false` |  |
| wso2.config.mediation.internalHttpApiEnable | bool | `true` |  |
| wso2.config.mediation.internalHttpApiPort | int | `9191` |  |
| wso2.config.mediation.internalHttpsApiPort | int | `9154` |  |
| wso2.config.mediation.statistics.cleanInterval | int | `1000` |  |
| wso2.config.mediation.statistics.enableClean | bool | `true` |  |
| wso2.config.mediation.synapse.buildValidNcName | bool | `false` |  |
| wso2.config.mediation.synapse.commandDebuggerPort | int | `9005` |  |
| wso2.config.mediation.synapse.coreThreads | int | `20` |  |
| wso2.config.mediation.synapse.disableAutoPrimitiveRegex | string | `"^-?(0|[1-9][0-9]*)(\\.[0-9]+)?([eE][+-]?[0-9]+)?$"` |  |
| wso2.config.mediation.synapse.disableCustomReplaceRegex | string | `"@@@"` |  |
| wso2.config.mediation.synapse.enableAutoPrimitive | bool | `false` |  |
| wso2.config.mediation.synapse.enableNamespaceDeclaration | bool | `false` |  |
| wso2.config.mediation.synapse.enableXmlNil | bool | `false` |  |
| wso2.config.mediation.synapse.enableXpathDomFailover | bool | `true` |  |
| wso2.config.mediation.synapse.eventDebuggerPort | int | `9006` |  |
| wso2.config.mediation.synapse.globalTimeoutInterval | int | `120000` |  |
| wso2.config.mediation.synapse.jsonOutAutoArray | bool | `false` |  |
| wso2.config.mediation.synapse.maxThreads | int | `100` |  |
| wso2.config.mediation.synapse.preserveNamespaceOnXmlToJson | bool | `false` |  |
| wso2.config.mediation.synapse.scriptMediatorPoolSize | int | `15` |  |
| wso2.config.mediation.synapse.tempDataChunkSize | int | `3072` |  |
| wso2.config.mediation.synapse.threadsQueueLength | int | `10` |  |
| wso2.config.messageBuilders.blocking | list | `{"applicationBinary":"org.apache.axis2.format.BinaryBuilder","applicationJson":"org.wso2.micro.integrator.core.json.JsonStreamBuilder","applicationXml":"org.apache.axis2.builder.ApplicationXMLBuilder","formUrlencoded":"org.apache.synapse.commons.builders.XFormURLEncodedBuilder","jsonBadgerfish":"org.apache.axis2.json.JSONBadgerfishOMBuilder","multipartFormData":"org.apache.axis2.builder.MultipartFormDataBuilder","octetStream":"org.wso2.carbon.relay.BinaryRelayBuilder","textJavascript":"org.apache.axis2.json.JSONBuilder","textPlain":"org.apache.axis2.format.PlainTextBuilder"}` | Required for configuring the message builder implementation that is used to build messages that are received by the Micro Integrator in blocking mode |
| wso2.config.messageBuilders.custom.blocking | list | `[{"class":"","contentType":""}]` | List of custom message builder implementation class and the selected content types to which the builder should apply in blocking mode |
| wso2.config.messageBuilders.custom.nonBlocking | list | `[{"class":"","contentType":""}]` | List of custom message builder implementation class and the selected content types to which the builder should apply in non-blocking mode |
| wso2.config.messageBuilders.nonBlocking | list | `{"applicationBinary":"org.apache.axis2.format.BinaryBuilder","applicationJson":"org.wso2.micro.integrator.core.json.JsonStreamBuilder","applicationXml":"org.apache.axis2.builder.ApplicationXMLBuilder","formUrlencoded":"org.apache.synapse.commons.builders.XFormURLEncodedBuilder","jsonBadgerfish":"org.apache.axis2.json.JSONBadgerfishOMBuilder","multipartFormData":"org.apache.axis2.builder.MultipartFormDataBuilder","octetStream":"org.wso2.carbon.relay.BinaryRelayBuilder","textJavascript":"org.apache.axis2.json.JSONBuilder","textPlain":"org.apache.axis2.format.PlainTextBuilder"}` | Required for configuring the message builder implementation that is used to build messages that are received by the Micro Integrator in non-blocking mode |
| wso2.config.messageFormatters.blocking | list | `{"applicationBinary":"org.apache.axis2.format.BinaryFormatter","applicationJson":"org.wso2.micro.integrator.core.json.JsonStreamFormatter","applicationXml":"org.apache.axis2.transport.http.ApplicationXMLFormatter","formUrlencoded":"org.apache.synapse.commons.formatters.XFormURLEncodedFormatter","jsonBadgerfish":"org.apache.axis2.json.JSONBadgerfishMessageFormatter","multipartFormData":"org.apache.axis2.transport.http.MultipartFormDataFormatter","octetStream":"org.wso2.carbon.relay.ExpandingMessageFormatter","soapXml":"org.apache.axis2.transport.http.SOAPMessageFormatter","textJavascript":"org.apache.axis2.json.JSONMessageFormatter","textPlain":"org.apache.axis2.format.PlainTextFormatter","textXml":"org.apache.axis2.transport.http.SOAPMessageFormatter"}` | Required for configuring the message formatting implementation that is used for formatting messages that are sent out of the Micro Integrator in blocking mode |
| wso2.config.messageFormatters.custom.blocking | list | `[{"class":"","contentType":""}]` | List of custom message formatter implementation class and the selected content types to which the formatter should apply in blocking mode |
| wso2.config.messageFormatters.custom.nonBlocking | list | `[{"class":"","contentType":""}]` | List of custom message formatter implementation class and the selected content types to which the formatter should apply in non-blocking mode |
| wso2.config.messageFormatters.nonBlocking | list | `{"applicationBinary":"org.apache.axis2.format.BinaryFormatter","applicationJson":"org.wso2.micro.integrator.core.json.JsonStreamFormatter","applicationXml":"org.apache.axis2.transport.http.ApplicationXMLFormatter","formUrlencoded":"org.apache.synapse.commons.formatters.XFormURLEncodedFormatter","jsonBadgerfish":"org.apache.axis2.json.JSONBadgerfishMessageFormatter","multipartFormData":"org.apache.axis2.transport.http.MultipartFormDataFormatter","octetStream":"org.wso2.carbon.relay.ExpandingMessageFormatter","soapXml":"org.apache.axis2.transport.http.SOAPMessageFormatter","textJavascript":"org.apache.axis2.json.JSONMessageFormatter","textPlain":"org.apache.axis2.format.PlainTextFormatter","textXml":"org.apache.axis2.transport.http.SOAPMessageFormatter"}` | Required for configuring the message formatting implementation that is used for formatting messages that are sent out of the Micro Integrator in non-blocking mode |
| wso2.config.opentelemetry.enable | bool | `false` | Enable/Disable OpenTelemetry |
| wso2.config.opentelemetry.host | string | `nil` | Hostname of the OpenTelemetry tracing system |
| wso2.config.opentelemetry.port | string | `nil` | Port of the OpenTelemetry tracing system |
| wso2.config.opentelemetry.type | string | `nil` | OpenTelemetry tracing system. Supported values: jaeger, zipkin, log and otlp |
| wso2.config.opentelemetry.url | string | `nil` | Url of the OpenTelemetry tracing system. Instead of ‘host’ and ‘port’, ‘url’ can be used |
| wso2.config.portOffset | int | `10` | Port offset for Micro Integrator (https://apim.docs.wso2.com/en/latest/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-mi-ports) |
| wso2.config.secureVault.enabled | bool | `false` | Enable/Disable secure vault |
| wso2.config.serviceCatalog | object | `{"apimHost":"","enabled":false,"password":"","username":""}` | Required if you want the Micro Integrator to publish integation services to the Service Catalog in the API Publisher (https://apim.docs.wso2.com/en/4.1.0/tutorials/integration-tutorials/service-catalog-tutorial/#step-3-configure-the-micro-integrator) |
| wso2.config.serviceCatalog.apimHost | string | `""` | API Manager runtime URL. (https://{hostname/ip}:{port}) |
| wso2.config.serviceCatalog.enabled | bool | `false` | Enable/Disable service catalog |
| wso2.config.serviceCatalog.password | string | `""` | Password for signing in to the API Manager runtime |
| wso2.config.serviceCatalog.username | string | `""` | User name for signing in to the API Manager runtime |
| wso2.config.synapseHandlers | list | `[{"class":"","name":""}]` | List of synapse handlers with the name and the implementation class |
| wso2.config.transport.jms.listener | list | `[{"name":"","parameters":{"initial_naming_factory":"","provider_url":"","session_transaction":true}}]` | JMS Listener configurations |
| wso2.config.transport.jms.listener[0] | object | `{"name":"","parameters":{"initial_naming_factory":"","provider_url":"","session_transaction":true}}` | JMS Listener name |
| wso2.config.transport.jms.listener[0].parameters | object | `{"initial_naming_factory":"","provider_url":"","session_transaction":true}` | JMS Listener parameters |
| wso2.config.transport.jms.sender | list | `[{"name":"","parameters":{"initial_naming_factory":"","provider_url":""}}]` | JMS Sender configurations |
| wso2.config.transport.jms.sender[0] | object | `{"name":"","parameters":{"initial_naming_factory":"","provider_url":""}}` | JMS Sender name |
| wso2.config.transport.jms.sender[0].parameters | object | `{"initial_naming_factory":"","provider_url":""}` | JMS Sender parameters |
| wso2.config.transport.jndi.connectionFactories | list | `[{"name":"","url":""}]` | List of JNDI connection factories |
| wso2.config.transport.jndi.connectionFactories[0] | object | `{"name":"","url":""}` | JNDI connection factory name |
| wso2.config.transport.jndi.connectionFactories[0].url | string | `""` | JNDI connection factory url |
| wso2.config.transport.jndi.queue | list | `[{"jndiName":"","physicalName":""}]` | List of queues that are defined in the JMS broker |
| wso2.config.transport.jndi.queue[0] | object | `{"jndiName":"","physicalName":""}` | JNDI queue name |
| wso2.config.transport.jndi.queue[0].physicalName | string | `""` | Actual queue name |
| wso2.config.transport.jndi.topic | list | `[{"jndiName":"","physicalName":""}]` | List of topics that are defined in the JMS broker |
| wso2.config.transport.jndi.topic[0] | object | `{"jndiName":"","physicalName":""}` | JNDI topic name |
| wso2.config.transport.jndi.topic[0].physicalName | string | `""` | Actual topic name |
| wso2.config.transport.rabbitmq.listener | list | `[{"name":"","parameters":null}]` | RabbitMQ Listener configurations |
| wso2.config.transport.rabbitmq.listener[0] | object | `{"name":"","parameters":null}` | RabbitMQ Listener name |
| wso2.config.transport.rabbitmq.listener[0].parameters | list | `nil` | RabbitMQ Listener parameters (https://apim.docs.wso2.com/en/4.1.0/reference/config-catalog-mi/#rabbitmq-listener) |
| wso2.config.transport.rabbitmq.sender | list | `[{"name":"","parameters":null}]` | RabbitMQ Sender configurations |
| wso2.config.transport.rabbitmq.sender[0] | object | `{"name":"","parameters":null}` | RabbitMQ Sender name |
| wso2.config.transport.rabbitmq.sender[0].parameters | list | `nil` | RabbitMQ Sender parameters (https://apim.docs.wso2.com/en/4.1.0/reference/config-catalog-mi/#rabbitmq-sender) |
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
| wso2.deployment.mountCapps | object | `{"storage":{"cAppAccessPoint":null,"capacity":"","directoryPerms":null,"fileSystemId":null,"provisioner":"","storageClass":""}}` | Incase the CApps are not burned into the docker image, the following configurations can be used to mount the CApps using a persistent volume |
| wso2.deployment.mountCapps.storage.cAppAccessPoint | string | `nil` | EFS file system access point ID for mounting the CApps |
| wso2.deployment.mountCapps.storage.capacity | string | `""` | Persistent volume storage capacity |
| wso2.deployment.mountCapps.storage.directoryPerms | string | `nil` | Directory permissions for access point root directory creation |
| wso2.deployment.mountCapps.storage.fileSystemId | string | `nil` | EFS file system ID |
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
