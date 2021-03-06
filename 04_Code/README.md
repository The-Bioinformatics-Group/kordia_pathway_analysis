The [find_genes.sh](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/scripts/find_genes.sh) script is used to find named genes in genbank files. Please take a look at it to properly understand it before you use it.  
In short, it takes two .gbk-files as input and extracts gene names and puts them in a list. It also compares the created lists and creates two new lists of gene names that are unique for each genbank file. One caveat with the script is that if your genbank file happens to have two genes that are called i.e "marA1" it will remove the second gene, even though it is unique and a valid gene. The reason the script does this is because in some genbank files, every instance of "/gene=" is duplicated which is why every duplicate is removed automatically. There is a out-commented code example in the script that you can use if you want to make sure that your specific genbank file does not happen to have two valid instances of the same gene name that would otherwise get removed.

[reversecomplement.r](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/scripts/reversecomplement.r) was used to make a [reverse complement](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/FASTA_files/unitig1revcomp.fasta) of [unitig 1](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/FASTA_files/seq1_16536_16552_circcq_fixed.fasta). It depends on Biostrings from Bioconductor. 

-Oskar

###April 19, 2016

Added prokka-genbank_to_fasta_db script

-Oskar

###April 21, 2016

Added a script to print and count the number of unique genes in a genbank file and 
renamed the "find_genes.sh" script to "find_unique_genes.sh" to better reflect its
function. I also added a script that finds all protein products in a genbank file,
it deletes all instances of "hypothetical protein", it also counts the number of 
named genes.

##April 29, 2016

Edited the "find_protein_products.sh" script and added "sort" to the end of the 
grep command to sort the lines so as to be able to use the "comm" command on the
output files.

-Oskar

###May 9, 2016

Edited find_unique_genes.sh and find_protein_products.sh and changed the output
line to "X _named_ genes/proteins" as opposed to "X genes" because the script
does not count the total number of genes, only the number of _named_ genes/proteins.
