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

![A pipeline to remove contaminant NGS reads from TB-sputum samples](plos_one_github1.pdf)

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


# 1-PREPROCESSING

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

# 2-VARIANTS

- Idea: use SURPI (Sequence-based Ultra-Rapid Pathogen Identification) to filter out reads that are not related to *Mycobacterium* from clinical samples: Remove Human, then Virus, after that organisms that are not the one desired. Finally, use *Mycobacterium* genome, H37RV, with a stringent Edit Distance (ED=3) in the alignment.

## 004-surpi-human: Remove Human reads from the clinical sample

**Note**: To filter out human reads SURPI uses [hg19 mitocondrial](hg19_rRNA_mito_Hsapiens_rna.snap). In this work we used as reference th complete hg38 genome.

## 005-virus: REmove Virus reads from clinical sample


