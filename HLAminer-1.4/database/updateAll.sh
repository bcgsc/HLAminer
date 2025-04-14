./updateHLAcoding.sh
./updateHLAgenomic.sh
./updateHLA-I_II_coding.sh
./updateHLA-I_II_genomic.sh
./update_p_designation.sh
# GRCh38, no chr6, for alignment
wget https://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa.gz
unpigz GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_GEN.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-noChr6.fa HLA-I_II_CDS.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_CDS.fa.gz
# GRCh38, no chr6 HLA loci, for alignment
wget https://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa.gz
unpigz GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa HLA-I_II_GEN.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked-HLA-I_II_GEN.fa.gz
cat GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked.fa HLA-I_II_CDS.fasta | pigz - > GCA_000001405.15_GRCh38_genomic.chr-only-chr6hlamasked-HLA-I_II_CDS.fa.gz
