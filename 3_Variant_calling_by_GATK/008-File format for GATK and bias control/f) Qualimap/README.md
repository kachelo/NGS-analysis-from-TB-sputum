Run qualimap on bam files on `data/` directory.

To use this [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.") module:

```
bin/targets | xargs mk
```

The reports will be output to `results/` folder.

# Requirements

- qualimap
- coreutils
- 9base
- find

#Qualimap multii-bamqc

##Generate the apropiate input structure

**Goal**
Qualimap requires to generate individual reports, then, creates the multi-bamqc report.
Unfortunatelly, it creates the individual reports in the same directory as the BAM input file. 
So, symbolic links are created inside the result directory to bypass this problem.

**Create symbolic links**
Assumptions: 
- The bams files are some where in `[.../previous_module/results/<experiment>]`
- The links will be created in `[result/<experiment>/]`

```
bin/create-links <path to bam-bai direcotry relative from module path>
```

**Module input**
It requires a metadata file that can be generated using:

```
bin/targets-sample-table results/[experiment path] > [experiment]_design.tab
```

Which generates the experimental design tab-separated 2- or 3-column file.
	Column 1: sample name.
	Column 2: either path to the BAM QC result directory (_qc) or path to BAM file (_design). The last will require the -r mode.
	Column 3: group name (activates sample group marking).

Note that the individual bam report will be created in the same directory where the bam file is located.
Then the multi-bamqc report that uses the path to the bam files can be created calling

```
mk results/[experiment]/multi-bamqc/complete_report.pdf
```

If usign [experiment_qc.tab] file, then call:

```
mk results/[experiment]/multi-bamqc/report.pdf
```

