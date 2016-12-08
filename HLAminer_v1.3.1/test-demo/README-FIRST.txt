For HLAminer predictions from short Read Alignments, run:

./HPRArnaseq_classI.sh

For HLAminer predictions from Targeted Assembly of Sequence Reads, run:

./HPTASRrnaseq_classI.sh

Notes:
-Running these shell scripts will generate HLA predictions from randomly generated read pairs (rd1.fq and rd2.fq).
-Because we wanted to limit the size of the HLAminer distribution, we only left read pairs that were randomly generated from HLA-I A, B and C genes from file random_HLA_alleles_tested.fa.  As such, rd1.fq and rd2.fq are provided with the sole purpose to test your installation.
-In real life scenarios, the patient.fof file-of-filenames will include ALL shotgun sequences generated from a sample.
-If the installation worked (without updating the databases), the files:

HLAminer_HPRA.csv
HLAminer_HPRA.log
HLAminer_HPTASR.csv
HLAminer_HPTASR.log

you generate should match:

HLAminer_HPRA_test.csv
HLAminer_HPRA_test.log
HLAminer_HPTASR_test.csv
HLAminer_HPTASR_test.log

included in this directory.


RLW2014

