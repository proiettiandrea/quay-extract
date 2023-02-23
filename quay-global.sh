#!/bin/bash

index_array=(global)
for i in ${index_array[@]}
    do
     filename=$i
     n=1
     while read line; do
     # reading each line
     echo "$i;$line"
     url="$i/$line"
     manifest=$(curl -k -X GET -H "Authorization: Bearer xxxxxxxxxxxxxxxxxxxxx" https://instance-quay-quay-registry.apps.ocps.sviluppo.inps.it/api/v1/repository/$url | jq | jq -r '.tags' | jq -r '.latest' | jq -r '.manifest_digest')
     latest=$(curl -k -X GET -H "Authorization: Bearer xxxxxxxxxxxxxxxxxxxxx" https://instance-quay-quay-registry.apps.ocps.sviluppo.inps.it/api/v1/repository/$url/manifest/$manifest | jq | grep -i manifest_data)
     echo "$i;$line;$latest" >> quay-global.csv
     n=$((n+1))
    done < $filename
done
