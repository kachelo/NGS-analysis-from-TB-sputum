## The SNAP executable
SNAP="../../softwares/snap/snap-aligner"

## The directory where the reference is used
SNAP_REFERENCEDIR='Mycobacterium_tuberculosis_H37Rv.snap'

## Here you should set aditional options for snap
##
## In example, SURPI defaults:
##
SNAP_OPTS='-x -f -h 250 -n 25'

## To filter unmatched regions:
SNAP_OPTS=$SNAP_OPTS' -F a '

## Recommended options by organism:
## - Human:-d 12
## -d 3 for Mycobacterium tuberculosis
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
SNAP_OPTS=$SNAP_OPTS' -t 8'
