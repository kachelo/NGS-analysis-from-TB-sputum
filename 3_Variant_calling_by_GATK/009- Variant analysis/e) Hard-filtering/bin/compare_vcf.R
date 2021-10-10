################################################################
## Which vcf 1-H37Rv or 0-Bed
################################################################
library("vcfR")
library("limma")
#vcf files
h37 <- read.vcfR(
  "../results-d3/1-H37R/Llamado-conjunto_raw.hard_filtered.vcf",
  verbose = FALSE
)
bed <- read.vcfR(
  "../results-d3/0-Bed/Llamado-conjunto_raw.hard_filtered.vcf",
  verbose = FALSE
)
#bed file
Bed <- read.delim(
  "Bed174_+100_NC_000962.3.bed",
  sep = "\t",
  header = FALSE
)
names(Bed) <- c("chr", "start", "end", "gene", "strand")
#Fix part
h37 <- as.data.frame(getFIX(h37))
bed <- as.data.frame(getFIX(bed))

#Convert coordenadas del bed -> h37
#Strand positivos
positivos <- Bed[Bed$strand == "+", c("gene", "start")]
negativos <- Bed[Bed$strand == "-", c("gene", "start", "end")]

#mascara
corrimiento <- Bed$start
names(corrimiento) <- Bed$gene

bed2 <- bed
bed2$POS <- as.integer(as.character(bed2$POS))
bed2$POS <- bed2$POS + corrimiento[as.character(bed2$CHROM)]

table(
  compartidas = h37$POS %in% bed2$POS,
  filter = as.character(h37$FILTER)
)
#                   filter
# compartidas hard_filter PASS
#       FALSE           9    8   17
#       TRUE          248  738  986

table(
  compartidas = bed2$POS %in% as.character(h37$POS),
  filter = as.character(bed2$FILTER)
)
#                     filter
# compartidas hard_filter PASS
#       FALSE          13   13  26
#        TRUE         275  714  989

chisq.test(matrix(c(13,13,9,8), nrow=2))
# data:  matrix(c(13, 13, 9, 8), nrow = 2)
# X-squared = 0, df = 1, p-value = 1
discrepantes <- h37[!h37$POS %in% bed2$POS, ]
discrepantes[discrepantes$FILTER == "PASS", ]
x = as.numeric(as.character(discrepantes$QUAL[discrepantes$FILTER == "PASS"]))
y = bed2[!as.character(bed2$POS) %in% as.character(h37$POS), ]
y = as.numeric(as.character(y$QUAL[y$FILTER == "PASS"]))
boxplot(log(cbind(h37=c(x, rep(NA, 26-8)), bed=y)))
calidades <- log(cbind(h37=c(x, rep(NA, 26-8)), bed=y))
t.test(x = calidades[,1], y=calidades[,2])
# Welch Two Sample t-test
# 
# data:  calidades[, 1] and calidades[, 2]
# t = -3.7488, df = 9.6202, p-value = 0.004057
wilcox.test(x = calidades[,1], y=calidades[,2])
# Wilcoxon rank sum test with continuity correction
# 
# data:  calidades[, 1] and calidades[, 2]
# W = 28, p-value = 0.002153
# alternative hypothesis: true location shift is not equal to 0

pos <- unique(
  c(as.character(h37$POS), 
    as.character(bed2$POS)
    )
)
datos <- cbind(h37 = pos %in% as.character(h37$POS), 
               bed = pos %in% as.character(bed2$POS)
          )
vennDiagram(vennCounts(datos))
length(pos)

#           CHROM     POS   ID                  REF      ALT     QUAL FILTER
# 37  NC_000962.3   24697 <NA> AGCCGCGTTGCTCGGGGTAA     AG,A 35533.07   PASS
# 80  NC_000962.3  244393 <NA>                    T        C    65.63   PASS
# 241 NC_000962.3  835526 <NA>                    G        A    54.97   PASS
# 266 NC_000962.3 1014191 <NA>                    C        T   407.68   PASS
# 268 NC_000962.3 1027179 <NA>                    T       TC    46.66   PASS
# 448 NC_000962.3 2215209 <NA>                    C        T    27.88   PASS
# 666 NC_000962.3 3296371 <NA>                    G GCCGCGGC    95.95   PASS
# 846 NC_000962.3 3805526 <NA>                    T        G  1914.04   PASS
3805526-3805521 5 de acrA1

