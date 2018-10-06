echo "Predicting HLA from raw ONT reads for human NA19240..." 
echo "Fetching raw ONT promethion ERR2585115 data (Yoruban individual NA19240)..."
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR258/005/ERR2585115/ERR2585115.fastq.gz
echo "Fetching database for alignment..."
wget http://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz
####
echo "Running minimap2 (minimap2-2.12-r827) and HLAminer v1.4 combined ..."
/usr/bin/time -v -o minimap_hlaminerERR2585115_GEN.time minimap2 -t 60 -ax map-ont --MD GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz ERR2585115.fastq.gz | ../bin/HLAminer.pl -h ../database/HLA-I_II_GEN.fasta -s 500 -q 1 -i 1 -p ../database/hla_nom_p.txt -a stream
mv HLAminer_HPRA.csv HLAminer_HPRA_ERR2585115.csv
mv HLAminer_HPRA.log HLAminer_HPRA_ERR2585115.log
