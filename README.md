# A bioinformatics pipeline for Mycobacterium tuberculosis sequencing that cleans contaminant reads from sputum samples 

## Short Title:  
A pipeline to remove contaminant NGS reads from TB-sputum samples 

## Authors:
Betzaida Cuevas-Córdoba1,2‡, Cristóbal Fresno3a‡, Joshua I Haase-Hernández3, Martín Barbosa-Amezcua1, Minerva Mata-Rocha1, Marcela Muñoz-Torrico4, Miguel ÁngelA Salazar-Lezama4, José Arturo Martínez-Orozco4, Luis Armando Narváez-Díaz4, Jorge Salas-Hernández4, Vanessa González-Covarrubias1*, Xavier Soberón1b*. 

## Afiliations 
1 Laboratorio de Farmacogenómica, Instituto Nacional de Medicina Genómica (INMEGEN), Ciudad de México, México.  
2 Instituto de Investigaciones Biológicas, Universidad Veracruzana, Xalapa, Veracruz, México.  
3 Departamento de Desarrollo Tecnológico, Instituto Nacional de Medicina Genómica (INMEGEN), Ciudad de México, México.  
4 Clínica de Tuberculosis y Enfermedades Pleurales, Instituto Nacional de Enfermedades Respiratorias (INER), Ciudad de México, México. 
‡ These authors contributed equally to this work. 
a Current Address:  Centro de Investigación en Ciencias de la Salud (CICSA), Facultad de Ciencias de la Salud, Universidad Anáhuac México Campus Norte; Edo. de México, México.
b Current Address:  Instituto de Biotecnología, Universidad Nacional Autónoma de México Ciudad de México, México. 
* Corresponding authors: E-mail: soberon@ibt.unam.mx and vgonzalez@inmegen.gob.mx

# The git repository includes the recomended pipeline of the paper

The workflow uses [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`."), which can usually be installed using:

```
sudo apt install 9base
```

Remember to add 9base to the **PATH** variable in order to find ```mk``` executable.

# Project structure

<img src="plos_one_github1.png" alt="A pipeline to remove contaminant NGS reads from TB-sputum samples"/>

## data directory

Here the user includes de fasta file that wants to process using the following considerations:

```
SAMPLE_LIBRARY_TREATMENT_PLATFORM_CENTER_L00[0-8]_R[12].fastq.gz
```
- SAMPLE ID
- TREATMENT used 
- PLATFORM used, i. e. ILLUMINA, etc.
- CENTER, where it was taken
- L00[0-8] lane used #
- R[12] forward (1) or reverse (2)

Illumina reads follow the convention:

```
@<instrument>:<run>:<flowcell>:<lane>:<tile>:<x>:<y> <single(1)|paired(2)>:<is-filtered (Y|N)>:<control (0)>:<sample-number>
# Example:
@M04474:29:000000000-ALA81:1:1101:15601:1728 1:N:0:4
```

## reference directory

Here we will include *Mycobacterium* reference genome and SURPI database.

**Data bases for taxonomic annotation**

- [ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz](ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)
- [ftp://ftp.ncbi.nih.gov/pub/taxonomy/gi_taxid_prot.dmp.gz](ftp://ftp.ncbi.nih.gov/pub/taxonomy/gi_taxid_prot.dmp.gz)

**Non-repetitive nucleotidos**

* [ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nt.gz](ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nt.gz)

**Non-repetitive amino acids**

- [ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz](ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz)

**Curated references by CHIULAB for SURPI**

http://chiulab.ucsf.edu/SURPI/databases/hg19_rRNA_mito_Hsapiens_rna.fa.gz
http://chiulab.ucsf.edu/SURPI/databases/Bacterial_Refseq_05172012.CLEAN.LenFiltered.uniq.fa.gz
http://chiulab.ucsf.edu/SURPI/databases/rapsearch_viral_aa_130628_db_v2.12.fasta.gz
http://chiulab.ucsf.edu/SURPI/databases/viruses-5-2012_trimmedgi-MOD_addedgi.fa.gz
http://chiulab.ucsf.edu/SURPI/databases/18s_rRNA_gene_not_partial.fa.gz
http://chiulab.ucsf.edu/SURPI/databases/23s.fa.gz
http://chiulab.ucsf.edu/SURPI/databases/28s_rRNA_gene_NOT_partial_18s_spacer_5.8s.fa.gz
http://chiulab.ucsf.edu/SURPI/databases/rdp_typed_iso_goodq_9210seqs.fa.gz.

**Mycobacterium used reference**

Mycobacterium tuberculosis     ref seq   NC_000962.3

**Note 1**: Review SURPI workflow
- https://github.com/chiulab/surpi
- http://chiulab.ucsf.edu/surpi/
- http://genome.cshlp.org/content/early/2014/05/16/gr.171934.113.full.pdf+html
- http://snap.cs.berkeley.edu/downloads/snap-1.0beta-manual.pdf

**Note 2**: Keep in mind where databases index are
- SURPI: references/chiulab.ucsf.edu/SURPI/databases

- Mycobacterium: reference/Mycobacterium




# 1) Filtering input sequences with high-quality base calls

## 001-fastqc: Quality Control reports of the sequences

- Initial reads Quality Control 

## 002-trimmomatic: Clean sequence artifacts using the QC reports

- Include/modify the **adapters.fa** file from previous QC report

Usefull configurations:

- Remove adapters
  `TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' ILLUMINACLIP:adapters.fa:2:30:10'`

- Remove reads with mean score quality < 18
  `TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' AVGQUAL:18'`

- Crop the reads from position 134
  `TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' CROP:134’`

- Remove initial bases if they have qc < 28
  `TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' LEADING:28'`

- 5 bases moving window with at least 28 score in qc
  `TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' SLIDINGWINDOW:5:28'`

- Minimun Lenght of 70 bases per read
  `TRIMMOMATIC_ANALYSIS=$TRIMMOMATIC_ANALYSIS' MINLEN:70'`

## 003-fastqc: Reads QC after using trimmomatic

- Posterior reads Quality Control






# 2) Microorganism identification and filtering by alignment with SURPI

- Idea: use SURPI (Sequence-based Ultra-Rapid Pathogen Identification) to filter out reads that are not related to Mycobacterium from clinical samples: Remove Human, then Virus, after that identify the undesired bacteria.  Performe the Mapping with Mycobacterium genome H37RV using a stringent Edit Distance (ED = 3) and veriffy the elimination of contaminant sequences.

## 004-human: Remove Human reads from the clinical sample

**Note**: To filter out human reads SURPI uses [hg19 mitocondrial](hg19_rRNA_mito_Hsapiens_rna.snap). In this work we used as reference th complete GRCh38 genome.


## 005-virus: Remove Virus reads from clinical sample

**Note**: To filter out virus reads we aligned all high-quality reads of FASTA files with the SURPI virus database, obtaining BAM filtered files . 


## 006-Bacteria: Taxonomic classification of the sequenced microbiota

**Note**: The BAM files were aligned with the SURPI bacterial reference database to obtain the taxonomic classification of the sequenced microbiota . 


## 007-*H37Rv* : Mapping with the reference genome 

**Note**: The BAM files were mapping with the whole genome of *Mycobacterium tuberculosis* *H37Rv* (NC_000962.3) using a genomic edit distance = 3. 

a) The directory where the reference is used

