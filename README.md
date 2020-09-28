# Metric Filter Creator

Lame and simple script to create metric filters for all projects in the org

Basic architecture

-Uses jq for parsing the metric payload
-It has a metric template (metric_template.jq), which is used to create a temp file that we'll be used in the operation
-Last but not least, it uses gcloud utility to create the metric filter according to this doc https://cloud.google.com/sdk/gcloud/reference/beta/logging/metrics/create#--config-from-file
-Improvements are to come, and always welcome