#!/usr/bin/bash

while IFS='' read -r line; do
        name=$(echo $line | awk '{print $4}')
        touch ${name}.bed
        echo "$line" >> ${name}.bed_tmp
        sed 's/[\t]*$//' ${name}.bed_tmp > ${name}.bed && rm ${name}.bed_tmp
        bedtools intersect -a GRCh38.gtf -b ${name}.bed -s -f 1.00 > ${name}.gtf
        start=$(echo $line | awk '{print $2}')
        stop=$(echo $line | awk '{print $3}')
        if [[ -s ${name}.gtf ]]
        then
        ./gtfToGenePred ${name}.gtf ${name}.genepred
            ./genePredToBed ${name}.genepred ${name}.bed
                awk -v OFS="\t" -v start="$start" -v stop="$stop" '{if($2==start && $3==stop) print $0}' ${name}.bed | head -n 1 > ${name}_bed12.bed
                rm ${name}.gtf
        rm ${name}.genepred
        rm ${name}.bed
        else
                block_count=1
                block_size=$(($stop - $start))
                rgb="0,0,0"
                block_start=0

                awk -v OFS="\t" -v thick=$start -v rgb=$rgb -v count=$block_count -v start=$block_start -v size=$block_size \
                '{print $0, thick, thick, rgb, count, size, start}' ${name}.bed > ${name}_bed12.bed
                rm ${name}.gtf
        rm ${name}.bed
        fi

done < genomic_coordinates_bed6.bed

cat *_bed12.bed > genomic_coordinates_bed12.bed
rm *_bed12.bed
