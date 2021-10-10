Use trimmomatic to clean reads from high troughput sequencing.

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [trimmomatic](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/ "Trimmomatic: a flexible trimmer for Illumina sequence data")

# How to use

There should be a data directory including at least one fastq or fastq.gz file
and an `adapters` directory containing the adapters used,
for example:

```
$ find data -name '*.fastq*'
data/150819_10Beta-28341426/10BetaS6_ALL_R2.fastq
data/150819_10Beta-28341426/10BetaS6_ALL_R1.fastq.gz
$ find adapters -name '*.fastq'

```

You can optionally set an alternate directory for your adapters (by default `adapters/`):
and extra parameters for the execution of trimmomatic (none by default)
by modifying `config.mk`.

Then run one of the following commands:

```
$ bin/targets-paired | xargs mk
$ bin/targets-single | xargs mk
```

There! mk should do everything needed to take out your adapters.

Your adapter-cropped files will be on `results/` when the process ends.
