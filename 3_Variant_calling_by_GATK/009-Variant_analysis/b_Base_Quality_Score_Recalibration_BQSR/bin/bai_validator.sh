## This script checks if BAM files were created before the respective BAI file.
## For use in INMEGEN/100G project.
## It searchs in results/ directory for bam files with bai files already created; then compares timestamps.
## If .bai file timestamp is older than .bam file, it deletes .bai file and creates a new one for the corresponding .bam file.

#!/bin/bash

for BAM_FILE in results/*.bam
do
##	echo "[DEBUGGING] validating .bai index for "$BAM_FILE
	BAI_FILE="$BAM_FILE.bai"
	BAM_TIME=$(date -r $BAM_FILE +%s)
	BAI_TIME=$(date -r $BAI_FILE +%s)
##	echo ["DEBUGGING] times are bam=$BAM_TIME bai=$BAI_TIME"

	if [ $BAI_TIME -ge $BAM_TIME ];
	then
		echo "[OK] BAI was generated after $BAM_FILE"
		continue
	else
		echo "[WARNING] $BAI_FILE was generated BEFORE BAM for $BAM_FILE"
		echo "[DEBUGGING] removing $BAI_FILE"
##		rm $BAI_FILE &&
##		samtools index $BAM_FILE
	fi
done
