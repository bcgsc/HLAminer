rm -rf *_nuc.fasta
wget ftp://ftp.ebi.ac.uk/pub/databases/imgt/mhc/hla/fasta/*_nuc.fasta
cat A_nuc.fasta B_nuc.fasta C_nuc.fasta F_nuc.fasta G_nuc.fasta H_nuc.fasta DP*_nuc.fasta DQ*_nuc.fasta DR*_nuc.fasta | perl -ne 'chomp;if(/\>\S+\s+(\S+)/){print ">$1\n";}else{print "$_\n";}' > HLA-I_II_CDS.fasta
../bin/formatdb -p F -i HLA-I_II_CDS.fasta
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa index -a is HLA-I_II_CDS.fasta
