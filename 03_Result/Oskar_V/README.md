﻿# Kordia Pathway Analysis

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

###April 21, 2016

Added a script to print and count the number of unique genes in a genbank file and
renamed the "find_genes.sh" script to "find_unique_genes.sh" to better reflect its
function. I also added a script that finds all protein products in a genbank file,
it deletes all instances of "hypothetical protein", it also counts the number of
named genes.

-Oskar

###April 29, 2016

I spent the past Tuesday to Thursday at the 15th CeMEB assembly at Sven Lovéns
center for marine science. There were seminaries and lectures every day about
topics such as the marine microbiome, current research topics at the marine
biology department at the University of Gothenburg, ideas for the development
of future CeMEB assemblies amongst others. 

The Kordia pathway analysis project was discussed and it was decided that I will
continue the research by learning more about how to optimize PROKKA by using
various databases and other settings that are available. I will also look at 
other annotation methods and compare them with PROKKA.

I started off with [RAST](http://rast.nmpdr.org/) and it generated a genbankfile
that had no entries for gene names, but I ran it through Pathway Tools and created
a pathway database anyways. I took a look at the pathway overview and found an [EC
number](http://enzyme.expasy.org/EC/6.3.1.9) for trypanothione synthetase.  
I did a quick search in the other Kordia genbank files but I did not find the same
EC number. The enzyme is responsible for the production of trypanothione which is
normally found in trypanosomatids, e.g in some Leishmania species. This is interesting
but to my understanding is not to be expected and is likely a false positive. The 
genbank file is in the genbank files folder.

I also tried to annotate using [KAAS](http://www.genome.jp/kegg/kaas/) but it didn't
seem to work properly, I didn't get any useful output. 

I've downloaded [AGeS](http://www.bhsai.org/ages.html) and will take a look at it
next week.

I've already tried [BASys](https://www.basys.ca/) a few weeks ago but it didn't 
produce anything that made sense, Alvar did though, but he hadn't joined the 
two contigs in his FASTA file. I've thought about taking a look at the genbank 
files from that annotation to see what it found. 

I am planning to take a look at [Sma3s](http://www.bioinfocabd.upo.es/node/11) and
I have downloaded a bacterial UniProt database that I will add to PROKKA and 
hopefully improve the annotation results. 

-Oskar

###May 2, 2016

New analyses have been run with PROKKA, this time I have managed to add various databases and I have 
also added [Barrnap](https://github.com/tseemann/barrnap) which is a tool for rRNA discovery. There 
is a setting that enables search for ncRNA which I’ve tried as well. I will detail my findings below, 
but in short, the annotation results have returned more named genes than with the standard settings and databases.

PROKKA uses HMMs and the user can add their own desired HMM databases, I downloaded a 
[Pfam](ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam29.0/Pfam-A.hmm.gz) database and added it to PROKKA. 
In order to add a new HMM database, it needs to be prepared with “hmmpress database.hmm”, and the files 
need to be placed in ~/prokka/db/hmm/. In order for PROKKA to properly recognize the new HMM database, 
the user needs to finally run “prokka --setupdb” to initialize it. To verify that it was successful you 
can run “prokka --listdb” to see if the database is listed with the others. I also added a 
[TIGRFAM](ftp://ftp.jcvi.org/pub/data/TIGRFAMs/14.0_Release/TIGRFAMs_14.0_HMM.tar.gz) database, I 
modified it slightly because it creates over 4000 individuall hmm files when extracted, so I ran 
“cat TIGR* > TIGRFAM.hmm” to add all of them to one single hmm database as opposed to 4000+ individual 
ones. I presume that it would be detrimental to the performance to have PROKKA go through thousands of hmm databases instead of just a handful.

These results are from the last analysis I ran when I had added all databases and tested the settings 
that I describe in this entry, I ran with this command: prokka combined-revcomp-unitig-1-2.fasta --outdir KspPfamTIG --prefix KspPfamTIG --genus Kordia --species sp --strain PfamTIGHMM --rfam  
N.B. I use the “--genus” flag but as long as I don’t use the “--usegenus” flag it doesn’t actually 
use the genus databases, it only puts the name in the output files.

Genbank File | Unique Named Genes | Total Number of Named Genes | Total Number of Genes | Genes in Common | rRNA | ncRNA
--- | --- | --- | --- | --- | --- | ---
KspPfamTIG | 331 | 1798 | 4762 | 1470 | 9 | 6
K. sp PROKKA | 154 | 1624 | 4749 | 1470 | 0 | 0  
Since there are two new HMM databases the number of named- and named unique genes have shot up compared with the basic PROKKA installation.

The addition of [Barrnap](https://github.com/tseemann/barrnap) enabled identification of rRNA sequences. When Barrnap 
is added PROKKA finds 9 rRNA sequences. There is another tool that PROKKA can use to identify rRNA sequences called 
RNAmmer, but I have yet to see how it performs when added to PROKKA. I plan to take a look at it tomorrow.

It is also possible to identify ncRNA with the --rfam flag, it found 6 ncRNAs and it significantly adds to the time it takes to complete the annotation. Although PROKKA is quite fast to begin with, 
needing around 3 minutes to complete, adding the --rfam flag adds ~3 minutes, effectively doubling the total time. 

Another flag that I tried is the --metagenome flag, it is intended for highly fragmented genomes and might not 
be very suitable for our purposes, but just for the sake of it I tried it and it found one less gene in total, 
but three more uniquely named genes, 
the table below contains the rest of the details.

Genbank File | Unique Named Genes | Total Number of Named Genes | Total Number of Genes | Genes in Common | rRNA | ncRNA
--- | --- | --- | --- | --- | --- | ---
KspPfamTIGmeta | 334 | 1797 | 4762 | 1463 | 9 | 6
K. sp PROKKA | 161 | 1624 | 4749 | 1463 | 0 | 0
 
EC Numbers in Genbank files have info on genes sometimes, and always has information about proteins. This could be exploited with some clever coding if needed. 

One web based method that I tried is the [RAST](http://rast.nmpdr.org/) server and it seems pretty 
useful. It definitely has some benefits over PROKKA, but at the same time some drawbacks. There is a genbank file 
output available, although no entries for gene names, and gene names are nowhere to be found on the analysis results 
page on the website so far. When starting a job there is no obvious setting that would include gene names in the 
output. But there is a lot of information about pathways for instance, it is integrated with KEGG and I have 
uploaded a picture of the P450 related enzymes it found to the folder “RAST”. In the image, the results show how many 
EC’s it found out of the total known number of EC’s. The green boxes signify clickable EC’s that lead to more 
information about the particular pathway. It’s possible to compare ones results with pathways from other organisms 
in the menus above the pathway image. And just because there are more known pathways it doesn't mean that they exist in
our Kordia.

Last, but not least, I created a Frankenstein genus database out of several different genbank files from bacteria that are closely 
related to our Kordia, but the results were terrible. The intended use of the function is if you have a couple of 
annotated genomes from the same genus that you want to use as a database during the annotation process, but the way I did it isn’t how it’s meant to be used so the results shouldn’t be surprising. 

-Oskar

###May 4, 2016

Running PROKKA with RNAmmer for rRNA identification does not lead to a change 
in the number of named genes, but it does lead to a slightly different prediction
of where the rRNA begins. The table below illustrates this in detail. I suppose
this is a matter of manual annotation. With n=1 it seems like there isn't much
difference between barrnap and RNAmmer, Torsten Seeman, the man who wrote PROKKA
wrote in the [readme](https://github.com/tseemann/prokka/blob/master/README.md)
 that RNAmmer is slower but slightly more accurate, and he is the one who wrote barrnap too.

N.B barrnap does not report strand, the strand data comes from RNAmmer.

Barrnap DNA Coordinates | RNAmmer DNA Coordinates | rRNA | Strand
--- | --- | --- | ---
1082961 | 1082960 | 5S ribosomal RNA | +
3916380 | 3916379 | 5S ribosomal RNA | -
2503316 | 2053315 | 5S ribosomal RNA | -
2503589 | 2503584 | 23S ribosomal RNA | -
3916653 | 3916648 | 23S ribosomal RNA | -
1079973 | 1079967 | 23S ribosomal RNA | +
1077942 | 1077945 | 16S ribosomal RNA | +
2506911 | 2506916 | 16S ribosomal RNA | -
3919975 | 3919980 | 16S ribosomal RNA | -

SignalP, which identifies signal peptides, was added and the [genbank file](https://github.com/The-Bioinformatics-Group/kordia_pathway_analysis/blob/master/genbank_files/PROKKA_K-sp_V3.gbk)
 now has predicted signal peptide CDS entries with predicted cleavage sites.

Just for the sake of it I tried running PROKKA with the output folder on a RAM 
disk and compared it to an HDD, it took ~8 minutes instead of ~10 minutes. Having
PROKKA on a RAM disk would inevitably improve the performance further. From what
I can tell, it seems like the HMM analyses take the longest time, possibly due to
lots of database reading.

May the fourth be with you...

-Oskar

###May 9, 2016

Tried to install AGeS, several dependencies in Perl wouldn't install and I gave
 up. I don't want to risk breaking the system by tinkering too much.

Then I tried to annotate with [Sma3s](http://www.bioinfocabd.upo.es/node/11) and 
it only found one result per FASTA file, I thought it might be a bug but it 
turns out it's a feature. It wants the input file to have several short 
sequences, not one long sequence as ours is. But Prokka (or Prodigal probably)
 produces a .ffn file which is split up into each predicted nucleotide sequence
, so I used that instead and the output includes a file with annotation statistics
which counts the number of sequences, gene names etc, and it identified 246 gene
names. It also found 120 related pathways. Our current pipeline is clearly more
modular given the standardised output files and we also get more gene names etc.

The next tool to test is [PANNZER](http://bioinformatics.oxfordjournals.org/content/early/2015/01/08/bioinformatics.btu851.abstract)
, it uses a set of rather large databases so I am not able to install it on my
 current system. 

 -Oskar

###May 10, 2016

An issue each to install PANNZER and AGeS on the new Albiorix server has been 
created, they will be tested once the new server is up an running in a few 
weeks.

Prokka has a flag called "--proteins" where the user can input a FASTA file of
trusted AA sequences to first annotate from. I haven't tried it until now, so I
downloaded the AA FASTA file for K. algicida OT-1 from biocyc and ran Prokka with
it. It only found a total of 81 gene names with this setting, and after some
comparison of this new genbank file with the K-sp_V3 version I have come up with
some observations.  
To begin with, a fundamental function in Prokka is that it relies upon Prodigal
to predict AA coding sequences, these AA sequences then get compared to other
sequences in e.g a list of trusted annotations as is intended with the 
"--proteins" flag, or in the databases that are placed in 
~/prokka/db/{cm,genus,hmm,kingdom}.

I made a quick comparison of the first mismatch I could find, and the .gbk file
that was created with the --proteins flag suggested _protease b_ where the .gbk
without the --proteins suggested _Dual-action HEIGH metallo-peptidase_. To 
make a better judgement on which could be correct I copied the AA sequence and
did a BLASTp search on UniProt and found both of the sequences. The _protease b_
was the first hit, while the other protein was hit number 17. The first had an
E-value of 5.9e-108 while the other hit had an E-value of 1.8e-39. E-values alone
don't decide which is the correct protein, so I looked even deeper and found [this page](http://pfam.xfam.org/family/PF12388).
It describes the Dual-action HEIGH metallo-peptidase proteins and lo and behold, 
_protease b_ is part of them! If the correct gene is the one that codes for protease b
, the gene name is _prtB_, in which case we'd have 1799 gene names.

This is just me mucking about though, the point I'm trying to make is that we 
can potentially gleam some insights from various sources, the FASTA file with 
AA sequences from K. algicida OT-1 being one. 

-Oskar

###May 23, 2016

Pathway Tools has been updated to version 20.0 and I feel it's time to update and
 summarize the findings so far. I installed the new Pathways Tools version
 to see if there are any changes to our pathway analysis with the new MetaCyc 
database.  
Prokka has been updated with the latest [UniProt Swiss-Prot database](http://bit.ly/1sFlCnE)
published on May 11, 2016 and a new analysis has been run. I realized that I
haven't updated the pathway analysis results from Prokka V3 yet, so here's some
old new information too.

Organism | Pathways | Named genes | Protein Genes | RNA Genes | Size (bp)
-------- | -------- | ----------- | ------------- | --------- | --------
K. sp Prokka | 224 | 1624 | 4686 | 63 | 5,493,758
K. sp Prokka V3 | 216 | 1798 | 4683 | 78 | 5,493,758
K. sp Prokka V4 | 217 | 1798 | 4683 | 78 | 5,493,758

Version 3 and 4 have the exact same genes except for one where they disagree,
V3 puts "rlmb", a gene for an rRNA where V4 puts "trmH_2", a gene for a tRNA.
The old sprot database has two entries for the trmH gene while the new database
has four entries for the trmH gene. It would be interesting to see how the sequence
was aligned to the sprot sequences during the annotation process.

The first time we annotated our Kordia genome with Prokka it was with the vanilla
Prokka installation. It comes with a Uniprot Swiss-Prot database from November
 2015 and a HMM database of unknown origin. The Prokka README does not say where 
the HMM database is from.

On May 2 Prokka was updated with HMM databases from Pfam and TIGRFAM, these 
databases have had the biggest impact on the number of named genes, going from ~1600
to ~1800 named genes. I have also tried various optional tools for rRNA and ncRNA 
identification. The genbank file now includes entries for signal peptide locations. 

I have also tried various other annotations tools to compare with Prokka. The most
useful tool so far is the [RAST](http://rast.nmpdr.org/) server. It produces
a rich output full of information about pathways, reactants, products, predicted
AA sequences and much more. The output folder from my RAST analysis is 400Mb big.

-Oskar

###May 30, 2016

Added a new HMM from [SUPERFAMILY](http://supfam.org/SUPERFAMILY/howto_use_models.html),
 it's necessary to create an account in order to download the database. I ran 
the new database with Prokka and it didn't change the annotation results.

I also tried the "-hmms [x]" flag. The -hmms flag
is used to force Prokka to annotate from the specified HMM first. The only 
viable results came from using "-hmms /usr/local/bin/prokka/db/hmms/HAMAP.hmm".
It increased the number of named genes from 1798 to 1843, but the number of unique
genes increased to 705 which raises the question of which annotation result is more
accurate.

When the genbank file was run in Pathway Tools it resulted in 179 identified pathways,
as opposed to 217 pathways for the previous genbank file. Due to the large number of
unique genes there were several new pathways. In order to analyze the viability of
the results I chose a new pathway at random, found the gene name and ran a BLASTp 
analysis with the AA sequence on UniProt, NCBI and hamap.expasys.org to see what they 
would return. The AA sequence is at the end of this entry. I chose the hamap website 
because I used the hamap HMM database to 
annotate from first, my idea was that I would possibly find the same gene on the 
hamap webserver.

Both UniProt and NCBI's BLASTp returned the K. algicida OT-1 _ABC Transporter_ gene
_yxlF_. Hamap returned the ABC_TRANSPORTER_2 profile.
But then I ran the same AA sequence on the http://myhits.isb-sib.ch/cgi-bin/motif_scan
website and it produces a visual output of the alignment, as well as information on
how much of the sequence that was matched. I ran the analysis with the HAMAP 
profiles and Pfam HMMs databases and the output was a bit more informative
than what was learned from the three previous searches. The following table sums it
up. Keep in mind that the entire predicted AA sequence is 310 AA long. 

Database | pos | Raw Score | N-Score | E-Value | Protein
-------- | --- | --------- | ------- | ------- | -------
HAMAP | 19-254 | 1340 | 13.781 | 3.5E-07 | Vitamin B12 Import ATP-Binding Protein btuD
Pfam | 40-215 | 187.1 | 63.534 | 6.2E-57 | ABC Transporter

Based on this information, the question becomes whether longer sequence coverage 
(Vit B12 gene) or better E-value (ABC Transporter) weighs heavier in the final 
assesment.

AA sequence that was used in the alignment analyses above:

MYNQSKNYITLETILTLQNLSKNYKKVKAVQNLSFTIEKGNVYG  
ILGPNGSGKSTTLGMVLNVVNRTSGNFHWFNGNVAVHDALKRVGAIIERPNFYPYMTA  
YDNLKLVCKIKNVSKDKIDEKLELVGLIDRKDSKFKTFSLGMKQRLAIASALLNDPEI  
LILDEPTNGLDPQGIHQIREIIKEIATQGTTILLASHLLDEVEKVCSHVVILRQGVKI  
YAGRVDEMVASQGFFELKTDKEAELLELLEAHPSFGTVNKEEDIIKAFLTEPLNAADF  
NKAMFAQGIVLSHLVNRKESLEEQFLQLTENQSN

-Oskar

###June 14/15, 2016

UPDATED ON JUNE 15
I've been going through the pathways generated by Pathway Tools, manually looking for interesting 
genes. The following list contains a short description of the genes. 

###Toxins  
**Linamarin/lotaustralin – gene bglX_1 and 2**  
Linamarin breaks down into acetone cyanohydrin 
which is extremely toxic.  
Pubmed: https://www.ncbi.nlm.nih.gov/pubmed/9438470?dopt=Abstract  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=REACTION&object=RXN-5341  
The genes bglX_1 and 2 are also involved in taxiphyllin (as described below), methylumbelliferyl, 
coumarinate, scopolin, neolinustatin, linustatin, they all have varying degrees of relationship to 
hydrogen cyanide)  

**Taxiphyllin/Dhurrin – gene bglX_1 and 2, periplasmic beta glucosidase**  
Commonly found in plants. Breaks down into hydrogen cyanide which is potentially toxic to humans and many other 
organisms.  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=NIL&object=PWY-7089&redirect=T  

**Bacillosamine – gene pglC, a UDP sugar**  
Bacillosamine is a prokaryote specific sugar that is 
related to microbial pathogenicity.  
Pubmed: http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3951908/  
MetaCyc: http://www.metacyc.org/META/NEW-IMAGE?type=REACTION&object=RXN-13269  

**Hypoglycin A/B – gene ggt, a hypoglycine**  
Present in a number of plants, causes hypoglycemia (low blood sugar) and vomiting.  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=REACTION&object=RXN-9157  

**L-canavanine – gene argH, argG**  
L-canavanine is an aminoacid that is closely related to 
L-arginine. Due to this close relationship, some organisms mistakenly incorporate L-canavanine 
into proteins which causes a malformed protein and subsequent toxicity to the host. There is 
evidence linking canavanine to autoimmune diseases in humans. The pathway is reversible from 
L-canavanine to L-canavaninosuccinate which could mean that our Kordia tolerates it, and 
possibly indirectly uses it as a toxin.  
Pubmed, general info: http://www.ncbi.nlm.nih.gov/pubmed/331385  
Pubmed, autoimmune info: http://www.ncbi.nlm.nih.gov/pubmed/16890899  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=PATHWAY&object=PWY-5  

###Pigment  
**Quercetin – gene qdoI, yhhW_1 and 2, a hydroxyflavone**  
Quercetin is a yellow pigment that is naturally found in grapes.  
Has potential anti allergic effects.  
Pubmed: http://www.ncbi.nlm.nih.gov/pubmed/27187333  
MetaCyc: http://www.biocyc.org/BSUB/NEW-IMAGE?type=REACTION&object=QUERCETIN-23-DIOXYGENASE-RXN  

**Thiocyanate – gene glpE_1, 2 and 3**  
Thiocyanate is synthesized from hydrogen cyanide and is 
toxic, although not as toxic as hydrogen cyanide since it is used as medicine in some cases. 
It forms a red pigment when combined with iron ions and blue pigment when combined with cobalt 
ions.  
Wikipedia: https://en.wikipedia.org/wiki/Thiocyanate  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=REACTION&object=THIOSULFATE-SULFURTRANSFERASE-RXN  

**Homogentisate – gene hpd**  
Associated with brown pigment production in Xanthomonas campestris 
as well as in the yeast _Yarrowia lipolytica_.  
Journal article: http://aem.asm.org/content/67/8/3463  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=REACTION&object=4-HYDROXYPHENYLPYRUVATE-DIOXYGENASE-RXN  

###Antibiotics  
**Kanamycin A/B/C/D/X – gene kanE**  
Kanamycin is an aminoglycosidic antibiotic.  
DrugBank: http://www.drugbank.ca/drugs/DB01172  
MetaCyc (only for kanamycin A): http://www.metacyc.org/META/NEW-IMAGE?type=REACTION&object=RXN-13125  

**Novobiocin A – gene novN_1 and 2**  
Novobiocin is an aminocoumarin antibiotic derived from _Streptomyces niveus_.  
Drugbank: http://www.drugbank.ca/drugs/DB01051  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=REACTION&object=RXN-14546  

**Gramicidin S – gene grsB_1-7**  
Active against gram positive and gram negative bacteria. 
Synthesis of gramicidin S seems to be dependent upon the gene grsA, and it does not seem to 
have been identified during the annotation process. The pathway goes both ways and the gene 
could therefore be purely for resistance purposes in case of exposure to gramicidin S.  
Pubmed: http://www.ncbi.nlm.nih.gov/pubmed/26886453  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=PATHWAY&object=PWY-6003  

**Rebeccamycin – gene rebM_1 and 2**  
Antitumoral indolecarbazole, requires gene products that 
depend on genes that haven't been found during the annotation process. See the MetaCyc link 
for a complete list of genes necessary for synthesis of rebeccamycin.  
Pubmed: http://www.ncbi.nlm.nih.gov/pubmed/11983340  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=PATHWAY&object=PWY-6324

###ssRNA  
**Polyribonucleotide nucleotidyltransferase – gene pnp**  
Involved in mRNA degradation.  
UniProt: http://www.uniprot.org/uniprot/P05055  
MetaCyc: http://www.metacyc.org/META/NEW-IMAGE?type=REACTION&object=2.7.7.8-RXN  

###Lactones  
**VAI-1-2, VAI-1, HAI-1, PAI-1-2, PAI-1, AAI-1 – genes quiP_1 and 2**  
These lactones are 
all produced with L-homoserine lactone and some form of -oate as substrate, e.g octanoate. 
These lactones act as quorum quenching molecules and they possibly interact with the lux 
operon to produce bioluminescence. So far, only four lux genes have been annotated, namely 
luxC, luxE, luxQ_1 and luxQ_2. The following links contain more information about the lux 
operon and lactones.  
MicrobeWiki: https://microbewiki.kenyon.edu/index.php/Vibrio_fischeri  
Pubmed: http://www.ncbi.nlm.nih.gov/pubmed/10941779  
Pubmed article about another bacteria with the quip genes mentioned: http://www.ncbi.nlm.nih.gov/pubmed/27042262  
BioCyc: http://www.biocyc.org/gene?orgid=CLON1225176&id=G10TR-3047#tab=RXNS  

###Other  
**Tetrahydrobiopterine (THB) – gene phhA**  
THB is an enzyme responsible 
for conversion of amino acids into catecholamines such as dopamine and 
adrenaline. A lack of THB results in dopamine-responsive dystonia, 
phenylketonuria and other serious diseases. THB is uncommon in bacteria, 
yeast and fungi, but present in every cell in higher animals. Not much 
information is readily available regarding THB in bacteria, here is an 
article about THB in the fungus _Mortierella alpina_: 
http://mic.microbiologyresearch.org/content/journal/micro/10.1099/mic.0.051847-0 
Nih: https://ghr.nlm.nih.gov/gene/GCH1 SolCyc: 
http://solcyc.solgenomics.net/LYCO/NEW-IMAGE?object=TETRA-H-BIOPTERIN  

**Spermidine, spermine, putrescine etc – speG, paiA_1 and 2**  
These polyamines have a multitude of uses in science and in the bacterial cell. They aren't unique, but still interesting since they're so universal for life and have many industrial uses.  
Article: http://onlinelibrary.wiley.com/doi/10.1111/j.1365-2958.2008.06126.x/pdf  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=EC-NUMBER&object=EC-2.3.1.57  

**Chitosan – Gene csxA**  
Chitosan is an antifungal polysaccharide with a rich history of research behind it.  
Pubmed – antifungal properties: http://www.ncbi.nlm.nih.gov/pubmed/27298599  
Pubmed – review article: http://www.ncbi.nlm.nih.gov/pubmed/27196916  

**Bile Acid/Chenodeoxycholate/Cholate – gene cbh**  
Bile, or gall, is a dark green to yellowish brown fluid, produced by the liver of most vertebrates, that aids in the digestion of lipids in the small intestine. Bile also has antibacterial properties, although gram negative bacteria are generally more tolerant of it.  
Article: http://onlinelibrary.wiley.com/doi/10.1016/j.femsre.2004.09.003/pdf  
MetaCyc: http://metacyc.org/META/NEW-IMAGE?type=REACTION&object=RXN-17388  

-Oskar

###June 16, 2016

During the course of this project I have drawn some conclusion and learned a few things about Prokka and bacterial annotation in general. The following list is a short summary of these findings.

**Alternative annotation methods**  
1. Sma3s: It didn't produce many successfully annotated genes  
2. RAST: It has a very rich and potentially useful output, although it didn't produce a single 
gene name, it did however produce an extensive amount of data about protein products, 
EC accession numbers, pathways and much much more  
3. BASyS: It works but doesn't produce useful results when our combined FASTA file is used, it
suddenly finds over 17000 genes which is pure nonsense  
4. KAAS: Didn't produce any output at all  

I tried to run PANNZER and AGeS but couldn't install them. PANNZERs' database was too big 
for my available hard drives and AGeS wouldn't install due to missing dependencies.

**Prokka consists of the following core modules**  
Prodigal: Finds hypothetical genes  
Aragorn: tRNA detection  
BLASTp: Searches FASTA files with amino acid sequences  
Infernal: ncRNA detection  
Cmpress: Required for Infernal  
Hmmpress: Required for HMM database creation  
Hmmscan: Scans HMM databases  
Makeblastdb: Creates BLAST databases  
Tbl2asn: Creates GenBank compliant files  

**In addition to these core modules, it is possible to use the following optional tools:**  
Barrnap - rRNA detection (Fast, less precise)  
RNAmmer - rRNA detection (Slow, more precise)  
SignalP - Signal peptide detection  

**Prokka goes through the following steps in the annotation process:**  
1. Find tRNAs with Aragorn  
2. Find rRNAs (if barrnap or RNAmmer (requires hmmer 2.3.2) is installed)  
3. Find ncRNAs (if flag “--rfam” is used)  
4. Find coding sequences with prodigal  
5. Find signal peptides (If SignalP is installed and if “--gram -/neg” or +/pos is used)  
6. Use genus specific database and use ~/prokka/db/genus/desiredgenus to annotate from,
 contains AA sequences. Requires the flag “--usegenus” and “--genus desiredgenus”  
7. Use user submitted trusted protein FASTA file to annotate from, requires “--protein file.ffn”  
8. Runs BLAST on kingdom specific AA FASTA file  
9. Runs hmmer3 and searches ~/prokka/db/hmm/  
10. Runs tbl2asn to create genbank compliant files  

Prokka has been kept up to date with the latest UniProt sprot database. Hidden Markov Model databases from Pfam, TIGRFAM, SUPERFAMILY have been added for increased annotation results. The addition of the SUPERFAMILY database had no discernible impact on the annotation results.

The most relevant genbank file is the “PROKKA_K-sp_V4.gbk” version.  
The state of Prokka is in my opinion maxed out now with regard to protein- and HMM databases. 1798 out of ~4700 genes have been named as of today, none of the other annotation methods have produced more named genes than Prokka has. But RAST has other potentially useful data and should be looked closer at.  
Due to the lack of well annotated organisms related to our Kordia, the “--proteins” flag, which takes AA sequences of trusted proteins as input, is not very useful.  
I would recommend that you continue to use “--rfam” for ncRNA detection, “--gram” for signal peptide detection (requires SignalP) and either barrnap or rnammer (both require installation) for rRNA detection.  
Other than that, I think it is time to look closer at the data and attempt to experimentally verify the presence of potentially interesting genes. The entry above this one called “June 14/16, 2016”, contains a list of genes that could be of interest in future projects. The genome also needs to be properly sequenced as far as I understand it. 

Regarding Pathway Tools, read the [Wiki](https://github.com/oskarvid/Tutorials/wiki) to learn how to create databases, look at pathway overviews and such. The highlight feature (Overviews - > Show Cellular Overview and then click on Overviews - > Highlight - > Proteins/Pathways/etc) is very useful. It marks e.g every pathway that a specific gene is involved with. The species comparison option, also available in the Overviews - > Highlight menu, is useful as well. There's too much to write about Pathway Tools, the features are at times quirky and buggy, but it is a very useful tool indeed!

-Oskar
