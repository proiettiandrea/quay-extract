#!/bin/bash

index_array=(af-pr af-ac af-ag af-az af-an af-ap af-bi af-cc af-ci af-cr af-cw af-cz af-gd af-gf af-gp af-gs af-ic af-ip af-it af-la af-ld af-pa af-pc af-pp af-rc af-rs af-sr af-vg af-sp devtest tanzutest testpipelinelab af-p)
for i in ${index_array[@]}
    do
     filename=$i
     n=1
     while read line; do
     # reading each line
     echo "$i;$line"
     url="$i/$line"
     manifest=$(curl -k -X GET -H "Authorization: Bearer xxxxxxxxxxxxxxxxxxxxxxxx" https://instance-quay-quay-registry.apps.ocps.sviluppo.inps.it/api/v1/repository/$url | jq | jq -r '.tags' | jq -r '.latest' | jq -r '.manifest_digest')
     latest=$(curl -k -X GET -H "Authorization: Bearer xxxxxxxxxxxxxxxxxxx" https://instance-quay-quay-registry.apps.ocps.sviluppo.inps.it/api/v1/repository/$url/manifest/$manifest | jq | grep -i manifest_data)
     echo "$i;$line;$latest" >> quay-af.csv
     n=$((n+1))
    done < $filename
done
rm -r af-*
rm -r global
rm -r devtest
rm -r tanzutest
rm -r testpipelinelab
