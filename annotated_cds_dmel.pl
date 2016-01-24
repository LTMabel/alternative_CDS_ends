#!/usr/bin/perl -w

use strict;

my $file = $ARGV[0];

open IN, "./".$file;


my $results;
my %mRNAs;
my $gene_counter;

# get gene transcript hash

while (<IN>) {
  my @temp = split /\t/, $_;
  my $beg = $temp[3];
  my $end = $temp[4];
  my $strand = $temp[6];
  my $desc = $temp[8];

  if ($_ =~ /\tmRNA\t/) {
        $desc =~ /.*Parent\=(FBgn\d+).*\;/;
        my $gene = $1;
        $desc =~ /ID\=(FBtr\d+).*\;/;
        my $transcript = $1;
        $mRNAs{$transcript} = $gene;
  }
}

close(IN);
# get protein ends

print "Got genes"."\n";

open IN, "./dmel-all-no-analysis-r6.07.gff";

while (<IN>) {
  my @temp = split /\t/, $_;
  my $beg = $temp[3];
  my $end = $temp[4];
  my $strand = $temp[6];
  my $desc = $temp[8];

  if ($_ =~ /\tprotein\t/) {
          $desc =~ /.*Derives_from\=(FBtr\d+).*\;/;
          my $transcript = $1;
	  #print $transcript."\n";
          next if (!$transcript);
	  if ($strand eq '+') {
    		$results->{$mRNAs{$transcript}}->{$end} += 1;
  	  } else {
    		$results->{$mRNAs{$transcript}}->{$beg} += 1;
          }
	}       
}

close(IN);

my $counter;
my %unique;

foreach (keys %{$results}) {
  if (keys(%{$results->{$_}}) > 1) {
    next if (exists $unique{$_});
    $counter++;
    print $counter."\t".$_."\t".keys(%{$results->{$_}})."\n";
    $unique{$_} = 1;
  }
}

exit;
