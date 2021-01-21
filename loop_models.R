# loop over columns in df and specify regression formula and store in list.
# stat sig coeffcients filtered and presented in dt. 
# unlist to matrix, must manually add col + rownames

formula <- list(); model <- list(); summaries <- list(); coef <- list()
for(i in colnames(sleep)){

  formula[[i]] <- paste0("sleep ~ ", i, " + age + meds + smoke + location", sep="")
  model[[i]] <- glm.nb(formula[[i]], data=sleep)
  summaries[[i]] <- summary(model[[i]])
  df <- as.data.frame(coef(summaries[[i]]))
  coef[[i]] <- df[2,c(1:4)]
}

df <- data.frame(matrix(unlist(coef), nrow=length(coef), byrow=T))

names <- c( "Estimate",   "Std. Error",    "z value",   "Pr(>|z|)")
colnames(df) <- names
rownames(df) <- names(coef)

df <- df[c(1:17),]

df <- df[df[,4] < 0.1,]

datatable(df, filter="none", selection="multiple", escape=FALSE, 
      options = list(sDom  = '<"top">lrt<"bottom">ip') )
