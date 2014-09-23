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
to update all reference sequences.


*Change the last line to point to the location of bwa on your system.
