##
library("ggplot2")
library("reshape2")

##Exploring PCA QC
setwd("/labs/lf/tb/analisis/007-qc-qualimap/bin")
datos<-read.csv(file="../wholeTuberculosis.tab", sep="\t")
bacilos<-read.csv(file="../1_qc.tab.bk.txt", sep="\t", header=FALSE)
sequencer<-read.csv(file="../1_qc.tab.seq", sep="\t", header=FALSE)
names(bacilos)<-c("Sample", "File","Bacilli")
names(sequencer)<-c("Sample", "File","Sequencer")

completa<-merge(x=datos, y=bacilos, by.x="Sample", by.y="Sample")
completa<-merge(x=completa, y=sequencer, by.x="Sample", by.y="Sample")
completa$File.x<-NULL
completa$File.y<-NULL
completa$Duplicated<-completa$Group

##PCA calculation
pca<-prcomp(completa[,3:7])
summary(pca)
# Importance of components:
#                             PC1      PC2      PC3     PC4     PC5
# Standard deviation     184.6191 23.99103 16.77163 4.74529 1.23938
# Proportion of Variance   0.9748  0.01646  0.00804 0.00064 0.00004
# Cumulative Proportion    0.9748  0.99127  0.99931 0.99996 1.00000

pca$rotation
#                               PC1         PC2         PC3          PC4         PC5
# Coverage.mean         0.064710357  0.97001101 -0.15601652 -0.172692256 -0.02697114
# Coverage.std          0.994005360 -0.05263019  0.09521069 -0.009881846  0.00454756
# GC.percentage        -0.003091198  0.08177194  0.05806532  0.255515050  0.96158425
# Mapping.quality.mean -0.007075441  0.19896122  0.28981788  0.895628711 -0.27243198
# Insert.size.median   -0.087785510  0.10018228  0.93767147 -0.320376349  0.01970844

#Exploring
screeplot(pca)
biplot(pca)
barplot(pca$rotation[,1])
barplot(pca$rotation[,2])
head(pca$rotation)

mascara<-c("red", "green", "blue", "black")
names(mascara)<-levels(bacilos$Group)

#Join data
datosp<-cbind(as.data.frame(pca$x), completa)
datosp$Bacilli<-factor(as.character(datosp$Bacilli), 
  levels=c("NEG", "+", "++",  "+++"))          
datosp$Sample<-gsub(pattern="1/", replacement = "", fixed = TRUE, as.character(datosp$Sample))    

##Pattern??
p<-ggplot(datosp, 
    aes(x=PC1, y=PC2, shape=Duplicated, size=Bacilli, color=Sequencer, label=Sample)
  )+
  geom_point()+
  geom_text(color="black", size=3)+
  theme_bw()+
  theme(panel.grid = element_blank())+
  xlab("PC1 97.48%")+
  ylab("PC2 1.64%")
p
  
##Que pasa con los sujetos
summary(completa[, 3:4])
#  Coverage.mean       Coverage.std     
# Min.   : 0.114   Min.   :  0.4127  
# 1st Qu.: 3.703   1st Qu.: 33.2535  
# Median : 7.420   Median :264.6747  
# Mean   :21.306   Mean   :227.4280  
# 3rd Qu.:30.541   3rd Qu.:353.7630  
# Max.   :96.123   Max.   :607.5982

completa[order(completa$Coverage.mean), 1:6][c(1:3, 20:22, 46:47),]
#    Sample      Group Coverage.mean Coverage.std GC.percentage Mapping.quality.mean
# 7    1/22     Sample        0.1140       0.7726         63.86              20.8999
# 28   1/35     Sample        0.1140       0.4127         64.36              39.8132
# 11  1/24D Duplicated        0.1971      11.9641         58.66              17.8702
# 16   1/28     Sample        6.1837     308.1116         58.93              16.9751
# 25  1/32D Duplicated        6.5762      26.6176         64.67              36.9258
# 2    1/05     Sample        6.9014      33.3802         63.85              16.7209
# 43   1/54     Sample       86.4573     362.5378         64.68              31.4183
# 46   1/57     Sample       96.1232     380.7067         65.00              31.4089

completa[order(completa$Coverage.std), 1:6][c(1:3, 20:22, 46:47),]
#    Sample  Group Coverage.mean Coverage.std GC.percentage Mapping.quality.mean
# 28   1/35 Sample        0.1140       0.4127         64.36              39.8132
# 7    1/22 Sample        0.1140       0.7726         63.86              20.8999
# 15   1/27 Sample        0.2506       1.1221         64.55              37.2749
# 10   1/24 Sample       28.7955     213.5392         63.50              27.8327
# 35   1/46 Sample        4.4783     222.2365         59.47              16.7996
# 47   1/58 Sample       47.1571     225.4085         64.35              26.4758
# 22   1/31 Sample        9.1772     591.6530         57.47              13.0114
# 12   1/25 Sample       23.0269     607.5982         61.58              21.7232

