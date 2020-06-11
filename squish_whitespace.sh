#!/bin/bash

## parsing outputs that have multiple whitespaces and not tabs
## tr -s 'squish' 

conda env list | grep "my_env" | tr -s ' ' | cut -d' ' -f2
