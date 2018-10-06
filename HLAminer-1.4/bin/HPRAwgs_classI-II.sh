### Run bwa or your favorite short read aligner
echo "Running bwa..."
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa aln -e 0 -o 0 ../database/HLA-I_II_GEN.fasta rd1.fq > aln_test.1.sai
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa aln -e 0 -o 0 ../database/HLA-I_II_GEN.fasta rd2.fq > aln_test.2.sai
/home/pubseq/BioSw/bwa/bwa-0.5.9/bwa sampe -o 1000 ../database/HLA-I_II_GEN.fasta aln_test.1.sai aln_test.2.sai rd1.fq rd2.fq > aln.sam
### Predict HLA
echo "Predicting HLA..."
../bin/HLAminer.pl -a aln.sam -h ../database/HLA-I_II_GEN.fasta -s 500