```
SNAP_REFERENCEDIR='/labs/lf/tb/reference/Mycobacterium_tuberculosis_H37Rv.snap'
```

b) To filter unmatched regions:

```
SNAP_OPTS=$SNAP_OPTS' -F a '
```

c) Choose genomic edit distance value

config.mk 
`- SNAP_OPTS=$SNAP_OPTS' -d 3'`

d) Lots of memory:

```
SNAP_OPTS=$SNAP_OPTS' -map'
```

 e) condor.header  
  `-initialdir = /labs/lf/tb/2-variantes/006b-Direct-H37Rv-D3`

Note: The reads obtained under these mapping conditions were re-aligned with the bacterial reference SURPI database (006-Bacteria) to quantify the number of sequences classified as *Mycobacterium*, other non-*Mycobacterium* bacteria, and unassigned bacteria





# 3) Filtering with GATK for variant calling

## 008- File format for GATK and bias control

### a) Sort

This module uses SAMBAMBA to sort (sort) the bam files that come from the previous module.

### b) BAM to SAM files converter

This module converts bam files to sam to do the merge. 

### c) Merge

This module uses samtools to merge sam files with the same name or folio. That is, it groups all the lines of each sample and converts those sam files to bam to continue the process.

### d) BAI files

This module generates the index and the .bai files from the previous module

### e) Markdup

This module performs a duplicate markup with picard-tools (markdup) and generates the index.

### f) Qualimap

This module assesses the quality of files and generates data reports (multi-bamqc report) about depth and coverage. Their results identify possible sequencing biases (read groups).

### g) Mapping quality filter

This module filters the quality of the alignment of the reads eliminating those with mapping quality less than or equal to 20. 

### h) BAI files

This module generates the index and the .bai files from the previous module

### i) Check-point

Generate final files to make a check point in case it is necessary to delete the previous files.



## 009- Variant analysis

This module can be cloned from the immegen git with the following command

`bcuevas@castillo::/labs/lf/tb/2-variantes/$ git clone https://gitlab.inmegen.gob.mx/100GMX/mk-gatk.git 012-mk-gatk`

A directory called "reference" is required with the following files:

- fasta file: Mycobacterium_tuberculosis_H37Rv.fasta
- .fasta.fai index file `samtools faidx Mycobacterium_tuberculosis_H37Rv.fasta`
- .dict dictionary file `picard-tools CreateSequenceDictionary R=Mycobacterium_tuberculosis_H37Rv.fasta O=Mycobacterium_tuberculosis_H37Rv.dict`
- 

A directory called known-variants was created to contain the following files

- known_final.vcf

