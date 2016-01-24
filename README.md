# alternative_CDS_ends
Perl script for counting alternative C-terminal ends of Drosophila protein isoforms based on GFF file. 

It works on a very simple principle of iterating through CDS forms and storing them in hash of hash where one key is the gene and the other key is the position of the C-terminal end of the gene's CDS. Like this naturally all CDS forms with the same end generate only one second level hash entry per gene. Finally the script counts the numbers of ends and prints all genes that have at least 2 CDS isoforms.

Pre-requisites: You need bare bones Perl. All the script does is simple text parsing, no fancy modules are needed. An up-to-date .gff file containing genome annotations respecting established GFF conventions.

Usage: On the command line type:

./annotated_cds_dmel.pl dmel-all-no-analysis-r6.07.gff
press enter.

Output: While procesing the file the script will print:

./annotated_cds_dmel.pl dmel-all-no-analysis-r6.07.gff
Got genes

1	FBgn0020503	3

2	FBgn0031885	2

3	FBgn0039673	2

.
.
.

1402	FBgn0033063	2

1403	FBgn0262985	2

Thus the answer is: 1403 Drosophila genes have alternative C-termini.
