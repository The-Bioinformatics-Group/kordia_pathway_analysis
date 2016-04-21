#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Usage: $0 genbankfile.gbk"
  echo -e "Outputs a list of all protein products in the genbank file.\nIt also outputs the number of protein products."
  exit 1
fi
fbname=$(basename "$1")
grep /product= $1 | tr -s [:space:] | cut -c 12- | sed 's/.$//' | grep -Ev 'hypothetical protein' > $1_protein_products

output1=$(grep -c ^ $1_protein_products)
echo "$fbname has $output1 named protein products"
