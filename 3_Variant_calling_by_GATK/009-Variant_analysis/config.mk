#PATH to executables. Should include java and other dependencies as directed by README.md of the pipeline.

#PATH to call GATK jar file
GATK="/usr/share/java/GenomeAnalysisTK3.8.jar"

############Reference Genome fasta file
##Para 1-H37RV
REF="../../reference/Mycobacterium_tuberculosis_H37Rv.fna"

############dbSNP
##Para 1-H37RV
dbSNP="../../known-variants/known_final.vcf"

############Coordenadas 
#Coordenadas de bed para correr para 1
coordenadas="../../known-variants/Bed-IGV+100_NC_000962.3.bed"

#Number of threads for parallelization of GATK and compression by bgzip
NT="3"
