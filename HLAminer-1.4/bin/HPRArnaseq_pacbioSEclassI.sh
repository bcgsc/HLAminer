### Run bwa or your favorite short read aligner
#echo "Building bwa index..."
#/gsc/btl/linuxbrew/bin/bwa index HLA_ABC_CDS.fasta
echo "Downloading MCF-7 pacbio RNA-seq reads..."
wget http://www.bcgsc.ca/downloads/btl/hlaminer/IsoSeq_MCF7_polished.unimapped.fasta
echo "Running bwa mem..."
bwa mem -x pacbio ../database_bwamem/HLA_ABC_CDS.fasta IsoSeq_MCF7_polished.unimapped.fasta > MCF7_vs_HLA.sam
echo "Fixing MD tag..."
samtools fillmd -S MCF7_vs_HLA.sam ../database_bwamem/HLA_ABC_CDS.fasta > MCF7_vs_HLAmd.sam
### Predict HLA
echo "Predicting HLA..."
../bin/HLAminer.pl -a MCF7_vs_HLAmd.sam -h ../database_bwamem/HLA_ABC_CDS.fasta -s 500 -q 1 -i 1 -e 1
mv HLAminer_HPRA.csv HLAminer_HPRA_MCF-7.csv
mv HLAminer_HPRA.log HLAminer_HPRA_MCF-7.log
