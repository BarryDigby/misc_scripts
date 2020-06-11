#!/usr/bin/env nextflow

process foo {
	publishDir '/data/bdigby/circTCGA/xx1', pattern: '*.txt', mode: 'copy'
	publishDir '/data/bdigby/circTCGA/xx2', pattern: '*.out', mode: 'copy'

	output:
	file '*{txt,out}' 

	script:
	'''
	conda env list | grep "circexplorer2" | tr -s ' ' | cut -d' ' -f2 > conda.txt
	echo "Start stop test"  > conda.out
	'''
}
