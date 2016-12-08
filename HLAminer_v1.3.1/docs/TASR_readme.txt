Targeted Assembly of Sequence Reads (TASR)

TASR v1.6 Rene Warren, 2010-2016
email: rwarren [at] bcgsc [dot] ca


What's new in version 1.6.1?
----------------------------

1) Bloom filter functionality to exclude k-mers from your sequence target space (TASR-Bloom)
TASR and TASR-Bloom:
2) 4-base encoding of the first 16 bases of each read while populating a 4-nodes (16/4) prefix tree.
3) The new (and required) coverage depth threshold -w option, gives users more control over the assembly, focusing on higher-depth contigs and ignoring short, low-depth contigs comprised of NGS reads having errors, contaminating reads or any other (perhaps unwanted) sequences.
4) Improvements to read recruitement from sorted-by-name bams, recruiting whole read pairs when at least one read has a target seed k-mer match. This has the potential to extend the reconstructed contigs by 2X the library fragment size (upstream and downstream) of the target sequence.
5) Support for compressed reads file (zip/gz)

What's new in version 1.5.1?
----------------------------

fixed TASR for Perl >= 5.16.0, where deprecated getopts.pl has been removed. Thanks to Nicola Soranzo for sending the fix.


What's new in version 1.5?
--------------------------

TASR v1.5 no longer constrains the use of 15-character words derived from a target sequence for interrogating candidate reads.  User-defined target word length values are now passed to the algorithm using the -k option.  Using larger -k values should help speed up the search when using long sequence reads, since it will restrict the sequence space accordingly.  Note: whereas specificity, speed and RAM usage may increase with k, it may yield more sparse/fragmented assemblies.  Proper experimentation with various -k values are warranted.


What's new in version 1.4?
--------------------------

Ability to interrogate reads in bam files

The -a option is used to specify the location of samtools in your system. If .bam/.BAM are specified in the file-of-filename (FOF) supplied with the -f option, the executable specified under -a will interrogate any reads in .bam files that passed QC. 


What's new in version 1.3?
--------------------------

Support for sequence target-independent de novo assemblies

The -i option instructs TASR to use target sequences for the sole purpose of recruiting sequence reads.  If set (-i 1) the target sequences will not seed de novo assemblies and this task will be achieved by recruited reads in a target-independent fashion instead. This has the advantage of allowing the user to provide, as a target, a large reference sequence (-s) without a priori knowledge of variant bases or other structural variants.

e.g. 

ORF REFERENCE:
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

15-mers on plus strand:
XXX XXX XXX XXX XXX XXX XXX XXX
 XXX XXX XXX XXX XXX XXX XXX 
  XXX XXX XXX XXX XXX XXX XXX
   XXX XXX XXX XXX XXX XXX XXX

15-mers on minus strand:
xxx xxx xxx xxx xxx xxx xxx xxx
 xxx xxx xxx xxx xxx xxx xxx 
  xxx xxx xxx xxx xxx xxx xxx 
   xxx xxx xxx xxx xxx xxx xxx

Reads recruited, with (_) highlighting the position of the 15-mer on the read:
___
XXXOXXX
    ___
xxxoxxx
       ___
   oxxxxxx
      ___
  xoxxxxx

Contig created:
XXXOXXXXXX

Where "O" represents a variant base 


What's new in version 1.2?
--------------------------

The -f option input reads via a file of filenames (fof).  The latter lists any fasta/fastq sequence files you wish to input.
One file per line must be specified, full path to your file(s) is recommended.


Description
-----------

Targeted Assembly of Sequence Reads (TASR) using the SSAKE assembly engine.
TASR is a genomics application that allows hypothesis-based interrogation of genomic regions (sequence targets) of interest.
*It only considers reads for assembly that have overlap potential to input target sequences. 


Implementation and requirements
-------------------------------

TASR is implemented in PERL and runs on any platform where PERL is installed 


Install
-------

Download the .tar.gz, gunzip and extract the files on your system using:

