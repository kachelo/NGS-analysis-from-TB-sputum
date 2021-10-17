# Installations instructions for dependencies

## Requirements

- [mk](http://doc.cat-v.org/bell_labs/mk/mk.pdf "mk: A successor for `make`.")

- [FASTQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ "FASTQC: A quality control tool for high throughput sequence data.")

- [trimmomatic](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/ "Trimmomatic: a flexible trimmer for Illumina sequence data")


## APT PACKAGES

In most linux distros, you can use the `apt` strategy to get you system up and running: 

- Complete first try

```
sudo apt install 9base fastqc unzip trimmomatic g++ zlib1g
sudo apt install make csh htop python-dev gcc unzip g++ cpanminus ghostscript blast2 python-matplotlib git pigz parallel ncbi-blast+
```

## FASTQC

If need to use a upper version, than the one installed by system repository

```
cd softwares
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
unzip -q fastqc_v0.11.7.zip
cd FastQC/
chmod +x fastqc
```

**Note**: Remember to include the executable in the `config.mk` file

## SNAP

cd softwares
git clone https://github.com/amplab/snap.git
cd snap
make
**NOTE** It is recommended to use the last available release from github

## SAMBAMBA

wget https://github.com/biod/sambamba/releases/download/v0.8.1/sambamba-0.8.1-linux-amd64-static.gz
gunzip sambamba-0.8.1-linux-amd64-static
chmod +x sambamba-0.8.1-linux-amd64-static
ln -s sambamba-0.8.1-linux-amd64-static sambamba


## SURPI

```
git clone https://github.com/chiulab/surpi.git
```

Then we use the ```download_SURPI_data.sh``` scripts in the reference directory to download all the data, to be indexed
