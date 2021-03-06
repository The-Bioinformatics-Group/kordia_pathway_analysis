#source("https://bioconductor.org/biocLite.R")
#biocLite("BiocUpgrade")
#biocLite("Biostrings")

library(Biostrings)

setwd("~/kordia_pathway_analysis/")

dna1<-readDNAStringSet("FASTA_files/seq1_16536_16552_circcq_fixed.fasta")

dnarev<-reverseComplement(dna1)

writeXStringSet(dnarev,"FASTA_files/unitig1revcomp.fasta",append=FALSE)

dna2 <- readDNAStringSet("FASTA_files/unitig_2_circ_asof_may_2015.fasta")

writeXStringSet(dnarev,"FASTA_files/combined-revcomp-unitig-1-2.fasta",append=FALSE)

## You need to manually add ~100 N at the end of combined-unitig-1-2.fasta before you proceed and
## the next DNA sequence to be appended still has ">1|quiver" on top of it, you need to manually remove it.

writeXStringSet(dna2,"FASTA_files/combined-revcomp-unitig-1-2.fasta",append=TRUE)
