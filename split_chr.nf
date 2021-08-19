#!/usr/bin/env nextflow

// substitute the conditional for something sensible, or remove it altogether.

params.conditional = 'yes' 
params.outdir = "."
ch_fasta = Channel.value(file("genome.fa"))


if(params.conditional == 'yes'){
    file("${params.outdir}/reference_genome/chromosomes").mkdirs()
    ch_fasta.splitFasta(record: [id:true])
            .map{ record -> record.id.toString() }
            .flatten()
            .set{ ID }

    ch_fasta.splitFasta(file: true)
            .flatten()
            .merge(ID).map{ it -> 
                            file = it[0]
                            chr_id = it[1]
                            file.copyTo("${params.outdir}/reference_genome/chromosomes/${chr_id}.fa")
                          }

    ch_chromosomes = Channel.value("${params.outdir}/reference_genome/chromosomes")
}
