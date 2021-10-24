#!/usr/bin/env Rscript
###############################################################################
## Generate VCF missing data visualization
##  - Variants across the individual using Allele number
##  - Individual genome accessibility for al the variants positions
###############################################################################
#packrat::init()
library("ggplot2")
library("reshape2")
library("cowplot")
library("optparse")
###############################################################################
option_list = list(
  make_option(
    c("-f", "--file"), 
    type="character", 
    default=NULL, 
    help="Input .tab file", 
    metavar="character"
  ),
  make_option(
    c("-o", "--outdir"), 
    type="character", 
    default="results", 
    help="Output directory [default= %default]",
    metavar="character"
  )
) 

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

#Check for input file
if (is.null(opt$file)){
  print_help(opt_parser)
  stop("The input .tab file must be supplied", call. = FALSE)
}
###############################################################################
#load the data
vcf <- read.csv(
  file = opt$file,
  sep = "\t",
  header = FALSE,
  na.strings = c(".", "./."),
  stringsAsFactors = FALSE
)
names(vcf) <- as.character(
  do.call(
    c, 
    lapply(
        vcf[1,], 
        as.character
    )
  )
)
#make file corrections
#remove name row and NA columns 
vcf <- vcf[-1, , drop = FALSE]
vcf <- vcf[, !is.na(names(vcf))]
#make numeric Allele Number
vcf$AN <- as.integer(as.character(vcf$AN))

#Generate AN density
pan <- ggplot(
  data = vcf,
  aes(x = AN)
) +
  geom_density() +
  xlab("Allele number") +
  theme_bw() +
  coord_flip()
#pan 

#Exploring
#summary(vcf$AN)
#table(vcf$AN)

#Sort by missing subject
ids <- colSums(is.na(vcf[, -(1:4)]))
vcf[, -(1:4)] <- vcf[, -(1:4)][,order(ids)]
#Sort by AN
vcf <- vcf[order(vcf$AN), ]
vcf$y <- 1:nrow(vcf)

psub_missing <- ggplot(
  data = as.data.frame(ids),
  aes(x = ids)  
) + 
  geom_density() +
  theme_bw() + 
  xlab("# of missing variants")
#psub_missing

# Subject: Individual genome accessibility for al the variants positions
mvcf <- melt(
  vcf,
  id.vars = c("#POS", "REF", "ALT", "AN", "y"),
  value.name = "Genotype",
  variable.name = "Sample"
#little tunning
)
mvcf$x <- as.integer(mvcf$Sample)
mvcf$Genotype <- factor(mvcf$Genotype)

#Tile plots
psub <- ggplot(
  data = mvcf,
  aes(
    x = x,
    y = y,
    fill = Genotype
  )
) +
  geom_tile() +
  theme_bw() + 
  xlab("Samples order by NA content") +
  ylab("Variant order by Allele Number") +
  theme(
    legend.position = "bottom"
  )
#psub

#Joined pannel
ppannel <- plot_grid(
  plotlist = list(
    psub_missing, NULL,
    psub, pan),
  ncol = 2,
  nrow = 2,
  rel_widths = c(8, 2),
  rel_heights = c(2, 8)
)
#ppannel
ggsave(
  ppannel,
  file = paste(opt$outdir, "panel.build.pdf", sep = "/"),
  width  = 10,
  height = 7
)

#Summary data to make a desition
an_summary <- t(summary(vcf$AN))
write.table(
  an_summary,
  file = paste(opt$outdir, "AN_summary.build.tab", sep = "/"),
  quote= FALSE,
  row.names = FALSE,
  sep = "\t"
)
ids <- as.data.frame(t(t(ids)))
names(ids) <- "Missing_Variants"
ids$Sample <- row.names(ids)
ids$Missing_Percentage <- round(
  ids$Missing_Variants/nrow(vcf)*100,
  2
)
missing_variants <- t(summary(ids$Missing_Variants))
write.table(
  missing_variants,
  file = paste(opt$outdir, "missing_variants_summary.build.tab", sep = "/"),
  quote= FALSE,
  row.names = FALSE,
  sep = "\t"
)

ids$Remove <- ids$Missing_Variants > quantile(ids$Missing_Variants, 0.75)
#table(ids$Remove) 

ids <- ids[order(ids$Missing_Percentage), ]
write.table(
  ids,
  file = paste(opt$outdir, "sample_summary.build.tab", sep = "/"),
  quote= FALSE,
  row.names = FALSE,
  sep = "\t"
)
