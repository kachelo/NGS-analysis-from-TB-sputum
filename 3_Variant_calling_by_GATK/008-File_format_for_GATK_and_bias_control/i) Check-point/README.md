#Final pre-process data

This module makes a clean copy of the `data` directory .bam and .bai files into `results`. This step is necesary,
as many modules carry symbolic link after symbolic link and create a check point.

# Requirements

None declared

# Run

```
bin/targets | xargs mk
```
