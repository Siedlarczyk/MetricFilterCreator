#!/bin/bash

#lame basch script to create metric filter for all projects, using default config, for more advanced, you'll need to update metric_template.jq

read -p "Enter the metric name you would like to create " metric_name
read -p "Enter the metric description you would like to create " metric_description
read -p "Enter the metric filter you would like to create " metric_filter

jq -n --arg t1 "$metric_name" --arg t2 "$metric_description" --arg t3 "$metric_filter" -f metric_template.jq > metric_temp.json

echo $'\n'

cat metric_temp.json | jq '.'
echo $'\n'
echo "would you like to continue with the policy above? 1 to continue "
read choice

if [ $choice==1 ]
then
  echo "--Projects to be applied"
  projects=$(gcloud projects list | awk '{print $1}' | grep -v sys | grep -v PROJECT_ID)
  echo $projects
  echo $'\n'
  for project in $projects
  do
    echo "--Creating on project: $project"
    gcloud beta logging metrics create Audit-Config-Changes --config-from-file=metric_temp.json --project=$project
  done
else
  echo "Aborted"
fi