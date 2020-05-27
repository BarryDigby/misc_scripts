## function to merge up-regulated + down-regulated table of DE results
## extract Log2FC and convert gene to entrez id
## Pay attention to input columns of DE results

format_CP <- function(df1, df2){
  df <- rbind(df1, df2)
  key <- c("Gene", "Log2FC")
  subset <- df[,c(key)]
  
  x <- getBM(attributes = c("entrezgene_id",
                            "external_gene_name"),
             filters = "external_gene_name",
             values = subset$Gene,
             mart = mart)
  
  colnames(subset) <- c("external_gene_name", "Log2FC")
  subset <- merge(subset, x, by="external_gene_name")
  subset <- subset[,c(3,2)]
  return(subset)
}

genes <- format_CP(up_regulated_table19, down_regulated_table19)

## average Log2Fc of dups
genes <- genes %>% 
  dplyr::select(entrezgene_id, Log2FC) %>% 
  na.omit() %>% 
  distinct() %>% 
  group_by(entrezgene_id) %>% 
  summarize(Log2FC=mean(Log2FC))

## convert from tibble back to DF
genes <- as.data.frame(genes)
gene_list <- genes[,2]
names(gene_list) <- genes[,1]

library(pathview)

x <- c("04012", "04350", "04917", "04390", "04066", "04370", "04510", "04520")
y <- c("ErbB_signaling", "TGF-beta_signaling", "Prolactin_signaling", "Hippo_signaling", "HIF-1_signaling", "VEGF_signaling", "Focal_Adhesion", "Adherens_Junction")
x_name <- "pathway_id"
y_name <- "pathway_name"

pathway_info <- data.frame(x,y)
names(pathway_info) <- c(x_name, y_name)

for(i in 1:nrow(pathway_info)){
  row <- pathway_info[i,]
  id <- row[,1]
  name <- row[,2]
  
  pathview(gene.data = gene_list, 
           pathway.id = paste(id),
           species = "hsa",
           limit = list(gene=c(-1,1), cpd=1),
           out.suffix = paste(name))
}
