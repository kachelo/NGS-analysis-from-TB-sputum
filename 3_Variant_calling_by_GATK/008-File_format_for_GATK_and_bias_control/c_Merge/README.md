BAM Merge by Sample and Library
===============================

This module merges the content of a directory


Usage
=====

Run the merge objective by calling:

```
$ bin/targets | xargs mk
```

Your merged .bam files will be on `results/` when the process ends.

The files on the input directory should be named according to a
standard naming convention described below.


USB Naming Convention
=====================

In order to maximize the power of the analysis,
READ GROUPS must be set carefully.

Some information that should be included in the READ GROUPS,
can be taken from the fastq files automatically,
but some information pertaining to the experimental design cannot.

The naming convention is:

```
SAMPLE_LIBRARY_TREATMENT_PLATFORM_CENTER_L00[0-8]_[un]paired.bam
```

These field cannot contain `_` , `()` or ` ` (underscore parentheses or spaces).

Valid platform names are: ILLUMINA SOLID LS454 HELICOS PACBIO


Options
=======

`NPROC` environment variable can be specified to run multiple processes simultaneously.


Design considerations
=====================

On downstream analyses, it is convenient to have one sample per file.

There may be samples processed by different panels and they should be treated by their own.


Requirements
============

- [`coreutils`](https://www.gnu.org/software/coreutils/coreutils.html "Basic file, shell and text manipulation utilities of the GNU operating system.")

- [`findutils`](https://www.gnu.org/software/findutils/ "Basic directory searching utilities of the GNU operating system.")

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`samtools`](https://www.htslib.org "Samtools. Reading/writing/editing/indexing/viewing SAM/BAM/CRAM format")
