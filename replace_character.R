## handy to replace nth occurence of character with char recurrently over string

> replN <- function(x, fn, rp, n) {
     regmatches(x, gregexpr(fn, x)) <- list(c(rep(fn,n-1),rp))
     x
}

replN(i, "_", "\n", 2)
[1] "KEGG_METABOLISM\nOF_XENOBIOTICS\nBY_CYTOCHROME\nP450"
replN(i, "_", "\n", 4)
[1] "KEGG_METABOLISM_OF_XENOBIOTICS\nBY_CYTOCHROME_P450"
