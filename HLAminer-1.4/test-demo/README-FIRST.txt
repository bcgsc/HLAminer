RLW(c)2014/2018

The tests in this directory are provided for your convenience.
They can be used to test your installation, and to demo HLA prediction pipeline with RNA-Seq/WGS reads from the following technologies:
A. Illumina 
B. Pacbio
C. Raw nanopore (Oxford Nanopore) 




A) To test your installation and pipeline with Illumina RNA-Seq data, run:

For HLAminer predictions from short Read Alignments, run:

./HPRArnaseq_classI.sh

For HLAminer predictions from Targeted Assembly of Sequence Reads, run:

./HPTASRrnaseq_classI.sh

Notes:
-Running these shell scripts will generate HLA predictions from randomly generated read pairs (rd1.fq and rd2.fq).
-Because we wanted to limit the size of the HLAminer distribution, we only left read pairs that were randomly generated from HLA-I A, B and C genes from file random_HLA_alleles_tested.fa.  As such, rd1.fq and rd2.fq are provided with the sole purpose to test your installation.
-In real life scenarios, the patient.fof file-of-filenames will include ALL shotgun sequences generated from a sample.
-If the installation worked (without updating the databases), the files:

HLAminer_HPRArun.csv
HLAminer_HPRArun.log
HLAminer_HPTASR.csv
HLAminer_HPTASR.log

you generate should be comparable* to:

HLAminer_HPRA_test.csv
HLAminer_HPRA_test.log
HLAminer_HPTASR_test.csv
HLAminer_HPTASR_test.log

included in this directory.


B) A Pacbio RNA-Seq data (MCF-7) is provided

./HPRArnaseq_pacbioSEclassI.sh

The output files:
HLAminer_HPRA_MCF-7.csv
HLAminer_HPRA_MCF-7.log

you generate should be comparable* to:

HLAminer_HPRA_MCF-7_test.csv
HLAminer_HPRA_MCF-7_test.log


C) Initial support for raw Oxford Nanopore Technologies (ONT) is provided
Because the throughput of the ONT promethion is rather large, the file download will take some time.
Also, expect ~1h for read mapping with minimap2, using 60 threads.  HLAminer.pl will run in < 1minute however.

./HPRAwgs_ONTclassIdemo.sh

The output files:
HLAminer_HPRA_ERR2585115.csv
HLAminer_HPRA_ERR2585115.log

you generate should be comparable* to:
HLAminer_HPRA_ERR2585115_test.csv
HLAminer_HPRA_ERR2585115_test.log


*exact scores are not to be expected, because they vary based on the HLA sequence database used, which differ from different release of the code


