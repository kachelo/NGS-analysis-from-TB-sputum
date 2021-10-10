#################################################
## Unit Test for 002 stage of mk-gatk pipeline ##

Perform unitary test in every .ir.rtc.bam file at ../results/

It uses the picard-tools ValidateSamFile tool, as described in:

http://broadinstitute.github.io/picard/command-line-overview.html#ValidateSamFile

Run:

````
mk TEST
````

Results will be logged in Log/ directory.
