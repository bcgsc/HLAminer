###Run TASR
echo "Running TASR..."
../bin/TASR -f patient.fof -m 20 -s ../database/HLA_ABC_GEN.fasta -i 1 -b TASRhla
###Restrict 200nt+ contigs
cat TASRhla.contigs |perl -ne 'if(/size(\d+)/){if($1>=200){$flag=1;print;}else{$flag=0;}}else{print if($flag);}' > TASRhla200.contigs
###Create a [NCBI] blastable database
echo "Formatting blastable database..."
../bin/formatdb -p F -i TASRhla200.contigs
###Align contigs against database
echo "Aligning TASR contigs to HLA references..."
../bin/parseXMLblast.pl -c ncbiBlastConfig.txt -d ../database/HLA_ABC_GEN.fasta -i TASRhla200.contigs -o 0 > tig_vs_hla-ncbi.coord
###Align HLA references to contigs
echo "Aligning HLA references to TASR contigs..."
../bin/parseXMLblast.pl -c ncbiBlastConfig.txt -i ../database/HLA_ABC_GEN.fasta -d TASRhla200.contigs -o 0 > hla_vs_tig-ncbi.coord
###Predict HLA alleles
echo "Predicting HLA alleles..."
../bin/HLAminer.pl -b tig_vs_hla-ncbi.coord -r hla_vs_tig-ncbi.coord -c TASRhla200.contigs -h ../database/HLA_ABC_GEN.fasta
