#https://jhubiostatistics.shinyapps.io/recount/
library(recount) 
library(SummarizedExperiment)
load("~/Documents/Programming/R/TCGA/rse_gene.Rdata")
rse_gene_se <- as(object = rse_gene, Class = "SummarizedExperiment")
rse_gene[rowData(rse_gene)$gene_id == "ENSG00000000003.14", 1:5]
features <- unlist(rowData(rse_gene)$symbol)
source("https://bioconductor.org/biocLite.R")
biocLite("recount")
rse1 <- scale_counts(rse_gene)
