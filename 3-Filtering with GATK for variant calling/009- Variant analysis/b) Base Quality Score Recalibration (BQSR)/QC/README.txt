##################################################
## QC scripts for stage 002 of mk-gatk pipeline ##

For automatic execution of QC test just run:

````
mk QC

````

## bam.flagstat_comparison.tsv	##

Tab separated file in long format. It uses GATK's FlagStat tools as described at:

https://software.broadinstitute.org/gatk/documentation/tooldocs/current/org_broadinstitute_gatk_tools_walkers_qc_FlagStat.php

Format is:

````
Number_of_reads	Read_category	File

````
