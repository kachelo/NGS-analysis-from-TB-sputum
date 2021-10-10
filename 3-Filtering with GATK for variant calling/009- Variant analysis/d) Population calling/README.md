## 004 Joint genotyping
This module takes many gVCFs produced in step 3 are used to perform multi-sample genotyping, this step important to detect variants in samples that could have low sequencing-depth, by taking into account the information in other input samples.

This tool will combine all spanning records (samples), produce correct genotype likelihoods and re-genotype the newly merged record.

## WARNING: In this step many temporary files are requiered. In order to obtain a successful run, consider the following:
1. Change the JAVA tmp directory: export _JAVA_OPTIONS=-Djava.io.tmpdir=/100g/analysis/007a/004/tmp
2. Extend the limit of open files: ulimit -n 32768

### GATK - parameters

```

For GenotypeGVCFs
-R -> path to Reference sequence file
--variant  -> path to one or more input gVCF files
--disable_auto_index_creation_and_locking_when_reading_rods -> Disable both auto-generation of index files and index file locking
-nt -> Number of data threads to allocate to this analysis

```
