# Filtrate sequence with low MAPQ-Phred-score in the alignment

Posterior variant calling analyses do not use reads with low alignment score (MAPQ < 25). Hence, we are going to remove it.

1. Check qualimap MAPQ histogram to decide a threshold value (see appropiate module).
2. Update the `MAPQ` threshold field in the `config.mk` file
2. Remove the unwanted reads running:

```
bin/targets | xargs mk 
```

#Requirements
[`samtools`](http://samtools.sourceforge.net/)

