#!/bin/bash

#Get the FORMAT fields in long format
#[%POS\t%ID\t%REF\t%ALT\t%SAMPLE\t%GT\t%AD\t%DP\t%GQ\t%PL\n]
FORMAT=`bcftools view \
  -H $1 \
| head -n 1 \
| cut -f9 \
| sed -r \
  -e 's#:#\\t%#g' \
  -e 's#^#[%INFO/ANN\t%POS\\t%ID\\t%REF\\t%ALT\\t%SAMPLE\\t%#' \
  -e 's#$#\\n]#' \
  -e 's#(PL[ ]*)$#PL]#g' \
  -e 's#NL#kk3#'
`

#Parse ANN FIELDS
ANN=`bcftools view \
  -h $1 \
| awk '
  BEGIN{
    FS="[\|]";
    print "Allele"
  }
  /##INFO=<ID=ANN/{
    for(i=2; i<=NF; ++i) print $i
  }
' \
| sed -r \
  -e 's# ##g' \
  -e 's#\.#_#g' \
  -e 's#["|>]##g' \
| tr '\n' '\t'
`

#HEAD for future reference
HEAD=`echo $ANN$FORMAT \
| sed -r \
  -e 's#AD#AD_REF\tAD_ALT#' \
  -e 's#PL #PL_1\tPL_2\tPL_3#' \
  -e 's#[%|\[]*##g' \
  -e 's# #\t#g' \
  -e 's#INFO/ANN\t##' \
| tr "]" "_"
`

#Finally get the data
bcftools view \
  $1 \
| bcftools query \
  -f "${FORMAT}" \
| awk -v head="${HEAD}" '
  BEGIN{
    print head
  }
  {
    ann=$1
    n=split(ann,resArr,",")
    for(i=1;i<=n;++i){
	printf resArr[i]"\t"
	for(j=2;j<=NF;++j){
		printf $j"\t"
	}
	printf "\n"
    }
  }
' \
| sed -r \
  -e 's#([0-9]*),([0-9]*),([0-9]*)#\1\t\2\t\3#g' \
  -e 's#([0-9]*),([0-9]*)#\1\t\2#g' \
  -e 's#\|#\t#g' 
#| cut -f2-6,10-11,17-28

