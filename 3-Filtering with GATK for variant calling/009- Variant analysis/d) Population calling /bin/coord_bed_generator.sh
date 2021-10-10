###This script takes a truncated vcf as input. Truncated vcf comes from a failed execution of mkfile in 004 for a joint genotyping.
###This script takes a look at the truncated vcf to see which cromosomes were correctly evaluated.
###It stores the value for last evaluated contig, and last evaluated position at that contig.
###With that info, it builds a coord.bed starting from the last evaluated position, and ending with the last contig in the truncated vcf header.

### Script use is bash coord_bed_generator.sh <failed.vcf.build>


#!/bin/bash

mkdir -p tmp_for_coord_bed

bcftools view -h $1 \
| grep "##contig=" \
| cut -d"=" -f3- \
| sed -e "s#,length=#\t1\t#g" \
| tr -d ">" > tmp_for_coord_bed/header_contigs.list

LAST_CONTIG_ANALYZED=$(tail -n1 $1 | cut -f1)
LAST_POSITION_ANALYZED=$(tail -n1 $1 | cut -f2)
LAST_CONTIG_LENGTH=$(grep -w $LAST_CONTIG_ANALYZED tmp_for_coord_bed/header_contigs.list | cut -f3)
LAST_CONTIG_LINE=$(grep -n -w $LAST_CONTIG_ANALYZED tmp_for_coord_bed/header_contigs.list | cut -d":" -f1)

tail -n+$LAST_CONTIG_LINE tmp_for_coord_bed/header_contigs.list \
| sed "1c$LAST_CONTIG_ANALYZED\t$LAST_POSITION_ANALYZED\t$LAST_CONTIG_LENGTH" > coord.bed.build \
&& mv coord.bed.build coord.bed \
&& rm -r tmp_for_coord_bed

