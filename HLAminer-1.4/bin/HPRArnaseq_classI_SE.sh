### Run bwa or your favorite short read aligner
echo "Running bwa..."
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa aln -e 0 -o 0 ../database/HLA_ABC_CDS.fasta rd1.fq > aln_test.1.sai
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa samse ../database/HLA_ABC_CDS.fasta aln_test.1.sai rd1.fq  > aln.sam
### Predict HLA
echo "Predicting HLA..."
../bin/HLAminer.pl -a aln.sam -e 1 -h ../database/HLA_ABC_CDS.fasta -s 500
