#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: $(basename $0) <NANOPORE WGS FASTA/FASTQ (gzip or not)>"
        exit 1
fi

echo "Predicting HLA from raw ONT reads..." 
####
echo "Running minimap2 and HLAminer v1.4 combined (ensure they are both in your PATH) ..."
echo "GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz, HLA-I_II_GEN.fasta and hla_nom_p.txt MUST BE FOUND in your working directory"
####
/usr/bin/time -v -o minimap_hlaminerWGS$1.time minimap2 -t 48 -ax map-ont --MD GCA_000001405.15_GRCh38_genomic.chr-only-noChr6-HLA-I_II_GEN.fa.gz $1 | HLAminer.pl -h HLA-I_II_GEN.fasta -s 500 -q 1 -i 1 -p hla_nom_p.txt -a stream
####
echo done.
mv HLAminer_HPRA.csv HLAminer_HPRA_$1.csv
mv HLAminer_HPRA.log HLAminer_HPRA_$1.log
