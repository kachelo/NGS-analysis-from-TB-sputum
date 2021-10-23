#PATH to executables. Should include java and other dependencies as directed by README.md of the pipeline.

#PATH to call GATK jar file
GATK="../../../softwares/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar"

############Reference Genome fasta file
##Para 1-H37RV
REF="../../../references/www.ncbi.nlm.nih.gov/nuccore/NC_000962.3/Mycobacterium_tuberculosis_H37Rv.fa"

############dbSNP
##Para 1-H37RV
dbSNP="../../../references/known_variants/known_final.vcf"

############Coordenadas 
#Coordenadas de bed para correr para 1
coordenadas="../../../references/known_variants/Bed-IGV+100_NC_000962.3.bed"

#Number of threads for parallelization of GATK and compression by bgzip
NT="3"
