Filter VQRS PASS variants
===============

Keep the PASS variants under the filter column of the VCF file

# Usage

Input VCF files should be in `data` directory

```
$ bin/targets | xargs mk
```

Your processed vcf files will be on `results/` when the process ends.

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`findutils`](https://www.gnu.org/software/findutils/ "Basic directory searching utilities of the GNU operating system.")

- [`coreutils`]( "basic file, shell and text manipulation utilities of the GNU operating system.")

