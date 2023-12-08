{{- define "safeline.name" -}}
{{- default "safeline" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "safeline.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "safeline" .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{- define "safeline.labels" -}}
heritage: {{ .Release.Service }}
release: {{ .Release.Name }}
chart: {{ .Chart.Name }}
app: "{{ template "safeline.name" . }}"
{{- end -}}


{{- define "safeline.matchLabels" -}}
release: {{ .Release.Name }}
app: "{{ template "safeline.name" . }}"
{{- end -}}


{{/* database */}}
{{- define "safeline.database" -}}
  {{- printf "%s-database" (include "safeline.fullname" .) -}}
{{- end -}}

{{- define "safeline.database.host" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- printf "%s" "safeline-postgres" }}
  {{- else -}}
    {{- .Values.database.external.host -}}
  {{- end -}}
{{- end -}}

{{- define "safeline.database.port" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- printf "%s" "5432" -}}
  {{- else -}}
    {{- .Values.database.external.port -}}
  {{- end -}}
{{- end -}}

{{- define "safeline.database.username" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- printf "%s" "safeline-ce" -}}
  {{- else -}}
    {{- .Values.database.external.username -}}
  {{- end -}}
{{- end -}}

{{- define "safeline.database.rawPassword" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- .Values.database.internal.password -}}
  {{- else -}}
    {{- .Values.database.external.password -}}
  {{- end -}}
{{- end -}}

{{- define "safeline.database.escapedRawPassword" -}}
  {{- include "safeline.database.rawPassword" . | urlquery | replace "+" "%20" -}}
{{- end -}}

{{- define "safeline.database.encryptedPassword" -}}
  {{- include "safeline.database.rawPassword" . | b64enc | quote -}}
{{- end -}}

{{- define "safeline.database.coreDatabase" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- printf "%s" "registry" -}}
  {{- else -}}
    {{- .Values.database.external.coreDatabase -}}
  {{- end -}}
{{- end -}}

{{- define "safeline.database.dbname" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- printf "%s" "safeline-ce" -}}
  {{- else -}}
    {{- .Values.database.external.dbname -}}
  {{- end -}}
{{- end -}}


{{- define "safeline.database.sslmode" -}}
  {{- if eq .Values.database.type "internal" -}}
    {{- printf "%s" "disable" -}}
  {{- else -}}
    {{- .Values.database.external.sslmode -}}
  {{- end -}}
{{- end -}}

{{- define "safeline.database.url" -}}
postgres://{{ template "safeline.database.username" . }}:{{ template "safeline.database.escapedRawPassword" . }}@{{ template "safeline.database.host" . }}:{{ template "safeline.database.port" . }}/{{ template "safeline.database.dbname" . }}?sslmode={{ template "safeline.database.sslmode" . }}
{{- end -}}


{{/* logs */}}
{{- define "safeline.logs" -}}
  {{- printf "%s-logs" (include "safeline.fullname" .) -}}
{{- end -}}

{{/* nginx */}}
{{- define "safeline.nginx" -}}
  {{- printf "%s-nginx" (include "safeline.fullname" .) -}}
{{- end -}}

{{/* management */}}
{{- define "safeline.management" -}}
  {{- printf "%s-mgt-api" (include "safeline.fullname" .) -}}
{{- end -}}

{{- define "safeline.management.web.port" -}}
    {{- printf "1443" -}}
{{- end -}}

{{- define "safeline.management.middle.port" -}}
    {{- printf "1080" -}}
{{- end -}}

{{- define "safeline.management.controller.port" -}}
    {{- printf "9002" -}}
{{- end -}}

{{- define "safeline.management.url" -}}
https://{{ template "safeline.management" . }}:{{ template "safeline.management.web.port" . }}/api/publish/server
{{- end -}}

{{/* fvm */}}
{{- define "safeline.fvm" -}}
  {{- printf "%s-fvm" (include "safeline.fullname" .) -}}
{{- end -}}

{{- define "safeline.fvm.manager.port" -}}
    {{- printf "9004" -}}
{{- end -}}

{{- define "safeline.fvm.url" -}}
    {{ template "safeline.fvm" . }}:{{ template "safeline.fvm.manager.port" . }}
{{- end -}}

{{/* detector */}}
{{- define "safeline.detector" -}}
  {{- printf "%s-detector" (include "safeline.fullname" .) -}}
{{- end -}}

{{- define "safeline.detector.detector8000.port" -}}
    {{- printf "8000" -}}
{{- end -}}

{{- define "safeline.detector.detector8001.port" -}}
    {{- printf "8001" -}}
{{- end -}}

{{/* mario */}}
{{- define "safeline.mario" -}}
  {{- printf "%s-mario" (include "safeline.fullname" .) -}}
{{- end -}}

{{- define "safeline.mario.mario.port" -}}
    {{- printf "9443" -}}
{{- end -}}

{{- define "safeline.mario.weblog.port" -}}
    {{- printf "3335" -}}
{{- end -}}

{{- define "safeline.mario.url" -}}
http://{{ template "safeline.mario" . }}:{{ template "safeline.mario.weblog.port" . }}
{{- end -}}

{{/* tengine */}}
{{- define "safeline.tengine" -}}
  {{- printf "%s-tengine" (include "safeline.fullname" .) -}}
{{- end -}}

{{- define "safeline.tengine.health.port" -}}
    {{- printf "65443" -}}
{{- end -}}

{{- define "safeline.tengine.http.port" -}}
    {{- printf "80" -}}
{{- end -}}

{{- define "safeline.tengine.https.port" -}}
    {{- printf "443" -}}
{{- end -}}