Alignment using SNAP
====================

Align sequencing reads to reference using SNAP.

# Usage

Add sam files to `data/` directory and name them like
`SAMPLE_LIBRARY_TREATMENT_PLATFORM_CENTER_L00[0-8]_R[12].fastq.gz`

```
$ bin/targets | xargs mk
```

Your bam files will be on `results/` when the process ends.

# Options

You customize the analysis using environment vars or config.mk

- `SNAP_REFERENCEDIR`: the reference to align to.

---

- `SNAP_OPTS`: the options for SNAP *must* be edited in config.mk
    as the method for using an environment variable is not yet implemented.

# Design considerations

The naming convention was decided to provide an automatic method for
providing appropiated read groups for further analyses.

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`findutils`](https://www.gnu.org/software/findutils/ "Basic directory searching utilities of the GNU operating system.")

- [`coreutils`]( "basic file, shell and text manipulation utilities of the GNU operating system.")

- [snap-aligner](http://snap.cs.berkeley.edu/ "Scalable Nucleotide Alignment Program.")

# References

- [FASTQ_format](https://en.wikipedia.org/wiki/FASTQ_format )
- [Read Groups (GATK Forum)](https://gatkforums.broadinstitute.org/gatk/discussion/6472/read-groups )
- [Read Groups (Picard)](http://broadinstitute.github.io/picard/command-line-overview.html#AddOrReplaceReadGroups )
- [SNAP manual](https://github.com/amplab/snap/blob/master/docs/Manual.pdf )
