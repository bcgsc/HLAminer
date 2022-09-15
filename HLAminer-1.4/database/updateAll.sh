./updateHLAcoding.sh
./updateHLAgenomic.sh
./updateHLA-I_II_coding.sh
./updateHLA-I_II_genomic.sh
./update_p_designation.sh
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_GEN.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_CDS.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_CDS.fa.gz
