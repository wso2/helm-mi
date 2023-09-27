{{/*
Common prefix prepended to Kubernetes resources of this chart
*/}}
{{- define "resource.prefix" -}}
{{- "cloud" }}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "mi-dashboard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mi-dashboard.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mi-dashboard.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mi-dashboard.labels" -}}
app.kubernetes.io/name: {{ include "mi-dashboard.name" . }}
helm.sh/chart: {{ include "mi-dashboard.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "cp-secret-to-password-tmp" -}}
{{- if eq "azure" .Values.provider }}
{{- printf "cp /mnt/secrets-store/%s ${WSO2_SERVER_HOME}/password-tmp" .Values.azure.keyVault.secretIdentifiers.internalKeystorePassword -}}
{{- else if eq "aws" .Values.provider }}
{{- printf "cp /mnt/secrets-store/%s ${WSO2_SERVER_HOME}/password-tmp" .Values.aws.secretManager.secretIdentifiers.internalKeystorePassword.secretKey -}}
{{- end }}
{{- end -}}