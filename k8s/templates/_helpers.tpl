{{- define "k8s-chart.labels" -}}
CURRENT_DATE: {{ now | date "2006-01-02" }}
VERSION: {{ .Chart.AppVersion | quote }}
{{- end }}
