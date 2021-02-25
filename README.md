# FilterAndTrim
# Language: R
# Input: TXT (keyword, value pairs)
# Output: prefix
# Tested with: PluMA 1.1, R 4.0.0
# dada2_1.18.0

PluMA plugin to take a set of sequences, filter for quality
and trim to a specified length.  

The plugin accepts as input a TXT file with (keyword, value) pairs.  Three keywords are accepted:

FASTQ: Directory with the input FASTQ sequence files.
truncForward: Length to truncate forward reads
truncReverse: Length to truncate reverse reads
trimForward:  Bases to remove from forward reads
trimReverse:   Bases to remove from reverse reads
maxN: Maximum amount of N's (fully uncertain) in a nucleotide sequence
maxEE: Maximum expected error in a sequence
truncQ: Quality score threshold for keeping read

Filtered and trimmed reads will be output as FASTQ files starting with the provided output prefix.
Plugin also outputs a CSV file (prefix.csv) of read counts before and after filtering/trimming
