#!/bin/bash

index_array=(global af-pr af-ac af-ag af-az af-an af-ap af-bi af-cc af-ci af-cr af-cw af-cz af-gd af-gf af-gp af-gs af-ic af-ip af-it af-la af-ld af-pa af-pc af-pp af-rc af-rs af-sr af-vg af-sp devtest tanzutest testpipelinelab af-p)
for i in ${index_array[@]}
    do
           echo $i
           curl --silent --insecure GET -H 'Content-type: application/json' -H "Authorization: Bearer xxxxxxxxxxxxxxxxxxxxxx" "https://instance-quay-quay-registry.apps.ocps.sviluppo.inps.it/api/v1/repository?repo_kind=image&namespace=$i" | jq | grep name >> work1-$i
           awk '!/namespace/' work1-$i > work2-$i
           sed 's/"name":,\?//' work2-$i >> work3-$i
           sed 's/",\?//' work3-$i >> work4-$i
           sed 's/.$//' work4-$i >> work5-$i
           sed 's/.$//' work5-$i >> $i
           rm work*-$i
        done
