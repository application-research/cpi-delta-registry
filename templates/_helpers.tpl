{{/*
Expand the name of the chart.
*/}}
{{- define "cpi-delta-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cpi-delta-registry.fullname" -}}
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
{{- define "cpi-delta-registry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cpi-delta-registry.labels" -}}
helm.sh/chart: {{ include "cpi-delta-registry.chart" . }}
{{ include "cpi-delta-registry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cpi-delta-registry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cpi-delta-registry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cpi-delta-registry.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cpi-delta-registry.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Tshirt Sizer
*/}}
{{- define "cpi-delta-registry.getSizeConfig" -}}
{{- $tshirtSize := index $.Values.global.products.delta_registry.tshirtSize }}
{{- $sizeConfig := index $.Values.sizes $tshirtSize }}
{{- $sizeConfig | toYaml | nindent 0 }}
{{- end }}
