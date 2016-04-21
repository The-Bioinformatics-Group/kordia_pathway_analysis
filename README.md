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

Added a [Wiki](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/wiki)

-Oskar
###April 13, 2016

I have run into issues with the RNA comparison between the two genomes. Pathway Tools makes it easy to list tRNA genes
but none of them have been successfully named by PROKKA, they're all called "PROKKA_01861" or something similar. I could
manually copy and paste each sequence and compare them to each other.  
The other option is that I use grep and find all RNA genes (notice that I'm talking about tRNA and RNA on purpose) that have 
been named by PROKKA and compare them to each other. The issue with that is that that data would not apply to the tRNA genes 
in Pathway Tools.  
I'm not sure how to proceed.

I've also expanded the named gene counting script to count the number of named genes they have in common and how many unique 
named genes they have respectively. I also added some usability features to the script, if you run it without any input it
prints a message which tells how to use it and also tells you about the output. But here's some stats on our current Genbank
files.

Genbank File | Unique Named genes | Total Number of Named Genes | Total Number of Genes
--- | --- | --- | ---
K. algicida OT-1 PROKKA | 358 | 1528 | 4478
K. sp PROKKA | 454 | 1624 | 4749

-Oskar

###April 14, 2016

Created a folder for lists of genes, the genbank folder was getting cluttered.
Also moved the images of the hightlighted pathways from Pathway Tools in the
gene lists folder.

##The following is an unorganized list of observations made from the unique named genes in our Kordia. It is intended as a short overview of potentially interesting genes.

There is a predicted L-dopachrome pathway. PROKKA has identified a gene (melC2)
 and inferred the rest of the pathway based on the presence of that gene. It 
starts out with L-tyrosine and through the action of the enzyme tyrosinase it 
produces dopaquinone, and through a spontaneously occurring reaction produces 
leucodopachrome and finally produces dopachrome and L-dopa in the last step which
 yet again is a reaction that can occur spontaneously.

There's also a pathway for carotenoids that probably at least bares resemblance 
to a similar pathway that is quite possibly found in K. algicida as well because
 K. algicida has been shown to produce yellow pigmented colonies according to 
[this article](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3147531/). The genes 
in K. sp. for that reaction are called carA2 and crtI and the pathway goes from
 geranylgeranyl diphosphate to all-trans-lycopene.

The gene chiD is related to the formation of chitotriose which is an antioxidant, 
[this article](http://www.ncbi.nlm.nih.gov/pubmed/12951480) has more information
about chitotriose.

The aromatic compound anthranilate is produced with the help of the gene carC, 
anthranilate is an acid (anthranilic acid) that has several different industrial 
uses according to [wikipedia](https://en.wikipedia.org/wiki/Anthranilic_acid).

-Oskar

### April 18, 2016

Changed "comm -3 common_genes $1_genes_sorted > $1_unique_genes" to 
"comm -3 common_genes $1_genes_sorted | cut -c 2- > $1_unique_genes" 
in order to remove a tab space that got inserted by comm.

Updated the README files for the "genbank_files", "FASTA_files", "BASys", 
"gene_lists", "mauve_analysis" and "scripts" folders. 

I looked closer into the melC2 gene and created a folder for interesting 
genes that we investigate closer. I will put files there with specific data
such as AA sequences that I used in my analyses.

I did a protein BLAST search with the AA sequence for melC2 (the AA sequence 
is in the file for melC2 in the "investigated_genes" folder) to see what other 
proteins it matched, and one common match was "hemocyanin" in various organisms. 
Hemocyanin is an equivalent to hemoglobin, i.e it carries oxygen molecules. It is 
commonly found in molluscs and some arthropods. 

The top 5 BLAST hits are hypothetical proteins, and the 6th hit is a tyrosinase in [Thaumarchaeota archaeon MY3](http://www.ncbi.nlm.nih.gov/protein/937516891?report=genbank&log$=protalign&blast_rank=6&RID=H9JU752801R).
Tyrosinases 

-Oskar

###April 19, 2016

Created a genus database for PROKKA with the prokka-genbank_to_fasta_db script with K. 
algicida and K. jejudonensis as representatives for the genus, and used the new 
database in a new PROKKA annotation of our K. sp genome. I called the [new genbank file](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/upload/master/genbank_files/PROKKA_K-sp_V2.gbk)
"PROKKA_K-sp_V2". There is a looming question if the data in this analysis is 
particularly useful due to possible overfitting of data. I will nontheless describe the 
results here and sleep on it to see if I get any good ideas.

To preface the following tables I am going to quickly explain how these numbers were 
generated because this can seem unintuitive at first. I used the script [find_genes.sh](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/scripts/find_genes.sh)
and it finds all named genes in each of the two genbank files that are used as input.
It then compiles one list of gene names for each input file and sorts the genes 
alphabetically. Then it compares the first list to the second and every gene from 
file 1 that is not found in file 2 is put in its' own list of unique genes, and vice versa.

The first table is a comparison of the first PROKKA annotated K. sp genome and PROKKA
annotated K. algicida OT-1 genome. The new genbank file, PROKKA_K-sp_V2.gbk, was 
compared to PROKKA_KalgicidaOT1.gbk in the second table, and it was compared to 
PROKKA_K-sp.gbk in the third table.  

The numbers in the first and second table show that the new annotation of our Kordia has
 more unique named genes (490 vs 454), and more named genes than the previous one 
(1737 vs 1624).

In the second table it is evident that there are more named genes in common than in the
 first table (1170 vs 1247). This is to be expected since part of the analysis was 
enhanced by using the "--usegenus --genus Kordia" flags in PROKKA, but also because I 
added a database based on the genbank files for K. jejudinensis and K. algicida OT-1 to
 the internal database folder that PROKKA uses in its' annotation process. These two
changes should result in an increased identification of named genes.

The third table shows that the new annotation of our Kordia found 418 unique named genes and a 
total of 170 new named genes. This begs the question why there are more new unique genes
than the total of new genes. This is part of the question whether data has been overfitted  
or not.

Genbank File | Unique Named genes | Total Number of Named Genes | Total Number of Genes | Genes in Common
--- | --- | --- | --- | ---
K. algicida OT-1 PROKKA | 358 | 1528 | 4478 | 1170
K. sp PROKKA | 454 | 1624 | 4749 | 1170

Genbank File | Unique Named genes | Total Number of Named Genes | Total Number of Genes | Genes in Common
--- | --- | --- | --- | ---
K. algicida OT-1 PROKKA | 281 | 1528 | 4478 | 1247
K. sp PROKKA V2 | 490 | 1737 | 4749 | 1247

Genbank File | Unique Named genes | Total Number of Named Genes | Total Number of Genes | Genes in Common
--- | --- | --- | --- | ---
K. sp PROKKA | 305 | 1624 | 4749 | 1319
K. sp PROKKA V2 | 418 | 1737 | 4749 | 1319

I am inclined to believe that the new data is useful, but I need to do some more reading first.

Here's the command I used to run the PROKKA analysis: "prokka 'kordia_pathway_analysis/FASTA_files/combined-revcomp-unitig-1-2.fasta' --outdir foldername --cpus 4 --usegenus --genus Kordia"

I also added new files to the genbank_files folder, gene_lists folder and a script to the script folder. And I removed the "common_genes" file from the root folder, you need to create it yourself if you want one of your own, it doesn't make sense to keep it now that there are several different genbank files and hence several different comparisons that can result in a common_genes list.

-Oskar

###April 20, 2016

I re-ran the PROKKA analyses from yesterday and noticed that some numbers had changed. I began investigating and noticed that I had not used the proper Kordia genus database yesterday. So I recreated it from scratch and ran the PROKKA annotation for our Kordia genome again. I have changed the tables to reflect the new analyses.

Genbank File | Unique Named Genes | Total Number of Named Genes | Total Number of Genes | Genes in Common
--- | --- | --- | --- | ---
K. algicida OT-1 PROKKA | 358 | 1528 | 4478 | 1170
K. sp PROKKA | 454 | 1624 | 4749 | 1170

Genbank File | Unique Named Genes | Total Number of Named Genes | Total Number of Genes | Genes in Common
--- | --- | --- | --- | ---
K. algicida OT-1 PROKKA | 370 | 1528 | 4478 | 1158
K. sp PROKKA V2 | 537 | 1695 | 4749 | 1158

Genbank File | Unique Named Genes | Total Number of Named Genes | Total Number of Genes | Genes in Common
--- | --- | --- | --- | ---
K. sp PROKKA | 22 | 1624 | 4749 | 1602
K. sp PROKKA V2 | 93 | 1695 | 4749 | 1602

Unfortunately I do not remember how I created the previous genus database, as far as I can remember I used the same input files yesterday and today when I created the genus databases, but somehow the results differ. I have both databases and the one I'm using now is larger than the previous one, and since I have veryfied that the one I'm using now was made with correct input files, I'm certain that it is the one we should be using.

And for the record, I annotated [this](http://www.ncbi.nlm.nih.gov/nuccore/820797914?report=fasta) K. jejudonensis FASTA file to create the K. jejudonensis [genbank file](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/genbank_files/PROKKA_Kjejudonensis.gbk) that I used in the prokka-genbank_to_fasta_db script together with the K. algicida [genbank file](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/genbank_files/PROKKA_KalgicidaOT1.gbk) that I had already created with PROKKA earlier.  
I then followed these steps to create the database:

% prokka-genbank_to_fasta_db PROKKA_Kjejudonensis.gbk PROKKA_Kalgicida_OT1.gbk > Kordia.faa  
% cdhit -i Kordia.faa -o Kordia -T 0 -M 0 -g 1 -s 0.8 -c 0.9  
% rm -fv Kordia.faa Kordia.clstr  
% makeblastdb -dbtype prot -in Kordia  
% mv Kordia.p* /usr/local/bin/prokka/db/genus/

To initialize the database, I ran "prokka --setupdb" before I finally ran "prokka combined-revcomp-unitig-1-2.fasta --outdir ksp --usegenus --genus Kordia"

-Oskar