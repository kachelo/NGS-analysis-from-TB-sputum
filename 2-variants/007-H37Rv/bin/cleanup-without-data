#!/bin/sh
find \
	-L data/ \
	-type f \
	-exec sh -c "echo {}; tail -n 1 {}" ';' \
	| grep -B1 -E '^@' \
	| grep -v -E '^@|^--' \
	| xargs echo rm
