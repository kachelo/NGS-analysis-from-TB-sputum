## 003 -> Individual variant calling
This step applies the HaplotypeCaller algorithm of GATK, for stimation of SNPs and short INDELs likelihoods for every nucleotide in the genome.

## Execution Parameters

### GATK - parameters

```
For HaplotypeCaller
-R -> path to Reference sequence file
-I -> Input file containing sequence data (BAM format)
--minPruning -> Minimum support value to not prune paths in the graph
--emitRefConfidence -> Mode for emitting reference confidence scores. (!!USE GVCF for this module)
--variant_index_type -> Type of IndexCreator to use for VCF/BCF indices.
##Deprecated --variant_index_parameter Parameter to pass to the VCF/BCF IndexCreator. Using the output file ".g.vcf" extension will automatically set the appropriate value
-nct -> Number of CPU threads to allocate per data thread (from the NanoSchedulable option)

```
