# Here you can set optional parameters for trimmomatic
# see <http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf>
#
#TRIMMOMATIC_OPTARGS=$TRIMMOMATIC_OPTARGS' --phred33'
#TRIMMOMATIC_OPTARGS=$TRIMMOMATIC_OPTARGS' --phred64'
TRIMMOMATIC_OPTARGS=' -threads 4 '

# Specify the analysis to run by uncommenting the lines beginning with «#TRIMMOMATIC_ANALYSIS=».
# The analyses are run in the specified order,
# see <http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf>
#
# Illuminaclip should be the first analysis in order to avoid problems in adapter detection.
#
# ILLUMINACLIP:fasta_with_adapters:seed_mismatches:palindrome_threshold:simple_threshold'
# ILLUMINACLIP:fasta_with_adapters:seed_mismatches:palindrome_threshold:simple_threshold:min_adapter_length:keep_both_reads'
#
TRIMMOMATIC_ANALYSIS=' ILLUMINACLIP:adapters.fa:2:30:10'

# Discard reads below the specified quality.
#
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' AVGQUAL:18'
TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' AVGQUAL:18'
# Crop
#
TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' CROP:134'

# Trimmomatic provides a default recommended filter.
#
# MAXINFO:read_lenght:strictness
#
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' MAXINFO:70:0.8'

# Trimm the sequence from begining/end if quality is less than specified quality
#
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' LEADING:3'
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' TRAILING:3'
TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' LEADING:28'

# Trimm a from the end if the average quality of the window
# is less than the specified quality.
#
# SLIDINGWINDOW:window_size:quality
#
TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' SLIDINGWINDOW:5:28'

# Crop the number of nucleotides specified from the begining of the read.
#
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' HEADCROP:'


# Transform to the specified quality encoding.
#
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' TOPHRED33'
#TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' TOPHRED64'

# Discard reads shorter than the specified length.
#
TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' MINLEN:70'
