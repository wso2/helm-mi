# Helm chart for the deployment of WSO2 Micro Integrator v4.2.0

This module contains the Helm resources required to deploy WSO2 Micro Integrator in a Kubernetes environment.

## Supported Cluster providers

Currently, the MI helm charts are tested with the following cluster providers,

* [Amazon Elastic Kubernetes Service (EKS)](https://aws.amazon.com/eks/)
* [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/)

## Helm chart configurations

The [values.yaml](./values.yaml) file contains the basic required parameters to deploy MI in a Kubernetes environment.

The [values_full.yaml](./values_full.yaml) file contains all the parameterize configurations. You may refer [CONFIG](./CONFIG.md) for full chart configurations. 

The [EXAMPLES](./EXAMPLES.md) file contains sample configurations which can be used as values for the Helm chart for different use cases.

## Contributing

1. Update the necessary k8s template file in [templates](./templates/) or the configuration file in [confs](./confs/). If the new paramter is optional, make sure to add the necessary check conditions.

2. Update the [values_full.yaml](./values_full.yaml) accordingly.

3. Run the following command to generate the docs.

**Note**: If `helm-docs` is not installed, refer [Installation](https://github.com/norwoodj/helm-docs#installation) first.

```
helm-docs -f values_full.yaml -o CONFIG.md
```
