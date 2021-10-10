#!/usr/bin/env Rscript
##############################################################################
## Compare VCF tb files metrics 
##############################################################################
library("optparse")
library("reshape2")
library("ggplot2")
##############################################################################
option_list <- list(
  make_option(
    c("-i", "--input"), 
    type = "character", default = "results", 
    help = "Input data directory [default= %default]", metavar = "character"
  ),
  make_option(
    c("-o", "--out"), 
    type = "character", default = "results/qc", 
    help = "Output directory [default= %default]", metavar = "character"
  )
) 

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

#Check input data
if (is.null(opt$input)){
  print_help(opt_parser)
  stop("The input directory argument must be supplied", call.=FALSE)
}
##############################################################################
#Get all tab files

opt$input <- "../results"
  
files <- list.files(
  path = opt$input,
  pattern = "*.tab",
  full.names = TRUE,
  recursive = TRUE
)

#read files
tabs <- lapply(files, read.delim)

