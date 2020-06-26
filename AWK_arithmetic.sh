#!/usr/bin/bash

##improvement over while read and bash double quotes $(()) math operators. 

##EG:

awk '{sum = $2 -1; print sum}' ciriq.bed | head -n 2
