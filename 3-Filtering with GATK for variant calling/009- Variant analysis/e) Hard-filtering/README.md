## 005b -> Hard Filtering
This module applies hard filters to a variant callset that is too small for VQSR or for which truth/training sets are not available. variants are filtered using parameters recommended by the Broad Institute best practices.

## Execution Parameters

### GATK - parameters

```
For SelectVariants 
-R -> Path to Reference sequence file
-V -> Path to Input VCF file
-selectType -> Select only a certain type of variants from the input file (SNP or INDEL)
-nt -> Number of data threads to allocate to this analysis

For VariantFiltration
-R -> Path to Reference sequence file
-V -> Path to Input VCF file
--filterExpression -> String of conditions to apply filter
--filterName ->	Name of the filter for the Filter column in the output vcf file

For CombineVariants
-R -> Path to Reference sequence file
-V -> Path to Input VCF file
-nt -> Number of data threads to allocate to this analysis
--genotypemergeoption -> Determines how we should merge genotype records for samples shared across the ROD files

```