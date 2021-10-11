# Installations instructions for dependencies

## Requirements

- [mk](http://doc.cat-v.org/bell_labs/mk/mk.pdf "mk: A successor for `make`.")

- [FASTQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ "FASTQC: A quality control tool for high throughput sequence data.")

- [trimmomatic](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/ "Trimmomatic: a flexible trimmer for Illumina sequence data")


## APT PACKAGES

In most linux distros, you can use the `apt` strategy to get you system up and running: 

- Complete first try

```
sudo apt install 9base fastqc unzip trimmomatic
```

## FASTQC

If need to use a upper version, than the one installed by system repository

```
cd software
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
unzip -q fastqc_v0.11.7.zip
cd FastQC/
chmod +x fastqc
```

**Note**: Remember to include the executable in the `config.mk` file
