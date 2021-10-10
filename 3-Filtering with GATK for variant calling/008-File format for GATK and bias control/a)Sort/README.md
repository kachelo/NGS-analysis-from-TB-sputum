Sort BAM files using Picard
===========================

Sort raw alignment bams by the reference coordinates using Picard.

# Usage

Place your bam files into the `data/` directory
and execute:

```
$ bin/targets | xargs mk
```

Your sorted bam files will be on `results/` when the process ends.

# Options

`NPROC` environment variable can be specified to run multiple processes simultaneously.

`SORT_OPTS` environment variable can be set to alter the execution parameters.

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`findutils`](https://www.gnu.org/software/findutils/ "Basic directory searching utilities of the GNU operating system.")

- [`coreutils`]( "basic file, shell and text manipulation utilities of the GNU operating system.")

- [`Picard`](https://broadinstitute.github.io/picard/ "Command line tools for manipulating HTS data and formats such as SAM/BAM/CRAM and VCF.")
