# silly code but useful for plots, cycle through all of the color palettes and see which ones look the best
# be usre to change rev=T to rev=F for round 2!

pals <- hcl.pals()
for(pal in pals){
  color = pal
  map <- Heatmap(t(jacc_df), cluster_rows = F, cluster_columns = F, 
        col = hcl.colors(100,color,rev=F), show_heatmap_legend = F,
        row_names_side = "left", column_names_rot = 45, 
        column_title = paste0(color,"Jaccard Index"),
        width = ncol(out_df)*unit(1, "cm"), 
        height = nrow(out_df)*unit(1, "cm"),
        row_order = c(8,7,6,5,4,3,2,1),
        border = T, column_title_gp = gpar(fontface="bold", fontsize=14),
        cell_fun = function(j, i, x, y, width, height, fill){
        grid.text(sprintf("%.2f", jacc_df[i, j]), x, y, gp = gpar(fontsize = 10))}, 
        rect_gp = gpar(col = "black", lwd = 1))
  draw(map)
  Sys.sleep(1)
}
