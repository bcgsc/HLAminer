#!/home/martink/bin/perl510
#RLW2011

use strict;
use FindBin;
#use lib "$FindBin::Bin/../lib";
use Bio::SearchIO;
#require "getopts.pl";
use Getopt::Std;
use vars qw($opt_c $opt_d $opt_i $opt_o);
#&Getopts('c:d:i:o:');
getopts('c:d:i:o:');
my $id_cutoff = 0;
if(! $opt_c || ! $opt_d || ! $opt_i){
   print "Usage: $0\n";
   print "-c <blast config file>\n";
   print "-d <database sequences file>\n";
   print "-i <query sequences file>\n";
   die "-o <sequence id cutoff (default=0)>\n";
}

my $configFile = $opt_c;
my $database = $opt_d;
my $query = $opt_i;
$id_cutoff = $opt_o;

if(! -e $configFile){
   die "File $configFile doesn't exist -- fatal.\n";
}

if(! -e $database){
   die "File $database doesn't exist -- fatal.\n";
}

if(! -e $query){
   die "File $query doesn't exist -- fatal.\n";
}


my $config;
open(IN,$configFile) || die "Can't open $configFile -- fatal.\n";
while(<IN>){
   chomp;
   my @a=split(/\:/);
   $config->{$a[0]}=$a[1];
}
close IN;

my $fh;
my $command = "$config->{'program'} $config->{'options'} -d $database -i $query";

if(! -e $config->{'program'}){
   die "Can't find executable $config->{'program'} as indicated in $configFile -- fatal.\n";
}
 
open $fh,"$command |" || die("cannot run $command: $!\n");
 
my $in  = Bio::SearchIO->new(-format => 'blastxml', -fh => $fh);

eval{
while( my $result = $in->next_result ) {
  ## $result is a Bio::Search::Result::ResultI compliant object
  while( my $hit = $result->next_hit ) {
    ## $hit is a Bio::Search::Hit::HitI compliant object
    while( my $hsp = $hit->next_hsp ) {
      ## $hsp is a Bio::Search::HSP::HSPI compliant object
      my $direct;

      my $identity = 0;
      my $qname = $result->query_name;
      my $sname = $hit->name;
      $sname =~ s/>//;
      my $qlen = $result->query_length;

      if(! $qlen){
         $identity = -1;
      }else{
         $identity = ($hsp->num_identical / $qlen) * 100;
      }

      if ($identity >= $id_cutoff)
      {

        if($hsp->query->strand == -1 ){
             $direct="-";
        }else{
             $direct="+";
        }
        my $sbjct_length = $hit->length;
        $sbjct_length=~ s/\,//g;

        printf "%2.2f^%s^%s^%d^%d^%d^%s^%d^%d^%d^%2.2f^%s^%d^%d^%2.2f\n",
            ($identity,
            $direct,
            $qname,
            $qlen,
            $hsp->query->start,
            $hsp->query->end,
            $sname,
            $hit->length,
            $hsp->hit->start,
            $hsp->hit->end,
            $hsp->percent_identity,
            $hsp->evalue,
            $hsp->num_identical,
            $hsp->score,
            $hsp->bits);
      }
    }  
  }
}
};
if($@){
   die "Something went wrong running $0: $@ -- fatal.\n";
}
exit;