gunzip tasr_v1-6.tar.gz
tar -xvf tasr_v1-6.tar

The Bloom::Faster PERL library was built against various version of PERL

./lib/Bloom-Faster-1.7/
bloom5-10-0
bloom5-16-0
bloom5-16-3
bloom5-18-1

To re-build against YOUR PERL version, follow these easy steps:

1. cd ./lib/Bloom-Faster-1.7
2. /gsc/software/linux-x86_64/perl-5.10.0/bin/perl Makefile.PL
PREFIX=./bloom5-10-0
(perl at YOUR favourite location)
3. make
4. make install
5. change line 236 in TASR-Bloom to reflect the location of the Bloom library
5. test: /gsc/software/linux-x86_64/perl-5.10.0/bin/perl ../../TASR-Bloom

Change the shebang line of TASR to point to the version of PERL installed on your system and you're good to go.

 
Documentation
-------------

Refer to the TASR.readme file on how to run SSAKE and the SSAKE web site for information about the software and its performance 
www.bcgsc.ca/bioinfo/software/tasr

Questions or comments?  We would love to hear from you!


Citing TASR
-----------

Thank you for using, developing and promoting this free software.
If you use TASR or SSAKE for you research, please cite:

Warren RL, Holt RA, 2011 Targeted Assembly of Short Sequence Reads. PLoS ONE 6(5): e19816. doi:10.1371/journal.pone.0019816 
Warren RL, Sutton GG, Jones SJM, Holt RA.  2007.  Assembling millions of short DNA sequences using SSAKE.  Bioinformatics. 23(4):500-501


Running TASR
------------

e.g. ../TASR -s targets.fa -f foobar.fof -m 15 -c 1

Usage: ./TASR [v1.6]
-f  File of filenames (FOF) corresponding to .fasta, .fastq or .bam files with NGS reads to interrogate
 -a Full path to samtools (required only if .bam files listed in FOF)
-s  Fasta file containing sequences to use as targets exclusively
-w  Minimum depth of coverage allowed for contigs (e.g. -w 1 = process all reads [original behavior], required)
-m  Minimum number of overlapping bases with the target/contig during overhang consensus build up (default -m 20)
-o  Minimum number of reads needed to call a base during an extension (default -o 2)
-r  Minimum base ratio used to accept a overhang consensus base (default -r 0.7)
-k  Target sequence word size to hash (default -k 15)

-l  Bloom filter* containing kmers to exclude (built -k, optional)
*This option only in TASR-Bloom

-u  Re-use NGS reads (-u 1 = yes, default = no, optional)
-i  Independent (de novo) assembly  i.e Targets used to recruit reads for de novo assembly, not guide/seed reference-based assemblies (-i 1 = yes, default = no, optional)
  Note: if -i is set to 1, -u will be forced-set to 0 (not re-using reads)
-c  Quality-clip candidate reads (-c 1 = yes, default = no, optional)
 -q Phred quality score threshold (bases with -q XX and less will be clipped, default -q 10, optional)
 -n Number of consecutive -q 10 bases (default -n 30, optional)
-e  ASCII offset (33=standard 64=illumina, default -n 33, optional)
-b  Base name for your output files (optional)
-v  Runs in verbose mode (-v 1 = yes, default = no, optional)


Test data
---------

Execute "runme.sh"
-or-
Run:

A. Go to ./test
B. Get ~4M RNA seq reads from a prostate adenocarcinoma sample:
wget ftp://ftp.bcgsc.ca/supplementary/SSAKE/SRR066437.fastq.bz2
C. Decompress reads file:
>bunzip2 SRR066437.fastq.bz2
D. Notice the file of filename (fof) foobar.fof, which lists SRR066437.fastq
E. Run TASR, quality-clip mode:
>../TASR -s targets.fa -f foobar.fof -m 15 -c 1 -u 1


How it works
------------

