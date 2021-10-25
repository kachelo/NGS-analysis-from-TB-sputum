004-tsv
==============

Extract VCF data into tsv format:
- Use VCF's fixed part only
- Split INFO field by `;` and `|` field separator.

# Usage

```
$ bin/targets | xargs mk
```

Your @@VCF@@ files will be on `results/` when the process ends.

# Design considerations

The VCF file must be annotated with ANN field and normalized (biallelic variants only).

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`findutils`](https://www.gnu.org/software/findutils/ "Basic directory searching utilities of the GNU operating system.")

- [`coreutils`]( "basic file, shell and text manipulation utilities of the GNU operating system.")