h37completo <- read.vcfR(
  "../results-d3/1-H37R/Llamado-conjunto_raw.hard_filtered.vcf",
  verbose = FALSE
)

#Ejemplo
# 37  NC_000962.3   24697 <NA> AGCCGCGTTGCTCGGGGTAA     AG,A 35533.07   PASS
id <- which(as.character(h37$POS) == as.character(24697))
id <- which(as.character(h37$POS) == as.character(244393))
h37completo@gt[id, ]
h37completo@fix[id,]

#"AC=27,2;AF=0.466,0.034;AN=58;BaseQRankSum=1.80;ClippingRankSum=0.00;DP=2165;ExcessHet=0.0001;FS=1.053;InbreedingCoeff=0.7236;MLEAC=28,2;MLEAF=0.483,0.034;MQ=41.72;MQRankSum=1.02;QD=34.24;ReadPosRankSum=-2.364e+00;SOR=0.475;set=variant2" 
gt <- extract.gt(h37completo)
gt[id, ]
#   02    05    12    13    21    22    23    24    25    26    27    28    29    30    31    32 
# "0/0" "0/0" "1/1" "1/1"    NA "0/0" "0/0" "1/1" "1/1" "1/1" "0/0" "0/0" "0/0" "0/1" "0/0" "0/1" 
# 33    34    35    36    39    41    42    43    45    46    47    48    49    50    51    52 
# NA "0/0"    NA "1/1" "2/2" "1/1" "0/0" "0/0"    NA    NA    NA "1/1" "1/1" "1/1" "0/1" "1/1" 
# 53    54    55    56    57    58 
# NA "0/0"    NA    NA "1/1" "0/0"

# 02    05    12    13    21    22    23    24    25    26    27    28 
# NA    NA    NA "1/1"    NA    NA "0/0"    NA    NA    NA    NA    NA 
# 29    30    31    32    33    34    35    36    39    41    42    43 
# "0/0" "0/0"    NA "0/0"    NA    NA    NA    NA "0/0" "0/0"    NA    NA 
# 45    46    47    48    49    50    51    52    53    54    55    56 
# NA    NA    NA    NA "0/0" "0/0" "0/0"    NA    NA "0/0"    NA    NA 
# 57    58 
# "0/0" "0/0" 

#Controlando
# 846 NC_000962.3 3805526 <NA>                    T        G  1914.04   PASS
id <- which(h37$POS == 3805526)
h37completo@gt[id, ]
h37completo@fix[id,]
# "AC=4;AF=0.087;AN=46;DP=265;ExcessHet=0.0154;FS=0.000;InbreedingCoeff=0.7013;MLEAC=4;MLEAF=0.087;MQ=58.27;QD=31.38;SOR=2.760;set=variant"
gt[id, ]
# 02    05    12    13    21    22    23    24    25    26    27    28    29    30    31    32 
# NA    NA "0/0" "0/0"    NA    NA "0/0" "0/0" "0/0" "0/0"    NA "0/0" "0/0" "0/0" "0/0" "0/0" 
# 33    34    35    36    39    41    42    43    45    46    47    48    49    50    51    52 
# NA "0/0"    NA "0/0" "0/0" "0/0"    NA    NA    NA    NA    NA "0/0" "1/1" "0/0" "0/0" "0/0" 
# 53    54    55    56    57    58 
# NA "0/0"    NA    NA "1/1" "0/0" 


# head(Bed)
# head(bed)
# Bed[Bed$gene == "gyrB",]
# 5140+89
# 5140+612
# 5140+811
# 5140+888
#   
# head(negativos)
# #       gene  start    end
# # 4     fhaA  23761  25544
# negativos[negativos$gene == "katG",]
# #    gene   start     end
# # 83 katG 2153789 2156211
# head(bed[bed$CHROM == "katG",])
# #     CHROM  POS   ID REF ALT     QUAL      FILTER
# # 434  katG 1379 <NA>   C   G 17927.32        PASS
# 1379+2153789
# 