If the -s option is set and points to a valid fasta file, the DNA sequences comprised in that file will populate the hash table and be used exclusively as seeds to nucleate contig extensions (they will not be utilized to build the prefix tree).  In that scheme, every unique sequence target will be used in turn to nucleate an extension, using short reads found in the tree (specified in -f).  This feature might be useful if you already have characterized sequences & want to increase their length using short reads.  That said, since the short reads are not used as seeds when -s is set, they will not cluster to one another WITHOUT a target sequence file. 

The .singlets will ONLY list sequence targets for which there are no overlapping reads (even though the target might not have been extended).

DNA sequence reads in a fastq or fasta format are fed into into the algorithm via a file of filenames using the ‚ -f option.  DNA sequence targets, used to interrogate all reads are supplied as a multi fasta file using the ‚-s option.  Sequence targets are read first. From each target, every possible 15-character word (or user-defined -k) from the plus and minus strands is extracted and stored in a hash table. As the bulk of the NGS sequences are read, quality trimming is possible at run-time, provided that a fastq file is supplied, concurrently with the ‚-c 1 option. In SSAKE, the first 15bp of each read and of its reverse complement are unconditionally used as an index to fill the prefix tree.  In TASR, only those with matching 15-mer (-k mer) in the target sequence set are considered, thus limiting the sequence space to that of the target sequence. Low-complexity and large DNA sequence target will draw in more reads, which will impact the performance of TASR.  


TASR-Bloom
----------

TASR-Bloom uses a Bloom filter supplied with the -l option, to eliminate target k-mers for recruiting reads.
This could be useful for removing low-complexity or repeat k-mers in the supplied -s target sequences, for instance. 
The Bloom filter must be built with the ./writeBloom.pl utility in the ./tools folder and the k-mer length must match that supplied (-k).


Input sequences
---------------

-f file of filenames corresponding to fasta or fastq files
-s fasta

If lower caps are used in the target sequence, pileup will report the lower case in the reference base column (column 2). This is convenient for observing how many reads (along with strand, quality) align over a coordinate of interest.

e.g. (sequence targets file)
>dryEarwax-A
CTCACCAAGTCTGCCACTTACTGGCCaGAGTACACTGGCAATGCAGAAGCAG
>dryEarwax-C
CTCACCAAGTCTGCCACTTACTGGCCcGAGTACACTGGCAATGCAGAAGCAG
>dryEarwax-G
CTCACCAAGTCTGCCACTTACTGGCCgGAGTACACTGGCAATGCAGAAGCAG
>dryEarwax-T<
CTCACCAAGTCTGCCACTTACTGGCCtGAGTACACTGGCAATGCAGAAGCAG
>blackHair-C<
AGTGAGGAAAACACGGAGTTGATGCAcAAGCCCCAACATCCAACCTCGACTC
>blackHair-G
AGTGAGGAAAACACGGAGTTGATGCAgAAGCCCCAACATCCAACCTCGACTC

-Reads containing ambiguous bases "." and characters other than ACGT will be ignored entirely
-Spaces in fasta file are NOT permitted and will either not be considered or result in execution failure


Tips for choosing target sequences
----------------------------------

The length and sequence complexity of a target will have tremendous influence on the outcome of the assembly. Of course, depending on your application (SNV search, confirming SNPs, detecting fusion transcripts), the length & complexity may or may not matter.

The least complex a target sequence is, the more read candidates will be considered for assembly, which may lead to possible misassemblies.  If this is unavoidable, use a larger -m value than the suggested default.

For SNV/SNP detection, always provide a target sequence with the variant of interest AND one or more with reference/alternate bases.
Placing the base under scrutiny in the middle of the sequence is wise, as it will ensure maximum read coverage.
Also, we recommend that the target sequence be at least the length of the shortest read supplied (-f), and no longer than twice the read length.
Given a target sequence length (T) and read length (R), then: 
  R <= T < 2*(R-1)

The same principles can be applied for detecting a translocation or a fusion transcript, although usually less critical, esp. for the latter where depth of coverage is usually not limiting. 


