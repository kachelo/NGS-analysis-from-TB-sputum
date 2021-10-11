# DATA directory for original fasta files
## File nomenclature

Here the user includes de fasta file that wants to process using the following considerations:

```
SAMPLE_LIBRARY_TREATMENT_PLATFORM_CENTER_L00[0-8]_R[12]_00[0-9].fastq.gz
```

SAMPLE ID: (Number), i. e., 1, 2, ..., N
LIBRARY Date: YYYYMMDD
TREATMENT: default, control, treatmentA, etc.
PLATFORM used, i. e. ILLUMINA, etc.
CENTER, where it was taken: USEC.INMEGEN for example
L00[0-8]: lane used L###
R[12]: forward (1) or reverse (2)
00[0-9]: fasta file number, just if in a run multiple files were created.

Example file:

`13_20150728_default_ILLUMINA_USEC.INMEGEN_L001_R1_001.fastq.gz`



