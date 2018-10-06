### Run bwa or your favorite short read aligner
echo "Running bwa v0.7.17-r1188"
bwa aln -e 0 -o 0 ../database/HLA_ABC_CDS.fasta rd1.fq > aln_test.1.sai
bwa aln -e 0 -o 0 ../database/HLA_ABC_CDS.fasta rd2.fq > aln_test.2.sai
bwa sampe -o 1000 ../database/HLA_ABC_CDS.fasta aln_test.1.sai aln_test.2.sai rd1.fq rd2.fq > aln.sam

#echo "Running bwa mem..."
#/gsc/btl/linuxbrew/bin/bwa mem -a ../database_bwamem/HLA_ABC_CDS.fasta rd1.fq rd2.fq > TEST_vs_HLA.sam
#echo "Fixing MD tag..."
#/gsc/btl/linuxbrew/bin/samtools fillmd -S TEST_vs_HLA.sam ../database_bwamem/HLA_ABC_CDS.fasta > aln.sam

### Predict HLA
echo "Predicting HLA..."
../bin/HLAminer.pl -a aln.sam -h ../database/HLA_ABC_CDS.fasta -s 500
mv HLAminer_HPRA.csv HLAminer_HPRArun.csv
mv HLAminer_HPRA.log HLAminer_HPRArun.log