Output files
------------

.contigs         :: fasta file; All sequence contigs
.log             :: text file; Logs execution time / errors / pairing stats (if -p is set to 1)
.singlets        :: fasta file; Unassembled sequence targets
.readposition    :: this is a text file listing all whole (fully embedded) reads, start and end coordinate onto the contig (in this order).  For reads aligning on the minus strand, end coordinate is < start coordinate
.coverage.csv    :: this is a comma separated values file showing the base coverage at every position for any given contig 
.pileup          :: produces a modified pileup output (see below)


Understanding the .contigs fasta header
---------------------------------------

e.g.
>TMPRSS2|size52|read193|cov92.79

target name (from target file)= TMPRSS2
size (G) = 52 nt
number of reads (N) = 193
cov [coverage] (C) = 92.79

the coverage (C) is calculated using the total number (T) of consensus bases [sum(L)] provided by the assembled sequences divided by the contig size:

C = T / G


Understanding the .coverage.csv file
------------------------------------

e.g.
>contig1|size60000|read74001|cov37.00
12,12,13,13,13,14,14,15,16,16,20,21,22,23,25,26,27,28,27 ...

Each number represents the number of reads covering that base at that position.


Understanding the .readposition file
------------------------------------

e.g.
>contig2|size63|read22|cov11.67|target:TMPRSS2:ERG
TMPRSS2:ERG,1,50,GGCGAGGGGCGGGGAGCGCCGCCTGGAGCGCGGCAGGAAGCCTTATCAGT,
SRR066437.4202230,15,44,AGCGCCGCCTGGAGCGCGGCAGGAAGCCTT,>>>>>>>>>>>>>>>>>6.>>.6.46:==7
SRR066437.1927821,18,47,GCCGCCTGGAGCGCGGCAGGAAGCCTTATC,>>>>>>>>>>>>>>6>64>>>>=6==+:=3
SRR066437.3225681,21,53,GCCTGGAGCGCGGCAGGAAGCCTTATCAGTTGT,>>>>>>>>>>>>>>6>>6>>>>==6=='='30-
SRR066437.3594935,21,53,GCCTGGAGCGCGGCAGGAAGCCTTATCAGTTGT,:::7::::7:::7::::::::::::::3:730-
SRR066437.1913934,29,61,CGCGGCAGGAAGCCTTATCAGTTGTGAGTGAGG,>>>>>>>>>>>>>>>>>>>.>>====)==730-
SRR066437.3115013,29,61,CGCGGCAGGAAGCCTTATCAGTTGTGAGTGAGG,>>6>>3>>.1.+'43:30)+4303+.&&)&))*
SRR066437.2253533,30,62,GCGGCAGGAAGCCTTATCAGTTGTGAGTGAGGA,>>>>>>>>>>>>>>>>>>0>>>==:==6=730-
SRR066437.1455332,30,62,GCGGCAGGAAGCCTTATCAGTTGTGAGTGAGGA,>>>>>:>>.1>66.>4>:0>0:66=1:)6.,0$
SRR066437.832206,31,63,CGGCAGGAAGCCTTATCAGTTGTGAGTGAGGAC,>>>>>>>>>>>>>>>>>>>>>>==6==3673,-
SRR066437.291122,31,63,CGGCAGGAAGCCTTATCAGTTGTGAGTGAGGAC,>>>>>>>>>>4>>>3>>6>6>4==6=0:)33'$
SRR066437.2290553,31,61,CGGCAGGAAGCCTTATCAGTTGTGAGTGAGG,>>>>>>>>>>>>>>>>>>>>>>==4===373
SRR066437.4722951,38,6,TCCTGCCGCGCTCCAGGCGGCGCTCCCCGCCCC,6::467:43:664:1.643+.++.4+3')0+$*
SRR066437.324519,42,10,GGCTTCCTGCCGCGCTCCAGGCGGCGCTCCCCG,>>>>>>>>>>>>>:>>>>46>>==666&6730)
SRR066437.2634544,55,23,TCACAACTGATAAGGCTTCCTGCCGCGCTCCAG,>>>>>>>>>>6>>>>>>>:>>6:'=:3+=2,+*
SRR066437.3918120,56,24,CTCACAACTGATAAGGCTTCCTGCCGCGCTCCA,::7::::::::::::::3:::'6::6:6:)30)
SRR066437.2949061,57,25,ACTCACAACTGATAAGGCTTCCTGCCGCGCTCC,>>>>>>>>>>>>>>>>>>>>>>=:==:==730-
SRR066437.1716315,60,28,CTCACTCACAACTGATAAGGCTTCCTGCCGCGC,>>>>>>>>>>>>>>>>>>>>>>=======730-

