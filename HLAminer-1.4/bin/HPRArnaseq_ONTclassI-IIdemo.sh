#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: $(basename $0) <NANOPORE RNA-seq FASTA/FASTQ (gzip or not)>"
        exit 1
fi

echo "Predicting HLA from $1 RNA-seq ONT reads..." 
echo "Fetching database for alignment..."
wget http://www.bcgsc.ca/downloads/btl/hlaminer/GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_CDS.fa.gz
####
echo "Running minimap2 (minimap2-2.12-r827) and HLAminer v1.4 combined ..."
/usr/bin/time -v -o minimap_hlaminerRNASEQont_CDS.time minimap2 -t 60 -ax map-ont --MD GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_CDS.fa.gz $1 | ../bin/HLAminer.pl -h ../database/HLA-I_II_CDS.fasta -s 500 -q 1 -i 1 -p ../database/hla_nom_p.txt -a stream
mv HLAminer_HPRA.csv HLAminer_HPRA_$1.csv
mv HLAminer_HPRA.log HLAminer_HPRA_$1.log
