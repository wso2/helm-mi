# Building a Chart-Compatible Local/Dev ICP Image

This chart does not set a `command`/`args` override on the ICP container — it relies entirely
on the container image's own `ENTRYPOINT` being the script this chart mounts at
`/home/wso2carbon/docker-entrypoint.sh` (see `templates/icp-conf-entrypoint.yaml`). That script is
what actually copies the Helm-rendered `deployment.toml` / `log4j2.properties` ConfigMap into the
server's `conf/` directory before starting the server:

```sh
config_volume=${WORKING_DIRECTORY}/wso2-config-volume
test -d ${config_volume} && [ "$(ls -A ${config_volume})" ] && cp -RL ${config_volume}/* ${WSO2_SERVER_HOME}/
exec ${WSO2_SERVER_HOME}/bin/icp.sh "$@"
```

The official WSO2 product image bakes in this contract already: a `wso2carbon` user, an install
directory under `/home/wso2carbon/`, and `WSO2_SERVER_HOME` / `WORKING_DIRECTORY` env vars pointing
at it. If you build a **local/dev image directly from an ICP distribution zip** (e.g. straight off a
product build, not derived `FROM` the official image), it is easy to end up with a different user,
a different install path (e.g. `/home/wso2/...`), and an `ENTRYPOINT` that points straight at
`bin/icp.sh` instead of the chart's entrypoint script.

**If you do this, the deployment will look like it worked — the pod goes `Running`, the Gateway/HTTPRoute
serve the frontend, health checks pass — but every value under `wso2.config.*` and
`wso2.deployment.hostname` you set in `values_local.yaml` is silently ignored.** The server just runs
the distribution zip's bundled default `conf/deployment.toml`, because the chart's config volume is
mounted into a directory tree the running process never reads. The most visible symptom: logging in
redirects to `https://localhost:9446/...` instead of your configured hostname, because
`backendAuthBaseUrl` (derived from `wso2.deployment.hostname`) was never applied.

## The contract your local image must satisfy

| Requirement | Value the chart expects |
|---|---|
| Non-root user | UID matching `wso2.deployment.securityContext.runAsUser` (default `10802`) |
| Install directory | `/home/wso2carbon/wso2-integration-control-plane-<version>` |
| `WORKING_DIRECTORY` env var | `/home/wso2carbon` |
| `WSO2_SERVER_HOME` env var | `/home/wso2carbon/wso2-integration-control-plane-<version>` |
| `ENTRYPOINT` | `/home/wso2carbon/docker-entrypoint.sh` (mounted by this chart — do not bake your own) |

## Example Dockerfile

Adapt this to however your distribution zip is produced (build tool, base OS, JRE). The key parts
are the user/paths/env vars/entrypoint, not the specific base image:

```dockerfile
FROM frolvlad/alpine-glibc:latest

ARG ICP_VERSION=2.0.0-SNAPSHOT

RUN apk add --no-cache bash unzip curl

# ... install your JRE / native deps here, same as you would for any standalone image ...

ENV WORKING_DIRECTORY=/home/wso2carbon
ENV WSO2_SERVER_HOME=${WORKING_DIRECTORY}/wso2-integration-control-plane-${ICP_VERSION}

RUN addgroup -g 10802 wso2carbon && \
    adduser -D -u 10802 -G wso2carbon -h ${WORKING_DIRECTORY} wso2carbon

WORKDIR ${WORKING_DIRECTORY}
COPY build/distribution/wso2-integration-control-plane-${ICP_VERSION}.zip ./
RUN unzip wso2-integration-control-plane-${ICP_VERSION}.zip && \
    rm wso2-integration-control-plane-${ICP_VERSION}.zip && \
    chmod +x ${WSO2_SERVER_HOME}/bin/icp.sh && \
    chown -R wso2carbon:wso2carbon ${WORKING_DIRECTORY}

USER wso2carbon
WORKDIR ${WSO2_SERVER_HOME}

EXPOSE 9445 9446 9449

# Do NOT set this to bin/icp.sh directly — the chart mounts its own entrypoint script
# at this exact path and expects it to be what actually launches the server.
ENTRYPOINT ["/home/wso2carbon/docker-entrypoint.sh"]
```

Build and use it like any other local image (see [README.md](./README.md#container-registry-and-server-image)):

```bash
docker build -t my-icp-dev:local .
```

```yaml
containerRegistry: ""
wso2:
  deployment:
    image:
      repository: "my-icp-dev"
      tag: "local"
      pullPolicy: IfNotPresent
```

## Sanity check after deploying

Confirm the chart's config actually took effect before debugging anything else:

```bash
kubectl exec deploy/<release>-icp -n <namespace> -- \
  grep -A3 "FRONTEND URL" ${WSO2_SERVER_HOME:-/home/wso2carbon/wso2-integration-control-plane-*}/conf/deployment.toml
```

You should see `backendAuthBaseUrl`/`backendGraphqlEndpoint`/`backendObservabilityEndpoint` lines
derived from your `wso2.deployment.hostname`. If that section is missing, or `conf/deployment.toml`
contains the distribution's commented-out example config instead, the image isn't honoring the
chart's entrypoint contract.