In this order: read name, start coordinate, end coordinate, read sequence, ascii-encoded quality scores (if applicable)
* end < start indicates read is on minus strand


Understanding the modified .pileup file
---------------------------------------

Refer to http://samtools.sourceforge.net/pileup.shtml
for detailed information on this format

e.g.
(...)
TMPRSS2:ERG     51      C       21      .............,,,,,,,, )-,0===:6>6>:>>>>>6>6
TMPRSS2:ERG     52      A       18      ..........,,,,,,,, *0=4:=>46:>>>>>4>>
TMPRSS2:ERG     53      G       17      .........,,,,,,,, :==:6.>>:>>>>>:>>
TMPRSS2:ERG     54      G       12      .........,,, 7==:46>>::>:
TMPRSS2:ERG     55      a       11      ........,,, ==.=.>6:6>>
TMPRSS2:ERG     56      A       10      ........,, 31664>>:>>
TMPRSS2:ERG     57      G       10      ........,, 33:66=>:>>
TMPRSS2:ERG     58      C       10      ........,, ,,70:6>:>>
TMPRSS2:ERG     59      C       10      ........,, --3/==>:>>
TMPRSS2:ERG     60      T       7       ......, 00===:>
TMPRSS2:ERG     61      T       7       ......, --7+=:>
TMPRSS2:ERG     62      A       4       ..., :6:6
TMPRSS2:ERG     63      T       4       ..., ==:>
TMPRSS2:ERG     64      C       4       ..., 3=:>
TMPRSS2:ERG     65      A       3       .., '3>
TMPRSS2:ERG     66      G       3       .., =:>
TMPRSS2:ERG     67      T       3       .., '7>
TMPRSS2:ERG     68      T       3       .., 33>
TMPRSS2:ERG     69      G       3       .., 00>
TMPRSS2:ERG     70      T       3       .., -->
TMPRSS2:ERG     71      G       1       , >
TMPRSS2:ERG     72      A       1       , >

"each line consists of chromosome (target name), 1-based coordinate, reference base, the number of reads covering the site, 
read bases and base qualities. At the read base column, a dot stands for a match to the reference base on the forward strand, a comma for a match on the reverse strand, `ACGTN' for a mismatch on the forward strand and `acgtn' for a mismatch on the reverse strand."

If applicable, ascii-encoded quality score follow the read base column.

NOTES:
*Read beginning and end aren't listed here.  Refer to .readposition to retrieve this information.
** "0" in the coverage column mean:
-The target sequence isn't covered by any read (most likely scenario)
-Although TASR extends the target sequences using a majority rule to determine the consensus sequence, individual reads that do not map with 100% sequence identity (over the whole read) to the consensus will influence the depth of coverage and cause the assembly to terminate.  The consensus is presented as-is.  *All reads that contributed to the assembly AND overlap *perfectly* the consensus will be listed in the .readposition and .pileup
-If target sequences supplied (-s) are identical, both the .pileup and .readposition will comprise information that reflects this. i.e.  Though TASR does not assemble targets together, identical sequences provided as input will be listed as one having the base coverage consistent with the input. 


License
-------

TASR Copyright (c) 2010-2016 Canada's Michael Smith Genome Science Centre.  All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

