# Kordia Pathway Analysis

This is the repository for all files and updates relevant to the Kordia sp. pathway analysis project. 

###April 7, 2016.
Unitig_1 was reverse complemented using the reversecomplement.r script and the resulting file was used in a comparison with the K. algicida OT 1 genome in Mauve. To get a quick overview of the results there are two screenshots of the results in the Mauve folder.

The same FASTA file was submitted to BASys for annotation.

-Oskar

###April 8, 2016
BASys annotation of reverse complemented FASTA file from yesterday complete.
The settings that were used are "Gram Stain: Negative" and "Contig is: Circular". Everything else was set to default.

[Link to the BASys analysis results](https://www.basys.ca/server3/basys/cache/d03d65baad28f43284c9c84b7586acf9/index.html)

A Pathway Tools database (PGDB) was created and compared to the Kordia algicida OT 1 PGDB from Pathway Tools and the results are as follows:

Organism | Pathways | Protein Genes | RNA Genes | Size (bp)
-------- | -------- | ------------- | --------- | --------
Kordia algicida | 200 | 4465 | 64 | 5,033,129
Kordia sp. | 149 | 1713 | 0 | 5,493,758

It's safe to say that something is missing from the current genbank file for our Kordia.

The Kordia algicida OT 1 [FASTA genome](http://www.ncbi.nlm.nih.gov/nuccore/NZ_DS544873.1) is linear and for that reason I have submitted a BASys analysis of the reverse complement unitig 1 + unitig 2 FASTA file with the "Contig is:" setting set to "Negative" to see if that changes the results.

And for good measure I have also submitted the 
Kordia algicida OT 1 genome to BASys to see if BASys identifies the same 
number of genes as the PGDB in Pathway Tools has.

Afternoon: I annotated the reverse complemented FASTA file with PROKKA and 
the results are very promising as shown in the table below. A bug in PROKKA 
caused the first analysis to fail because I didn't get the genbank file which 
was the whole purpose. I had to change ">1|quiver" in the FASTA file to ">1" 
because having a pipe "|" character in the name somehow causes an issue, this 
has more info: [Bug discussion](https://github.com/tseemann/prokka/issues/127)

Organism | Pathways | Protein Genes | RNA Genes | Size (bp)
-------- | -------- | ------------- | --------- | --------
Kordia algicida | 200 | 4465 | 64 | 5,033,129
Kordia sp. | 224 | 4686 | 63 | 5,493,758

Given the larger genome it makes sense that our Kordia has more protein genes 
and thus more pathways. 

I have placed the PROKKA analysis files in /nobackup/data9/oskar/prokka

-Oskar

###April 11, 2016

The BASys annotation results from the runs that were started last friday
 with the reverse complemented contig_1 + contig_2 genome set to 
linear instead of circular, and the Kordia algicida OT 1 genome manually 
downloaded from RefSeq is in.

Here's some of the statistics of the new databases.

Organism | Pathways | Protein Genes | RNA Genes | Size (bp)
-------- | -------- | ------------- | --------- | --------
Kordia algicida*  | 200 | 4465 | 64 | 5,033,129
Kordia sp. linear** | 149 | 4795 | 0 | 5,493,758
Kordia algicida*** | 148 | 1631 | 0 | 5,033,129 
Kordia sp. PROKKA | 224 | 4686 | 63 | 5,493,758

*Kordia algicida OT 1 PGDB downloaded through Pathway Tools.

**Our Kordia annotated with BASys

***Kordia algicida OT 1 genome annotated by BASys.

In this case it is obvious that BASys is not performing as expected, it fails
to properly annotate the RefSeq genome of Kordia algicida OT 1.

Going forward I propose that we analyze the PROKKA annotated genome PGDB and
base any further research on that. We can compare it to the Kordia algicida
PGDB that was downloaded using Pathway Tools, and we should keep in mind that
this is all automatic annotation and the identified pathways are not necessarily
actually present in the bacteria.

-Oskar

###April 12, 2016

Added a script and genbank-files that were used to create a list of common 
named genes between K. algicida and K. sp. 

The K. algicida from genbank (Accession number NZ_DS544873.1) had only 35 
named genes, the rest were hypothetical genes. Our Kordia, annotated with 
PROKKA, has 1624 named genes. For this reason I decided to annotate the 
K. algicida OT 1 genome with PROKKA and that resulted in 1528 named gened. 
They have a total of 1170 named genes in common. The table below clarifies 
this.

gbk-file | Total Genes | Named genes | Common with our Kordia
--- | --- | --- | ---
K. algicida OT 1 from Genbank | 4578 | 35 | 26
K. algicida OT 1 from PROKKA | 4478 | 1528 | 1170
K. sp from PROKKA | 4749 | 1624 | -

I created a script called 
"find_genes.sh" that I used to find all named genes and compare how many of 
them were common between the two gbk-files. I put it in the scripts folder. 
Take a look at it before you use it because it has some quirks and isn't user 
friendly yet; but in short, you need to run 
"bash find_genes.sh link/to/file1 link/to/file2" to use it.

I have also made a list of common named genes (called "common_genes"
 and it is in the root folder) and used it to create two images to highlight 
the common genes and pathways in the K. algicida OT 1 and K. sp. pathway 
overlays in Pathway Tools. The images are called "common_genes_X.png" and are 
in the root folder. Red lines denote common genes.

If you compare the images you'll notice that some pathways look identical and 
seemingly should have common genes highlighted, but some pathways have e.g 
more genes associated with them, there are various other reasons for why there
is a connection but too many to describe them here.

-Oskar
