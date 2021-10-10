##Number of threads for sambamba
#SAMBAMBA_THREADS=`cat /proc/cpuinfo | grep processor | wc -l`
SAMBAMBA_THREADS=8

##Memory limit for sambamba
SAMBAMBA_MEMORY=`free -h | grep Mem | awk '{print $2"B"}'`

