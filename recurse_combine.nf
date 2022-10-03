#!/usr/bin/env nextflow

// mkdir tester
// touch tester/{A,B,C}.{.txt,.csv}
// output channel [ [A, A.txt, A.csv], [B, B.txt, B.csv], [C, C.txt, C.csv] ]

files = collect_files(file(params.input))
files.view()

def collect_files(input){
    txt_files = []
    csv_files = []
    input.eachFileRecurse{ it ->
        id  = it.simpleName
        txt = it.name.endsWith('.txt') ? file(it) : []
        csv = it.name.endsWith('.csv') ? file(it) : []
        txt_files << [ id, txt ]
        csv_files << [ id, csv ]
    }
    Channel.fromList( txt_files ).filter{ id, txt -> txt.toString().contains('.txt') }.set{ collect_txt }
    Channel.fromList( csv_files ).filter{ id, csv -> csv.toString().contains('.csv') }.set{ collect_csv }
    out = collect_txt.combine(collect_csv, by:0)
}
