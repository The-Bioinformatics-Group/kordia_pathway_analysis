These lists have been automatically created with the help of the [find_genes.sh](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/scripts/find_genes.sh) script. Please keep in mind that when I refer to the identified genes it is not intended as a definite identification, it is more than likely that they have more genes in common than what we have been able to find, and mistakes are likely to have been made, but given the data this is what we know right now.

The pathways in the common_genes_*.png images were created with Pathway Tools, if you want to recreate the analysis in the images you can follow [this](https://github.com/oskarvid/Tutorials/wiki/How-to-get-an-overview-of-all-pathways-in-a-genome-and-highlight-specific-genes) guide. It is helpful to take a look at the [find_genes.sh](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/scripts/find_genes.sh) script to understand what the gene lists contain. But in short they contain lists of the genes that have been successfully named by PROKKA, as opposed to the hypothetical genes that are called "PROKKA_01864" etc. The [common_genes](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/gene_lists/common_genes) file contains a list of the named genes that are found in both of the Kordia bacteria.

Each of the PROKKA_*_unique_genes files contain named genes that are unique to each bacteria.

The PROKKA_*_genes_sorted files contain the entire list of named genes for each bacteria. The genes have been sorted to be able to create the lists of unique genes.

-Oskar
