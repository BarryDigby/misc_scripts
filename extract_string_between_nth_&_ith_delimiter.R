## example: 

string <- "TCGA-G9-6496-01A-11R-1789-07"

delim_fn = function(x, n, i){
    do.call(c, lapply(x, function(X)
        paste(unlist(strsplit(X, "-"))[(n+1):(i)], collapse = "-")))
}

delim_fn(x = string, n = 0, i = 4)

## output = "TCGA-G9-6496-01A"
