#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Usage: $0 genbankfile.gbk"
  echo -e "Outputs a list of all named genes in the genbank file.\nIt also outputs the number of named genes."
  exit 1
fi

#use this script after you have read the comments, it removes any duplicates in case all gene instances in the
#gbk-file are duplicated, as is the case with KalgicidaOT1.gbk, but if your file happens to have
#two of the same gene on different loci, which KalgicidaOT1.gbk happens to have,
# you could accidentally remove one of them. You can copy and paste this for a demonstration:
#"grep /gene= '~/kordia_pathway_analysis/genbank_files/KalgicidaOT1.gbk' | tr -s [:space:] | cut -c 9- | sed 's/.$//' | wc -l" and compare it to
#"grep /gene= '~/kordia_pathway_analysis/genbank_files/KalgicidaOT1.gbk' | tr -s [:space:] | cut -c 9- | sed 's/.$//' | awk '!x[$0]++' | wc -l"
#you get 34 if you remove all doubles but 70 with all doubles intact, the result should be 35 because the
# gene "fusA" is found twice in the K. algicida OT 1 genome.

grep /gene= $1 | tr -s [:space:] | cut -c 9- | sed 's/.$//' | awk '!x[$0]++' | sort > $1_genes_sorted

# grep /gene= PROKKA_04082016.gbk # find every "/gene=" in PROKKA_04082016.gbk
# tr -s [:space:] # remove all spaces before "/gene=" because there are a lot of them
# cut -c 9- # remove the 9 first characters and print the rest
# sed 's/.$//' # remove the trailing character, in this case it's a '"'
# awk '!x[$0]++' # remove any duplicates, because it finds two of every result in the K algicida file, although it happened to have
#two "fusA" genes which complicates things a bit, use this with caution
# sort # simply sorts the results alphabetically in order to make it comparable with "comm" below

output1=$(grep -c ^ $1_genes_sorted)
fbname=$(basename "$1")
echo "$fbname has $output1 named genes"

