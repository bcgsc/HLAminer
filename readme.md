[![Release](https://img.shields.io/github/release/warrenlr/HLAminer.svg)](https://github.com/warrenlr/HLAminer/releases)
[![Downloads](https://img.shields.io/github/downloads/warrenlr/HLAminer/total?logo=github)](https://github.com/warrenlr/HLAminer/releases/download/v1.4/HLAminer_1-4.tar.gz)
[![Issues](https://img.shields.io/github/issues/warrenlr/HLAminer.svg)](https://github.com/warrenlr/HLAminer/issues)
[![link](https://img.shields.io/badge/HLAminer-manuscript-brightgreen)](https://doi.org/10.1186/gm396)
Thank you for your [![Stars](https://img.shields.io/github/stars/warrenlr/HLAminer.svg)](https://github.com/warrenlr/HLAminer/stargazers)

![Logo](https://github.com/warrenlr/hlaminer/blob/master/hlaminer-logo.png)
# HLAminer

## HLAminer v1.4 Rene L. Warren (c) 2011-2023


### Manual Reference Pages – HLAminer - Derivation of HLA class I and class II predictions from shotgun sequence datasets
* This manual assumes that you have a working knowledge of unix, and some shell and perl scripting experience

### NAME
--------
  HLAminer - Derivation of HLA class I and class II predictions from shotgun sequence datasets

### CONTENTS
--------
1. [SYNOPSIS](#synopsis)
2. [LICENSE](#license)
3. [OVERVIEW](#overview)
4. [DESCRIPTION](#description)
5. [INSTALL](#install)
6. [COMMANDS AND OPTIONS](#commands)
7. [PREDICTING FROM LONG (NANOPORE/PACBIO) READS](#nanopore)
8. [DATABASES](#databases)
9. [AUTHORS](#authors)
10. [CITING](#citing)
11. [FULL LICENSE](#full)
--------
### SYNOPSIS <a name=synopsis></a>
--------

  HLAminer is a pipeline for predicting HLA from shotgun sequence data (ie. whole genome, whole transcriptome/RNA-Seq, exome), at the group and allele resolution.
  It supports predictions from a variety of DNA sequencing technologies including those from Illumina, MGI, PacBio and Oxford Nanopore.   
  Predictions are either derived from targeted assembly or direct alignment.

  For quick tests on Illumina RNA-seq data:
  1. Copy ./test-demo/    eg. cp -rf test-demo foo
  2. In folder "foo", edit the patient.fof file to point to your NGS RNAseq data.  Ensure all paths are ok.
  3. For HLA Predictions by Targeted Assembly of Shotgun Reads: execute ./HLAminer/foo/HPTASRrnaseq.sh 
     For HLA Predictions by Read Alignment: execute ./HLAminer/foo/HPRArnaseq.sh


### LICENSE <a name=license></a>
--------

  HLAminer Copyright (c) 2011-2022 Canada's Michael Smith Genome Science Centre.  All rights reserved.
  TASR Copyright   (c) 2010-2022 Canada's Michael Smith Genome Science Centre.  All rights reserved.
  SSAKE Copyright  (c) 2006-2022 Canada's Michael Smith Genome Science Centre.  All rights reserved.
   
  Due to the clinical implications of HLAminer, the code is now released
  under the BC Cancer Agency software license agreement (academic use).
  Details of the license can be accessed at:
  and at the bottom of this readme file

  For commercial licensing options, please contact Patrick Rebstein prebstein@bccancer.bc.ca

  Software components of HLAminer (eg. TASR) are still distributed under the
  terms of the GNU General Public License


### OVERVIEW <a name=overview></a>
--------

Derivation of HLA class I and class II predictions from shotgun sequence datasets (HLAminer) by:
1) Targeted Assembly of Shotgun Reads (HPTASR)
2) Read Alignment (HPRA)

BEST SHORT READ RESULTS ARE OBTAINED WITH HPTASR WITH READS 100bp AND UP (IDEALLY 150bp).
IT WILL WORK WITH SHORTER READS (50bp) BUT 4-digit HLA ALLELE PREDICTIONS MAY BE AMBIGUOUS 


### DESCRIPTION <a name=description></a>
--------

The HLA prediction by targeted assembly of short sequence reads (HPTASR), performs targeted de novo assembly of HLA NGS reads and align the resulting contigs to reference HLA alleles from the IMGT/HLA sequence repository using commodity hardware with standard specifications (<2GB RAM, 2GHz).  Putative HLA types are inferred by mining and scoring the contig alignments and an expect value is determined for each.  The method is accurate, simple and fast to execute and, for transcriptome data, requires low depth of coverage. Known HLA class I/class II reference sequences available from the IMGT/HLA public repository are read by TASR using default options (Warren and Holt 2011) to create a hash table of all possible 15 nt words (k-mers) from these reference sequences. Note that this parameter is customizable and larger k values will yield predictions with increased specificity (at the possible expense of sensitivity). Subsequently, NGS data sets are interrogated for the presence of one of these kmers (on either strand) at the 5’ or 3’ start. Whenever an HLA word is identified, the read is recruited as a candidate for de novo assembly. Upon de novo assembly of all recruited reads, a set of contigs is generated.  Only sequence contigs equal or larger than 200nt in length are considered for further analysis, as longer contigs better resolve HLA allelic variants.  Reciprocal BLASTN alignments are performed between the contigs and all HLA allelic reference sequences. HPTASR mines the alignments, scoring each possible HLA allele identified, computing and reporting an expect value (E-value) based on the chance of contigs characterizing given HLA alleles and, reciprocally, the chance of reference HLA alleles aligning best to certain assembled contig sequences

The HLA prediction from direct read alignment (HPRA) method is conceptually simpler and faster to execute, since paired reads are aligned up-front to reference HLA alleles.  Alignments from the HPTASR and HPRA methods are processed by the same software (HLAminer.pl) to derive HLA-I predictions by scoring and evaluating the probability of each candidate bearing alignments.


### What's new in version 1.4?
--------

Ability to stream the (.sam) output of modern read  aligners, directly into HLAminer.
Initial support for predicting HLA types from long nanopore reads such as those from Oxford Nanopore Technologies.
Better information/sub-routine/date tracking in hlaminer 


### What's new in version 1.3?
--------

A more concise HLA allele summary in HLAminer_HPTASR.csv and HLAminer_HPRA.csv (associated .log is unchanged and lists all predictions)
Keeps top two [highest-scoring by HLA group] predictions per gene and only the 'P' designated allele when the summary include HLA Sequences reported to have the same antigen binding domain.
For the original output, refer to the HLAminer_v1-2.pl included in the ./bin directory
A prediction example from MCF-7 PacBio RNA-seq reads is also provided


### What's new in version 1.2?
--------

Updated all HLA sequence databases
Corrected shell script that download HLA sequences to reflect change of location at EBI (ie. fasta sub folder) 
Added support for predictions from direct alignment of single-end reads


### INSTALL <a name=install></a>
--------
<pre>
1. Download and decompress the tar ball
gunzip HLAminer_v1-4.tar.gz 
tar -xvf HLAminer_v1-4.tar
2. Make sure you see the following directories:
./bin
./databases
./docs
./test-demo

3. Read the docs in the ./docs/ folder
4. Change/Add/Adjust the perl shebang line of each .pl and .sh script in the ./bin/ folder as needed
</pre>
From direct Read Alignment (HPRA, faster but less accurate):
HPRArnaseq_classI.sh
HPRArnaseq_classI-II.sh
HPRAwgs_classI.sh
HPRAwgs_classI-II.sh
-and for single end reads-
HPRArnaseq_classI_SE.sh
HPRArnaseq_classI-II_SE.sh
HPRAwgs_classI_SE.sh
HPRAwgs_classI-II_SE.sh


From Targeted Assembly (HPTASR, longer but more accurate):
HPTASRrnaseq_classI.sh
HPTASRrnaseq_classI-II.sh
HPTASRwgs_classI.sh
HPTASRwgs_classI-II.sh

*Running HPTASRwgs(rnaseq)_classI-II.sh will take longer than HPTASRwgs(rnaseq)_classI.sh, due to the reciprocal BLAST step.  You may remove this step from the former (and HLAminer.pl command) to speed things up.  However, this step is helpful in weeding out spurious alignments to HLA references.  That said, if you're solely interested in HLA-I, you have the option to run the latter set of scripts [HPTASRwgs(rnaseq)_classI.sh].

Also, in the ncbiBlastConfig2-2-XX.txt files (bin and test-demo directories), you may adjust the number of threads and number of reported alignments to speed things up. The options have different name depending on the blast version, refer to the blast manual
eg.
v2.2.22
option:description
-a:threads
-v:number of descriptions
-b:number of alignments

v2.2.28
-num_threads:threads
-max_target_seqs:number of hit sequences to report (when output is 5/xml)

In our hands, a few tests show that blast 2.2.22 may be faster than blast+ (2.2.28) while
producing accurate results - HLAminer (Warren et al. 2012) was thoroughly tested with 2.2.22

NCBI blast may be downloaded from:
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/
-or-
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/


HLAminer.pl
parseXMLblast.pl
[![link](https://img.shields.io/badge/TASR-github-yellow)](https://github.com/warrenlr/TASR)

5. You must install perl module Bio::SearchIO to use HPTASR
6. Edit the fullpath location of bwa and other software dependencies in the shell scripts in the ./bin/ folder, as needed
7. For your convenience, ncbi blastall and formatdb have been placed in the ./bin/ folder and executed from the following shell scripts:

NAME,PROCESS,NGS DATA TYPE,PREDICTIONS
HPRArnaseq_classI.sh,Paired read alignment,RNAseq (transcriptome),HLA-I A,B,C genes
HPRArnaseq_classI-II.sh,Paired read alignment,RNAseq (transcriptome),HLA-I A,B,C and HLA-II DP,DQ,DR genes

HPRAwgs_classI.sh,Paired read alignment,Exon capture (exome) and WGS (genome),HLA-I A,B,C genes
HPRAwgs_classI-II.sh,Paired read alignment,Exon capture (exome) and WGS (genome),HLA-I A,B,C and HLA-II DP,DQ,DR genes

HPTASRrnaseq_classI.sh,Targeted assembly of sequence reads,RNAseq (transcriptome),HLA-I A,B,C genes
HPTASRrnaseq_classI-II.sh,Targeted assembly of sequence reads,RNAseq (transcriptome),HLA-I A,B,C and HLA-II DP,DQ,DR genes

HPTASRwgs_classI.sh,Targeted assembly of sequence reads,Exon capture (exome) and WGS (genome),HLA-I A,B,C genes
HPTASRwgs_classI-II.sh,Targeted assembly of sequence reads,Exon capture (exome) and WGS (genome),HLA-I A,B,C and HLA-II DP,DQ,DR genes

Run those scripts by specifying the relative path ../bin/blastall or ../bin/formatdb in the shell scripts AND config file "ncbiBlastConfig.txt".  Make sure HPRA and HPTASR are running in same-level directories to ../bin/ (eg. ../test-demo/)

8. Before running on your data, inspect the ./test-demo/ folder and familiarize yourself with the files and the execution.  
9. When you are ready and the demo works well, place the fullpath location of your short read fastq or fasta files in the "patient.fof" file.
10. Make sure that the following files are in your working directory:

patient.fof
ncbiBlastConfig.txt (specific to the version of blast you are using, see in
../bin and ../test-demo directories

### ADDITIONAL INSTALL NOTES ON MAC OSX

#### install bioperl
---------------
sudo perl -MCPAN -e shell
install CJFIELDS/BioPerl-1.6.923.tar.gz
change shebang line in all PERL (.pl) scripts and location of bioperl on your system in HLAminer.pl

#### install ncbi blast
------------------
download and install blast-2.2.22-universal-macosx.tar.gz
change path to blast in ncbiconfig.txt

#### install homebrew
----------------
<pre>
ruby -e "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install)"

Since databases were indexed with older
version, had to re-index:
bwa index -a is HLA_ABC_CDS.fasta
</pre>

change path to bwa in HPRA* shell scripts

TEST YOUR INSTALL BY RUNNING THE SCRIPT IN test-demo. CONSULT THE README-FIRST.txt FILE


### COMMANDS AND OPTIONS <a name=commands></a>
--------

<pre>

Usage: ../bin/HLAminer.pl [v1.4]
Derivation of HLA class I and II predictions from shotgun sequence datasets
--------------------------------------------------------------------
HPTASR (HLA Predictions by Targeted Assembly of Shotgun Reads):
-b blastn alignments.........................<tig_vs_hla-ncbi.coord>
-r reciprocal blastn.........................<hla_vs_tig-ncbi.coord>
-c contig fasta file.........................<TASRhla200.contigs>
-z minimum contig size.......................<200>
------------------------------- OR ---------------------------------
HPRA (HLA Predictions by Read Alignment):
-a sam alignments............................< -a ngs_vs_hla.sam > or < -a stream >
-e single-end reads used (1=yes/0=no)........<0>
--------------------------------------------------------------------
-h hla fasta file............................<HLA_ABC_CDS.fasta>
-p P-designation file........................<hla_nom_p.txt>
-i minimum % sequence identity...............<99>
-q minimum log10 (phred-like) expect value...<30>
-s minimum score.............................<1000>
-n consider null alleles (1=yes/0=no)........<0>
-l label (run name) -optional-


The shell scripts are set to filter out short (<200) contigs that could blur HPTASR predictions.  Feel free to adjust as you see fit.

Likewise, HLAminer.pl runs with the set defaults:
-z minimum contig size.......................<200> (HPTASR)
-i minimum % sequence identity...............<99>  (HPTASR / HPRA)
-q minimum log10 (phred-like) expect value...<30>  (HPTASR / HPRA)
-s minimum score.............................<1000> (HPTASR / HPRA)
-n consider null alleles (1=yes/0=no)........<0> (HPTASR / HPRA)
</pre>

The minimum sequence identity applies to the short read paired alignment or blast alignment, depending on the choice made.  HLA predictions with a phred-like expect value lower than -q or a score lower than -s will not be diplayed.  Because IMGT/HLA reports numerous null alleles, an option exist to consider or not these unexpressed alleles. 

Likewise, TASR-based (Targeted Assembly of Short Reads) predictions could be
improved by using larger k values for assembly (-k). Experimentation for
choosing the ideal k to use depends on the input read length and is warranted. 


### PREDICTING FROM LONG (NANOPORE/PACBIO) READS <a name=nanopore></a>
--------

HLAminer v1.4 provides initial support for HLA prediction from raw uncorrected shotgun nanopore long reads (such as those from Oxford Nanopore Technologies).
HLAminer v1.4 implements a streaming approach to reading .sam alignment files, supporting the alignment of GB worth of read data in a few hours and predictions within seconds of alignment completion, without saving costly .sam files to disk.

We tested the software on the NA19240 WGS promethion dataset (2018, older chemistry).
https://gigabaseorgigabyte.wordpress.com/2018/05/24/promethion-human-genome-na19240/
with data available from ENA at this location:
https://www.ebi.ac.uk/ena/data/view/PRJEB26791

1) First, we downloaded read files (ERR2585112 and ERR2585115 from the ENA)
<pre>
nohup wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR258/005/ERR2585115/ERR2585115.fastq.gz &
nohup wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR258/002/ERR2585112/ERR2585112.fastq.gz &
</pre>
2) Then, we predicted HLA by running minimap2 and HLAminer v1.4:
<pre>
/usr/bin/time -v -o minimap_hlaminerERR2585115-1mod.time minimap2 -t 60 -ax map-ont --MD ../database/GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz ERR2585115.fastq.gz | ./HLAminer.pl -h ../database/HLA-I_II_GEN.fasta -s 500 -q 1 -i 1 -p ../database/hla_nom_p.txt -a stream

</pre>
A test is provided at ./test-demo/HPRAwgs_ONTclassI-IIdemo.sh

The output files:
HLAminer_HPRA_ERR2585115.csv
-and-
HLAminer_HPRA_ERR2585115.log

you generate should be comparable* to:
HLAminer_HPRA_ERR2585115_test.csv
-and-
HLAminer_HPRA_ERR2585115_test.log

*exact scores are not to be expected, because they vary based on the HLA sequence database used, which differ from different release of the code (and your own updating of HLA sequence databases, which is highly recommended to do before you use HLAminer).

Results below demonstrate HLAminer's ability to fairly accurately predict HLA-I and -II types from direct [and streamed] nanopore sequencing reads [old chemistry] alignments 
<pre>

HLAminer PREDICTIONS (top 2 per HLA allele group, by high-score):
--------------------

A*30:106/A*68:02P
B*35:01P/B*57:01P ex. B*57:03P
C*04:01P/C*18:01P
F*01:01P
G*01:01P

DQA1*01:02P/DQA1*05:01P
DQB1*05:02P/DQB1*03:03P ex. DQB1*03:01P
DRB1*12:01P/DRB1*16:02P
DPA1*02:02P/DPA1*01:03P
DPB1*90:01P/DPB1*01:01P
DRA*01:01P



REPORTED TYPES (extracted from https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5804087/#MOESM1 Supp file 1 13059_2018_1388_MOESM1_ESM.xlsx Tab S6, NA19240 (Child)):
--------------
 
A*30:01:01G/A*68:02:01G
B*35:01:01G/B*57:03:01G
C*04:01:01G/C*18:01:01G
F*01:01:01:08;F*01:01:01:09;F*01:02;F*01:01:01:10;F*01:03:01:01;F*01:01:01:11;F*01:03:01:02;F*01:01:01:12;F*01:01:02:01;F*01:01:02:02;F*01:01:02:03;F*01:01:02:04;F*01:01:02:05;F*01:01:02:06;F*01:01:01:01;F*01:01:01:02;F*01:01:01:03;F*01:01:01:04;F*01:01:01:05;F*01:01:01:06;F*01:01:01:07/F*01:01:01:08;F*01:01:01:09;F*01:02;F*01:01:01:10;F*01:03:01:01;F*01:01:01:11;F*01:03:01:02;F*01:01:01:12;F*01:01:02:01;F*01:01:02:02;F*01:01:02:03;F*01:01:02:04;F*01:01:02:05;F*01:01:02:06;F*01:01:01:01;F*01:01:01:02;F*01:01:01:03;F*01:01:01:04;F*01:01:01:05;F*01:01:01:06;F*01:01:01:07 
G*01:06;G*01:01:02:01;G*01:01:02:02;G*01:18;G*01:08:01;G*01:01:18;G*01:01:19/G*01:05N
H*02:05/H*02:05         
J*02:01;J*01:01:01:05;J*01:01:01:04;J*01:01:01:03;J*01:01:01:02;J*01:01:01:01/J*02:01;J*01:01:01:05;J*01:01:01:04;J*01:01:01:03;J*01:01:01:02;J*01:01:01:01     L*01:01:02;L*01:01:01:01;L*01:01:01:02;L*01:01:01:03/L*01:02

DQA1*01:02:01G/DQA1*05:01:01G
DQB1*05:02:01G/DQB1*03:01:01G
DRB1*12:01:01G/DRB1*16:02:01G
DPA1*02:01:01G/DPA1*02:02:02G
DPB1*01:01:01G/DPB1*01:01:01G
DOA*01:01:05/DOA*01:01:02:03;DOA*01:01:02:02;DOA*01:01:02:01;DOA*01:01:04:02;DOA*01:01:04:01    DMA*01:01:01:02;DMA*01:01:01:01;DMA*01:04;DMA*01:03;DMA*01:02;DMA*01:01:01:04;DMA*01:01:01:03/DMA*01:01:01:02;DMA*01:01:01:01;DMA*01:04;DMA*01:03;DMA*01:02;DMA*01:01:01:04;DMA*01:01:01:03
DMB*01:02;DMB*01:01:01:04;DMB*01:01:01:03;DMB*01:01:01:02;DMB*01:03:01:04;DMB*01:01:01:01;DMB*01:03:01:03;DMB*01:03:01:02;DMB*01:03:01:01;DMB*01:05;DMB*01:04/DMB*01:02;DMB*01:01:01:04;DMB*01:01:01:03;DMB*01:01:01:02;DMB*01:03:01:04;DMB*01:01:01:01;DMB*01:03:01:03;DMB*01:03:01:02;DMB*01:03:01:01;DMB*01:05;DMB*01:04
DRA*01:01:01:01;DRA*01:02:01;DRA*01:01:01:02;DRA*01:02:02;DRA*01:01:01:03;DRA*01:02:03;DRA*01:01:02/DRA*01:01:01:01;DRA*01:02:01;DRA*01:01:01:02;DRA*01:02:02;DRA*01:01:01:03;DRA*01:02:03;DRA*01:01:02
</pre>

For more information, please refer to:
[![link](https://img.shields.io/badge/HLAminer-preprint-brightgreen)](https://doi.org/10.48550/arXiv.2209.09155)


### DATABASES <a name=databases></a>
--------

Follow these instructions to download updated HLA sequences from ebi/imgt (shell scripts to automatically download and format the databases exist in ./database/) and refer to README.txt in the ./database directory:


1) Coding HLA sequences

HLA CDS sequences from:
<pre>
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/A_nuc.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/B_nuc.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/C_nuc.fasta
cat A_nuc.fasta B_nuc.fasta C_nuc.fasta | perl -ne 'chomp;if(/\>\S+\s+(\S+)/){print ">$1\n";}else{print "$_\n";}' > HLA_ABC_CDS.fasta
../bin/formatdb -p F -i HLA_ABC_CDS.fasta
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa index -a is HLA_ABC_CDS.fasta
</pre>

2) HLA genomic sequences 

To make the HLA genomic sequence database, execute these unix commands:
<pre>
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/A_gen.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/B_gen.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/C_gen.fasta
cat A_gen.fasta B_gen.fasta C_gen.fasta | perl -ne 'chomp;if(/\>\S+\s+(\S+)/){print ">$1\n";}else{print "$_\n";}' > HLA_ABC_GEN.fasta
../bin/formatdb -p F -i HLA_ABC_GEN.fasta
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa index -a is HLA_ABC_GEN.fasta
</pre>

FOR YOUR CONVENIENCE, A SINGLE SHELL SCRIPT CAN BE RUN FROM ../database TO
UPDATE ALL IMGT-HLA SEQUENCE DATABASES AND CREATE BWA/BLAST INDEXES. JUST KEEP
IN MIND THAT THIS IS DONE WITH A SPECIFIC VERSION OF THESE TOOLS, IF YOU
UPGRADE, YOU WILL HAVE TO REGENERATE THE INDEXES
******************************
***../database/updateAll.sh***
******************************

Note: For alignment of nanopore genomic/transcriptomic reads, we recommend aligning to a file comprised of human genome chromosome and HLA-I and -II alleles to reduce the noise in alignments (especially when running minimap2). If you are predicting from direct ONT (nanopore) or PacBio long read alignments, please update the genome files:
<pre>
cd database
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_GEN.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_CDS.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_CDS.fa.gz
</pre>
Genome file (without Chr6)
https://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa.gz

or download those files (Aug 2022 update) from:
https://www.bcgsc.ca/downloads/btl/hlaminer/


3) P designation files

Upgrade the P designation info from:

info:
http://hla.alleles.org/wmda/index.html

file:
http://hla.alleles.org/wmda/hla_nom_p.txt


### OUTPUT FILES <a name="OUTPUT"></a>
--------

HLA predictions from read pair alignments:

HLAminer_HPRA.log
HLAminer_HPRA.csv

HLA predictions from targeted assemblies:

HLAminer_HPTASR.log
HLAminer_HPTASR.csv

The .log file tracks the process of HLA mining. It contains the following information:
-HLAminer command and parameters utilized
-Contig/read pair alignment output and best HLA hit for each
-Initial gene summary, score and expect value
-Final summary, listing all predictions by highest score (more likely).

The .csv file contains HLAminer predictions.  Predictions are listed by HLA
gene and ranked by highest score.  Predictions 1) and 2) are expected to
represent the two alleles for each.

eg.
<pre>
----------------------------------------------------------------------
SUMMARY
MOST LIKELY HLA-I ALLELES (Confidence (-10 * log10(Eval)) >= 30, Score >= 500)
Allele,Score,Expect (Eval) value,Confidence (-10 * log10(Eval))
----------------------------------------------------------------------

HLA-A
Prediction #1 - A*26
        A*26:33,4179,5.22e-124,1232.8

Prediction #2 - A*33
        A*33:24,1791,2.41e-75,746.2

Prediction #3 - A*68
        A*68:05,597,1.85e-10,97.3
</pre>

From these predictions, the individual is expected to be heterozygous with HLA-I A alleles A*26 and
A*33. The chance, expect value and confidence are different representations of the same
metric. The Confidence represents the Expect value - Eval - as a score in a
manner analoguous to the phred score employed in sequencing to quickly assess
the likelihood of a base being correct. 

Predictions/read pair are ambiguous when there are multiple predicted allele groups and/or protein coding alleles with the same score.


### AUTHORS <a name=authors></a>
--------

<pre>
Rene Warren
</pre>

### CITING <a name=citing></a>
--------

Thank you for your [![Stars](https://img.shields.io/github/stars/warrenlr/HLAminer.svg)](https://github.com/warrenlr/HLAminer/stargazers) and for using, developing and promoting this free software!

If you use HLAminer for you research, please cite:

<pre>
Warren RL, Choe G, Freeman DJ, Castellarin M, Munro S, Moore R, Holt 
RA.  2012. Derivation of HLA types from shotgun sequence datasets. 
Genome Med. 4:95
</pre>
[![link](https://img.shields.io/badge/HLAminer-manuscript-brightgreen)](https://doi.org/10.1186/gm396)

and

<pre>
Warren RL. 2022. 
HLA predictions from long sequence read alignments, streamed directly into HLAminer.
arXiv. https://doi.org/10.48550/arXiv.2209.09155
</pre>
[![link](https://img.shields.io/badge/HLAminer-preprint-brightgreen)](https://doi.org/10.48550/arXiv.2209.09155)


### LICENSE AGREEMENT <a name=full></a>
-----------------------------------------------------------
BC CANCER AGENCY SOFTWARE LICENSE AGREEMENT (ACADEMIC USE)

CAREFULLY READ THE FOLLOWING TERMS AND CONDITIONS. This License
Agreement (the "Agreement") is a legal contract between you, your
employer, educational institution or organization (collectively, "You")
and the British Columbia Cancer Agency ("BCCA") with respect to the
license of the software, including all associated documentation
(collectively, the "Product").

BCCA is willing to license the Product to You only if You accept the
terms and conditions of this Agreement. By clicking on the "I ACCEPT"
button, or by copying, downloading, accessing or otherwise using the
Product, You automatically agree to be bound by the terms of this
Agreement. IF YOU DO NOT WISH TO BE BOUND BY THE TERMS OF THIS
AGREEMENT, DO NOT COPY, DOWNLOAD, ACCESS OR OTHERWISE USE THE
PRODUCT.

1. AUTHORITY: In the event that You are an educational institution or
organization, Your representative who is clicking the "I ACCEPT"
button, or otherwise copying, downloading, accessing or using the
Product hereby, in their personal capacity, represents and warrants
that they possess the legal authority to enter into this Agreement
on Your behalf and to bind You to the terms of this Agreement.

2. LICENSE TO USE: BCCA hereby grants to You a personal, non-exclusive,
non-transferable, limited license to use the Product solely for
internal, non-commercial use for non-profit research or educational
purposes only on the terms and conditions contained in this Agreement.
The Product may be installed at a single site at Your premises only. A
copy of the Product installed on a single common machine or cluster of
machines may be shared for internal use by Qualified Users only. In
order to be a "Qualified User", an individual must be a student,
researcher, professor, instructor or staff member of a non-profit
educational institution or organization who uses the Product solely for
non-profit research or educational purposes.

3. RESTRICTIONS: You acknowledge and agree that You shall not, and
shall not authorize any third party to:
(a) make copies of the Product, except as provided in Section 2 and
except for a single backup copy, and any such copy together with the
original must be kept in Your possession or control;
(b) modify, adapt, decompile, disassemble, translate into another
computer language, create derivative works of, or otherwise reverse
engineer the Product, or disclose any trade secrets relating to the
Product, except as permitted in Section 5;
(c) license, sublicense, distribute, sell, lease, transfer, assign,
trade, rent or publish the Product or any part thereof and/or copies
thereof, to any third party;
(d) use the Product to process any data other than Your own;
(e) use the Product or any part thereof for any commercial or
for-profit purpose or any other purpose other than as permitted in
Section 2; or
(f) use, without its express permission, the name of BCCA.

4. INTELLECTUAL PROPERTY RIGHTS: Subject to Section 5 below, all
patents, copyrights, trade secrets, service marks, trademarks and
other proprietary rights in or related to the Product and any
improvements, modifications and enhancements thereof are and will
remain the exclusive property of BCCA or its licensors. You agree
that You will not, either during or after the termination of this
Agreement, contest or challenge the title to or the intellectual
property rights of BCCA or its licensors in the Product or any
portion thereof.

5. OWNERSHIP OF IMPROVEMENTS: In the event that the Product, in the
form provided to You, includes source code (the "Source Code"),
You are entitled to make improvements, modifications and
enhancements to the Source Code (collectively, "Improvements")
which Improvements are to be used by You for non-profit research
and educational purposes only and You shall be the owner of those
Improvements that You directly make and of all intellectual
property rights to such Improvements, subject to the foregoing
limits on Your use and distribution of such Improvements. You
hereby grant to BCCA a perpetual, non-exclusive, worldwide,
fully-paid, irrevocable license to use such Improvements for any
purposes whatsoever, and to sublicense such Improvements including
the right for third parties to sublicense the same, in perpetuity
to the extent such rights are not limited in duration under
applicable law, without identifying or seeking Your
consent. Notwithstanding the foregoing, You acknowledge that BCCA
and its licensors will retain or own all rights in and to any
pre-existing code or other technology, content and data that may be
incorporated in the Improvements. For greater certainty, this
Section applies solely to the Source Code and shall not give You
any rights with respect to the object code or any other portion or
format of the Product which use, for greater certainty, is limited
as set forth in this Agreement including as set out in Section 3(b)
above. You acknowledge and agree that you will provide copies of
Improvements to BCCA in such format as reasonably requested by BCCA
at any time upon the request of BCCA.

6. CONFIDENTIALITY: You acknowledge that the Product is and
incorporates confidential and proprietary information developed,
acquired by or licensed to BCCA. You will take all reasonable
precautions necessary to safeguard the confidentiality of the
Product, and will not disclose any information about the Product to
any other person without BCCA's prior written consent. You will
not allow the removal or defacement of any confidential or
proprietary notice placed on the Product. You acknowledge that any
breach of this Section 6 will cause irreparable harm to BCCA and
its licensors.

7. NO WARRANTIES: THIS PRODUCT IS PROVIDED TO YOU BY BCCA IN ORDER TO
ALLOW YOU TO OBTAIN ACCESS TO LEADING ACADEMIC RESEARCH. THE PRODUCT
IS PROVIDED TO YOU ON AN "AS IS" BASIS WITHOUT WARRANTY OF ANY
KIND. NO WARRANTY, REPRESENTATION OR CONDITION EITHER EXPRESS OR
IMPLIED, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTY OR
CONDITION OF MERCHANTABILITY, NON-INFRINGEMENT, PERFORMANCE,
DURABILITY OR FITNESS FOR A PARTICULAR PURPOSE OR USE SHALL
APPLY. BCCA DOES NOT WARRANT THAT THE PRODUCT WILL OPERATE ON A
CONTINUOUS OR TROUBLE FREE BASIS.

8. LIMITATION OF LIABILITY: TO THE MAXIMUM EXTENT PERMITTED BY
APPLICABLE LAW, IN NO EVENT SHALL THE AGGREGATE LIABILITY OF BCCA TO
YOU EXCEED THE AMOUNT YOU HAVE PAID TO ACQUIRE THE PRODUCT ("MAXIMUM
AMOUNT") AND WHERE YOU HAVE NOT PAID ANY AMOUNT FOR THE PRODUCT THEN
THE MAXIMUM AMOUNT SHALL BE DEEMED TO BE CDN$100.00. IN NO EVENT SHALL
BCCA BE LIABLE FOR ANY INDIRECT, INCIDENTAL, CONSEQUENTIAL, OR SPECIAL
DAMAGES, INCLUDING WITHOUT LIMITATION ANY DAMAGES FOR LOST PROFITS OR
SAVINGS, REGARDLESS OF WHETHER THEY HAVE BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE. EXCEPT TO THE EXTENT THAT THE LAWS OF A
COMPETENT JURISDICTION REQUIRE LIABILITIES BEYOND AND DESPITE THESE
LIMITATIONS, EXCLUSIONS AND DISCLAIMERS, THESE LIMITATIONS, EXCLUSIONS
AND DISCLAIMERS SHALL APPLY WHETHER AN ACTION, CLAIM OR DEMAND ARISES
FROM A BREACH OF WARRANTY OR CONDITION, BREACH OF CONTRACT,
NEGLIGENCE, STRICT LIABILITY OR ANY OTHER KIND OF CIVIL OR STATUTORY
LIABILITY CONNECTED WITH OR ARISING FROM THIS AGREEMENT. YOU AGREE
THAT THE FOREGOING DISCLAIMER OF WARRANTIES AND LIMITATION OF
LIABILITY ARE FAIR IN LIGHT OF THE NATURE OF THE RIGHTS GRANTED HEREIN
AND THE AMOUNT OF FEES PAID BY YOU IN RESPECT OF THE PRODUCT.

9. INDEMNITY: You will indemnify, defend and hold harmless BCCA, its
board of directors, staff and agents from and against any and all
liability, loss, damage, action, claim or expense (including
attorney's fees and costs at trial and appellate levels) in
connection with any claim, suit, action, demand or judgement
(collectively, "Claim") arising out of, connected with, resulting
from, or sustained as a result of Your use of the Product or the
downloading of the Product, including without limitation, any Claim
relating to infringement of BCCA's intellectual property rights or
the intellectual property rights of any third party.

10. SUPPORT AND MAINTENANCE: You acknowledge and agree that, unless
and to the extent expressly agreed by BCCA in a separate written
document, the Product is provided to You without any support or
maintenance from BCCA and, for greater certainty, BCCA shall have
no obligation to issue any update or upgrade to any Product.

11. TERM: This Agreement is effective until terminated. You may
terminate this Agreement at any time by ceasing use of the Product
and destroying or deleting any copies of the Product. This
Agreement will terminate immediately without notice from BCCA if
You fail to comply with any provision of this Agreement. BCCA may
terminate this Agreement at any time upon notice to you where BCCA
determines, in its sole discretion, that any continued use of the
Product could infringe the rights of any third parties. Upon
termination of this Agreement, and in any event upon BCCA
delivering You notice of termination, You shall immediately purge
all Products from Your computer system(s), return to BCCA all
copies of the Product that are in Your possession or control, and
cease any further development of any Improvements. On any
termination of this Agreement Sections 1, 4, 6, 7, 8, 9, 13 and 14
shall survive such termination.

12. GOVERNMENT END USERS: Where any of the Product is used, duplicated
or disclosed by or to the United States government or a government
contractor or sub contractor, it is provided with RESTRICTED
RIGHTS as defined in Title 48 CFR 52.227-19 and is subject to the
following: Title 48 CFR 2.101, 52.227-19, 227.7201 through
227.7202-4, FAR 52.227-14, and FAR 52.227-19(c)(1-2) and (6/87),
and where applicable, the customary software license, as described
in Title 48 CFR 227-7202 with respect to commercial software and
commercial software documentation including DFAR 252.227-7013,
DFAR 252,227-7014, DFAR 252.227-7015 and DFAR 252.7018, all as
applicable.

13. USE OF THE DOWNLOAD SERVICE: You acknowledge and agree that you
will be responsible for all costs, charges and taxes (where
applicable) arising out of Your use of the Product and the
downloading of the Product. You acknowledge that You are
responsible for supplying any hardware or software necessary to
use the Product pursuant to this Agreement.

14. GENERAL PROVISIONS:
(a) This Agreement will be governed by the laws of the Province of
British Columbia, and the laws of Canada applicable therein, excluding
any rules of private international law that lead to the application of
the laws of any other jurisdiction. The United Nations Convention on
Contracts for the International Sale of Goods (1980) does not apply to
this Agreement. The courts of the Province of British Columbia shall
have non-exclusive jurisdiction to hear any matter arising in
connection with this Agreement.
(b) USE OF THE PRODUCT IS PROHIBITED IN ANY JURISDICTION WHICH DOES
NOT GIVE EFFECT TO THE TERMS OF THIS AGREEMENT.
(c) You agree that no joint venture, partnership, employment,
consulting or agency relationship exists between You and BCCA as a
result of this Agreement or Your use of the Product.
(d) You hereby consent to Your contact information and any other
personally identifiable information that You provide to us being
disclosed to and maintained and used by us and our business partners
for the purposes of (i) managing and developing our respective
businesses and operations; (ii) marketing products and services to You
and your staff; and (iii) developing new and enhancing existing
products. You further agree that we may provide this information to
other persons as required to satisfy any legal requirements and to any
person that acquires some or all of the assets of BCCA. Where any of
the personally identifiable information that You provide to us is in
respect of individuals other than Yourself (such as Your staff) then
You represent and warrant to use that You have obtained all necessary
consents and authorizations from such individuals in order to comply
with this provision. Please see the BCCA website for further
information regarding personally identifiable information.
(e) This Agreement is the entire Agreement between You and BCCA
relating to this subject matter. You will not contest the validity of
this Agreement merely because it is in electronic form. No
modification of this Agreement will be binding, unless in writing and
accepted by an authorized representative of each party.
(f) The provisions of this Agreement are severable in that if any
provision in the Agreement is determined to be invalid or
unenforceable under any controlling body of law, that will not affect
the validity or enforceability of the remaining provisions of the
Agreement.
(g) You agree to print out or download a copy of this Agreement and
retain it for Your records.
(h) You consent to the use of the English language in this Agreement.
(i) You may not assign this Agreement or any of Your rights or
obligations hereunder without BCCA's prior written consent. BCCA, at
its sole discretion may assign this Agreement without notice to You.

For commercial licensing options, please contact Patrick Rebstein prebstein@bccancer.bc.ca
-----------------------------------------------------------
