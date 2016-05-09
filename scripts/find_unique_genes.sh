#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Usage: $0 genbankfile1.gbk genbankfile2.gbk"
  echo -e "Outputs a list of genes they have in common and a list of unique genes per genbank file. \nAs well as a short summary of the number of genes per file in the terminal window."
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

grep /gene= $2 | tr -s [:space:] | cut -c 9- | sed 's/.$//' | awk '!x[$0]++' | sort > $2_genes_sorted # it's identical to the one above apart from the in- and output

comm -12 $1_genes_sorted $2_genes_sorted > common_genes #this creates a list of all common genes

comm -3 common_genes $1_genes_sorted | cut -c 2- > $1_unique_genes #this creates a list of genes unique to the first genbank file. Cut is used to remove a tab space that gets inserted by comm before each gene name
comm -3 common_genes $2_genes_sorted | cut -c 2- > $2_unique_genes #this does the same but for the second genbank file

output1=$(grep -c ^ $1_genes_sorted)
output2=$(grep -c ^ $1_unique_genes)
fbname=$(basename "$1")
echo "$fbname has $output1 named genes and $output2 named unique genes."

output3=$(grep -c ^ $2_genes_sorted)
output4=$(grep -c ^ $2_unique_genes)
fbname=$(basename "$2")
echo "$fbname has $output3 named genes and $output4 named unique genes."

#echo "File 1 has $output3"
#echo "File 2 has $output4"
output5=$(grep -c ^ common_genes)
echo "They have $output5 named genes in common."
