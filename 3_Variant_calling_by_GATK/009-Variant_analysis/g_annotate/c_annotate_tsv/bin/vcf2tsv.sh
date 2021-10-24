#!/bin/bash

#Get present INFO fields
INFO="%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t%INFO/"`bcftools view \
  -h $1 \
  | awk 'BEGIN{FS=",|="}/##INFO/{print $3}' \
  | tr '\n' ',' \
  | sed -r \
      -e 's#,#\t%INFO/#g' \
      -e 's#%INFO/$##'
`

#Parse the file HEADER according to the extracted fields
HEADER=`echo "${INFO}" \
| sed -r \
  -e 's#%##g' \
  -e 's#\\t#\t#g' \
  -e 's#\tINFO/ANN##'
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
| tr '\n' '\t'`

#Finally get the data
bcftools view \
  $1 \
| bcftools query \
  -f "${INFO}\n" \
| awk -v head="${HEADER}${ANN}" '
BEGIN{
  print head
}
{
  ann=$NF
  n=split(ann,resArr,",")
  for(i=1;i<=n;++i){
      for(j=1;j<NF;++j){
        printf $j"\t"
      }  
      printf resArr[i]"\n"
  }
}
' \
| sed -r \
  -e 's#\|#\t#g' \
  -e 's#/#_#g' \
  -e "s#'##g" \
  -e 's#INFO_##g' 

