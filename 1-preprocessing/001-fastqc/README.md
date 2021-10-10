Run fastqc on compressed fastq files on `data/` directory.

To use this [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.") module:

```
bin/targets | xargs mk
```

The reports will be output to `results/` folder.

# Requirements

- fastqc
- coreutils
- find
- 9base
