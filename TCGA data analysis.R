#https://jhubiostatistics.shinyapps.io/recount/
#http://127.0.0.1:30842/library/recount/doc/recount-quickstart.html
library(recount) 
library(SummarizedExperiment)
library(tidyverse)
library(Homo.sapiens)
library(edgeR)
load("~/Documents/Programming/R/TCGA/rse_gene.Rdata")
features <- unlist(rowData(rse_gene)$symbol)
sample_metadata <- as_tibble(colData(rse_gene))
feature_metadata <- as_tibble(rowData(rse_gene))
rse_gene <- scale_counts(rse_gene)
#http://leekgroup.github.io/recount-analyses/example_de/recount_SRP019936.html
#subsample for computational speed
set.seed(123456)
test_RSE <- rse_gene[, sample(dim(rse_gene)[2], 500)]

genes <- read_rds(path = "~/Documents/Programming/R/TCGA/TCGA/genes.rds")
gene_annotation <- AnnotationDbi::select(Homo.sapiens, keys=genes$V2, columns=c("SYMBOL", "ENTREZID", "ENSEMBL"), 
                keytype="ENTREZID")
ensembl_names <- rowData(test_RSE)$symbol %>% unlist %>% names
#select only gene coding transcripts
test_RSE <- test_RSE[na.omit(match(x = ensembl_names, table = gene_annotation$ENSEMBL, nomatch = NULL)),]
feature_filter <- rowMeans(assay(test_RSE))>5
test_RSE <- test_RSE[feature_filter,]