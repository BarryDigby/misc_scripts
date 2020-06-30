#!/usr/bin/bash

## instead of using index, print columns accoring to column headers 

awk 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}} {print $(f["PCT_contribution"]), $(f["context++_score"])}' test.context_scores.txt
