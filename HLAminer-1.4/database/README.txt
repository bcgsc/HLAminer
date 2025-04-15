HLA databases
=============

HLA_ABC_CDS.fasta
Comprises all IMGT/HLA HLA-I CDS

HLA-I_II_CDS.fasta
Comprises all IMGT/HLA HLA CDS (including class I and II)

HLA_ABC_GEN.fasta
Comprises all IMGT/HLA HLA-I genomic sequences

HLA-I_II_GEN.fasta
Comprises all IMGT/HLA HLA genomic sequences (including class I and II)



Run*:
updateHLAcoding.sh
-and-
updateHLA-I_II_coding.sh

updateHLAgenomic.sh
-and-
updateHLA-I_II_genomic.sh

to update the coding and genomic HLA sequence databases, respectively.

update_p_designation.sh 
to update the p designation file

or: ./updateAll.sh 
to update all reference sequences, including the ones used to predict from direct ONT (nanopore) or PacBio long read alignments (below)


*Change the last line to point to the location of bwa on your system.

If you are predicting from direct ONT (nanopore) or PacBio long read alignments, please update the genome files:

cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_GEN.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_CDS.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_CDS.fa.gz

and/or (Please see in the REFERENCE SEQUENCE FOR LONG-READ ALIGNMENTS section main README):

cat GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa HLA-I_II_GEN.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked-HLA-I_II_GEN.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa HLA-I_II_CDS.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked-HLA-I_II_CDS.fa.gz


Genome file (without Chromosome 6)
https://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa.gz

Genome file (with Chromosome 6 HLA locus masked)
https://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa.gz


or download (jan/apr 2025 update) from:
https://www.bcgsc.ca/downloads/btl/hlaminer/
