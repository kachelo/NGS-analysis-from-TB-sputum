Annotate taxonomy information onto SAMs aligned to SURPI reference.
The output are SAM files ready for generating SURPI report.
The files may not be useful for other kinds of analysis as they may be invalid sam.

# Usage

Use ENV variable to assign the reference directory:

```
bin/targets \
| env TAXONOMY_DB_DIR=/path/to/taxonomy/reference xargs mk
```

By default, it will be assigned to `reference`,
so you can link your reference directory to it and only run:

```
bin/targets | xargs mk
```

# Dependencies

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")
- [perl5](https://www.perl.org/ "A language with over 29 years of development.")
- [findutils](https://www.gnu.org/software/findutils/ "Basic directory searching utilities.")
- [coreutils](https://www.gnu.org/software/coreutils/ "The basic file, shell and text manipulation utilities of the GNU operating system.")
