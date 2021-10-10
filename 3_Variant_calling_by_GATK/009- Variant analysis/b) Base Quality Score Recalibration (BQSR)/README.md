## 002 BQSR (Base quality score recalibration)

The BQSR apply machine learning to model errors produced by the machine-sequencers.
Its important because  technical error, leading to over- or under-estimated base quality scores in the data. 
Some of these errors are due to the physics or the chemistry of how the sequencing reaction 
works and some are probably due to manufacturing flaws in the equipment.

The base recalibration process involves two key steps: 
1) The program builds a model of covariation based on the data and a set 
of known variants (BaseRecalibrator).
2) Adjusts the base quality scores in the data based on the model (PrintReads).

The indel realigment step need a reference for variants:
The known variants are used to mask out bases at sites of real (expected) variation, to avoid counting real variants as errors. 
Outside of the masked sites, every mismatch is counted as an error. 

For more details see: http://gatkforums.broadinstitute.org/gatk/discussion/44/base-quality-score-recalibration-bqsr

## Execution Parameters

### GATK - parameters

```
For BaseRecalibrator
-R -> path to Reference sequence file
-I -> Input file containing sequence data (BAM format)
-knownSites -> A database of known polymorphic sites
-nct -> Number of CPU threads to allocate per data thread (from the NanoSchedulable option)

For PrintReads
-R -> path to Reference sequence file
-I -> path to Input file containing sequence data (BAM format)
-BQSR -> path to Input covariates table file for on-the-fly base quality score recalibration
-nct -> Number of CPU threads to allocate per data thread (from the NanoSchedulable option)

For AnalyzeCovariates \
-l -> logging level for verbosity
-R -> path to Reference sequence file
-before -> path file containing the BQSR first-pass report file
-after -> path file containing the BQSR second-pass report file
-csv -> path to the csv intermediate file of the report
-plots -> path to the output report

```