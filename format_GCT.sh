#!/usr/bin/env bash

## Script to convert DESeq2 normalized counts to GCT format
## Made using following code:
## write.table(norm_counts, file="norm_counts.txt", 
## append = TRUE, sep="\t", row.names = TRUE,
## col.names = TRUE, quote = FALSE)

if [ "$1" == "-h" ]; then
  echo "Usage: bash `basename $0` [FILE] [OUT_PREFIX]"
  echo
  echo "Example: bash `basename $0` norm_counts.txt GSE118959"
  exit 0
fi

if [ "$1" != "" ]; then
    echo "Counts File: $1"
else
    echo "Counts File is missing"
fi

if [ "$2" != "" ]; then
    echo "Output Prefix: $2"
else
    echo "Output Prefix is missing"
fi

FILE=$1
OUT=$2

LEN=`wc -l $FILE | awk '{print $1}'`
TMP=`awk '{print NF}' $FILE | sort -nu | tail -n 1`
SAMPLES=`expr $TMP - 1`

cat $FILE \
| awk -F"\t" '{if(NR==1) $1="NAME"FS$1}1' OFS="\t" \
| awk '{$1 = $1 OFS (NR==1?"Description":"na")}1' \
| sed 's/ /\t/g' \
| awk -v LEN=$LEN -v SAMPLES=$SAMPLES \
 'BEGIN{print "#1.2""\n"LEN"\t"SAMPLES}1' > ${OUT}.gct
