## 001 Indel realigment

This step takes an input BAM, locally realign reads such that the number of mismatching bases is minimized across all the reads. 
This step is important because BWA-like algorithms penalice more indels than mismatches producing bias generating a lot of mismatches where INDELs are supossed to be.

There are 2 steps to the realignment process:

1) Determining (small) suspicious intervals which are likely in need of realignment (RealignerTargetCreator tool).
2) Running the realigner over those intervals (IndelRealigner) using smith waterman algorithm.

The indel realigment step, can take a reference of INDEL positions in the 1000G-Project in order to detect sites that are more propense to be realigned.

For more details see: [GATK-forum](https://software.broadinstitute.org/gatk/gatkdocs/3.7-0/org_broadinstitute_gatk_tools_walkers_indels_IndelRealigner.php)

## Execution Parameters

### GATK - parameters

```

For IndelRealigner 
-R -> path to Reference sequence file
-I -> Input file containing sequence data (BAM format)
-targetIntervals -> Intervals file output from RealignerTargetCreator
-known -> Input VCF file(s) with known indels

For RealignerTargetCreator
-R -> path to Reference sequence file
-I -> Input file containing sequence data (BAM format)
-nt -> Number of data threads to allocate to this analysis
-known -> Input VCF file(s) with known indels

```
