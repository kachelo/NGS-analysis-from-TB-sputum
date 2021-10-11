# Installations instructions for dependencies

## APT PACKAGES

In most linux distros, you can use the `apt` strategy to get you system up and running: 

- Complete first try

```
sudo apt install 9base fastqc unzip
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

