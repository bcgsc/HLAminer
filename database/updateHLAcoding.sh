rm -rf *_nuc.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/A_nuc.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/B_nuc.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/C_nuc.fasta
cat A_nuc.fasta B_nuc.fasta C_nuc.fasta | perl -ne 'chomp;if(/\>\S+\s+(\S+)/){print ">$1\n";}else{print "$_\n";}' > HLA_ABC_CDS.fasta
../bin/formatdb -p F -i HLA_ABC_CDS.fasta
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa index -a is HLA_ABC_CDS.fasta
