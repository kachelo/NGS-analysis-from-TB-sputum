# The directory where the reference is used
SNAP_REFERENCEDIR="../../references/resources-broad-hg38-v0-Homo_sapiens_assembly38.snap"
SNAP="../../softwares/snap/snap-aligner"	

## Here you should set aditional options for snap
##
## In example, SURPI defaults:
##
SNAP_OPTS='-x -f -h 250 -n 25'

## To filter unmatched regions:
SNAP_OPTS=$SNAP_OPTS' -F u'

## Recommended options by organism:
##
## - Human:
SNAP_OPTS=$SNAP_OPTS' -d 12'

## Recommended cache options:
##
## - lots of memory:
SNAP_OPTS=$SNAP_OPTS' -map'
##
## - less memory:
#SNAP_OPTS+=' -pre -map'

## By default SNAP uses all available cores.
## to use less cores, uncomment the following option,
## where 24 is the max number of cores you want to use:
SNAP_OPTS=$SNAP_OPTS' -t 4'
