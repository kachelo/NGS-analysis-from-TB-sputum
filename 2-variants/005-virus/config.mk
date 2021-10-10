# The directory where the reference is used
SNAP_REFERENCEDIR='../../references/chiulab.ucsf.edu/SURPI/databases/viruses-5-2012_trimmedgi-MOD_addedgi.snap/'

##Number of threads
NT='3'

## Here you should set aditional options for snap
##
## In example, SURPI defaults:
##
SNAP_OPTS='-x -f -h 250 -n 25'

## To filter unmatched regions:
##lo cual es equivalente a -E um (filtrar y dejar los no alineados)
SNAP_OPTS=$SNAP_OPTS' -F u'

## Recommended options by organism:
##
## - Human:
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
SNAP_OPTS=$SNAP_OPTS' -t '$NT
