{{/*
Expand the name of the chart.
*/}}
{{- define "ibm-odf.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ibm-odf.fullname" -}}
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
{{- define "ibm-odf.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ibm-odf.labels" -}}
helm.sh/chart: {{ include "ibm-odf.chart" . }}
{{ include "ibm-odf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ibm-odf.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ibm-odf.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ibm-odf.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ibm-odf.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "ibm-odf.internal_kvdb" }}
{{- if .Values.etcdSecretName }}
{{- "external" }}
{{- else }}
{{- "internal" }}
{{- end }}
{{- end }}

{{- define "ibm-odf.operator-secret" }}
{{- "ibmcloud-operator-secret" }}
{{- end }}

{{- define "ibm-odf.operator-config" }}
{{- "ibmcloud-operator-defaults" }}
{{- end }}

{{- define "ibm-odf.service-name" }}
{{- include "ibm-odf.fullname" . }}
{{- end }}

{{- define "ibm-odf.namespace" }}
{{- .Release.Namespace }}
{{- end }}
