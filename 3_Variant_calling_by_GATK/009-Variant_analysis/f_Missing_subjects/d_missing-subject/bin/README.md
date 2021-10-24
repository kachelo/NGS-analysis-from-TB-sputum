Missing variants
===============

Check wether the missing variants are in row (variants), columns (individuals) or both
in order to clean up the mess.

# Usage

The input VCF files are located in the `data` directory. Then using 

```
$ bin/targets | xargs mk
```

your i.tab files will be on `results/` when the process ends.

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`findutils`](https://www.gnu.org/software/findutils/ "Basic directory searching utilities of the GNU operating system.")

- [`bcftools`](http://www.htslib.org/download/ "utilities for variant calling and manipulating VCFs and BCFs")

