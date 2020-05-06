## handy to replace nth occurence of character with char recursively over string
## originated from need to split long GSEA pathway names. 
## credit to thelatemail (https://stackoverflow.com/questions/55874998/replace-nth-occurrence-of-a-character-in-a-string-with-something-else/55875048)

> replN <- function(x, fn, rp, n) {
     regmatches(x, gregexpr(fn, x)) <- list(c(rep(fn,n-1),rp))
     x
}

replN(i, "_", "\n", 2)
[1] "KEGG_METABOLISM\nOF_XENOBIOTICS\nBY_CYTOCHROME\nP450"
replN(i, "_", "\n", 4)
[1] "KEGG_METABOLISM_OF_XENOBIOTICS\nBY_CYTOCHROME_P450"