- Bed-IGV+100_NC_000962.3.bed

  This file is a  known variants  database of *Mycobacterium* generated ad hoc for this proyect from the following databases

  1.  TBDREAM (https://tbdreamdb.ki.se/CMS/Download.aspx) 
  2.  RefSeq  (https://platform.reseqtb.org)
  3.  phyRes (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4432036/pdf/zjm1908.pdf)

  The config.mk file must contain the reference genome path and the known variant database.

`Reference Genome fasta file
REF="/labs/lf/tb/reference/Mycobacterium_tuberculosis_H37Rv.fna"
dbSNP="../../known-variants/known_final.vcf"
coordenadas="../../known-variants/Bed-IGV+100_NC_000962.3.bed"`

### a) INDELs realignment

BWA-type algorithms penalize more indels than mismatches, producing a bias that generates a large number of mismatches where INDELs are supposed to be. This step takes an input BAM, adjusts or realigns the reads locally in a way that minimizes the number of mismatches on all reads.

### b) Base Quality Score Recalibration (BQSR)

The BQSR applies machine learning to model errors produced by sequencing machines. This technical error results in over- or underestimated baseline quality scores. Some of these errors are due to the physics or chemistry of how the sequencing reaction works and some are likely due to manufacturing failures in the equipment.

### c) Individual Calling

This step applies the GATK HaplotypeCaller algorithm to estimate SNPs and short INDEL probabilities for each nucleotide in the genome.

### d) Population calling 

This step takes many gVCF files produced in the previous step, to perform genotyping of multiple samples. At this point, variants are detected in samples that could have low sequencing depth, taking into account the information in other input samples. This tool will combine all expansion records (samples), produce the correct genotype probabilities, and re-genotize the newly joined record.

### e) Hard-filtering

This module applies hard filters to a callset variant that is too small for Variant Quality Score Recalibration (VQSR) or for which truth / training groups are not available. Variants are filtered using the parameters recommended by Broad Institute best practices.

**Note**: the VQRS is not used because the known base of variants is not sufficient to train the model.

If any condition is met, they do not pass the filter and are labeled as hard filtered, those that pass (false values of the parameters) are labeled as pass

Those whose values in each condition are false pass the filter

SNPS:   --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 30.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \

INDEL: --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" \

<u>QualByDepth (QD):</u> <2.0.: This is the variant confidence (from the QUAL field) divided by the unfiltered depth of non-reference samples.
<u>FisherStrand (FS):</u> >60.0. Phred-scaled p-value using Fisher’s Exact Test to detect strand bias (the variation being seen on only the forward or only the reverse strand) in the reads. **More bias is indicative of false positive calls**.

**Note**: Do not use this condition for amplicon technique

<u>RMSMappingQuality (MQ)</u>: <40.0. This is the Root Mean Square of the mapping quality of the reads across all samples.

**Note**: The original suggested MQ value in GATK for human is <40.0; however, it was decided to modify it to 30 with the intention of recovering positions of interest associated with phenotypic resistance given the diversity of phenotypes included in the population.

<u>#HaplotypeScore:</u> 13.0. This is the consistency of the site with two (and only two) segregating haplotypes. Note that this is **not applicable for** calls made using the UnifiedGenotyper on **non-diploid organisms.**
<u>MappingQualityRankSumTest (MQRankSum):</u> < 12.5. This is the u-based z-approximation from the Mann-Whitney Rank Sum Test for mapping qualities (reads with ref bases versus those with the alternate allele).
Note that the mapping quality rank sum test cannot be calculated for sites without a mixture of reads showing both the reference and alternate alleles, i.e., this will only be applied to heterozygous calls.
<u>ReadPosRankSumTest (ReadPosRankSum):</u> < 8.0. This is the u-based z-approximation from the Mann-Whitney Rank Sum Test for the distance from the end of the read for reads with the alternate allele. If the
alternate allele is only seen near the ends of reads; this is indicative of error. Note that the read position rank sum test cannot be calculated for sites without a mixture of reads showing both the reference and alternate alleles, i.e., this will only be applied to heterozygous calls.

### f) Missing subjects

- **CHR-name**: This module modifies the long chromosome name that was obtained from previous steps to leave only NC_000962.3 in the .vcf files
- **NO PASS**: This module selects only the samples that did not pass the filter (NO PASS)
- **PASS**: This module selects only the samples that passed the filter (PASS)
- **missing-subject**: In this module, a table is generated with variants in the columns and subjects in the rows to identify those samples or subjects that have a large number of unnamed variants (./.) And, if necessary, eliminate them. If this happens, you should return to module 09- Variant analysis (from the population analysis onwards).



### Post-filter

A post-filter  was applied to the variants that passed the hard-filtering generate a more accurate and reliable result. This step considering:

- only variants with SNPs or INDELs, ie, those with 
  - alternate homozygous genotype 1/1 for complete resistance and 
  - heterozygous 0/1 or 1/0 for heterorresistance, in the case of subpopulations 
- only reads with 
  - a variant depth (DP) ≥10 and 
  - genotype quality (GQ) ≥30. 
- The rrs gene has conserved regions showing similarity between microorganisms, and therefore we decided to quantify the percentage of this gene's variants to measure the potential contamination by other bacteria 





