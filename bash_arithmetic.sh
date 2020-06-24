#!/usr/bin/bash

## script from calculating genomic position of miRNA binding sites in circRNAs for Ago2 overlaps. 
## double quotes in bash >> expr / let 

        while read line
        do

        ## grab circRNA info
        circ=$(echo $line | awk '{print $2}')
        circ_chr=$( cut -d':' -f1 <<< "$circ")
        circ_start=$( cut -d':' -f2 <<< "$circ" | cut -d'-' -f1)
        circ_stop=$( cut -d':' -f2 <<< "$circ" | cut -d'_' -f1 | cut -d'-' -f2)

        ##calculate genomic postion of miRNA site
        ##with respect to circ coordinates
        mirna=$(echo $line | awk '{print $1}')
        mirna_start=$(echo $line | awk '{print $7}')
        mirna_stop=$(echo $line | awk '{print $8}')

        mirna_genomic_start=$(($circ_start + $(($mirna_start -1))))
        mirna_genomic_stop=$(($circ_start + $(($mirna_stop -1))))

        echo "original circRNA: $circ"
        echo -e "subject Aln: $mirna_start $mirna_stop"

        echo -e "calc coords: $circ_chr\t$mirna_genomic_start\t$mirna_genomic_stop"


        done < ${base}_filtered.txt
