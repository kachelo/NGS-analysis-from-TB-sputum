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


