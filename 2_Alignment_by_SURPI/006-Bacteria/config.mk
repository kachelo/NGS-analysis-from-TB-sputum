## The directory where the reference is used
SNAP_REFERENCEDIR='../../../reference/reference/chiulab.ucsf.edu/SURPI/databases/Bacterial_Refseq_05172012.CLEAN.LenFiltered.uniq.snap/'

## Here you should set aditional options for snap
##
## In example, SURPI defaults:
##
SNAP_OPTS='-x -f -h 250 -n 25'

## To filter unmatched regions:
SNAP_OPTS=$SNAP_OPTS' -F a '

## Recommended options by organism:
##
## - Human d12:
##- Mycobacterium
SNAP_OPTS=$SNAP_OPTS' -d 3'

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
SNAP_OPTS=$SNAP_OPTS' -t 2'
