#!/home/martink/bin/perl
#RLW2011/2015
#edits to support ncbi blast+ (2.2.28) - see comments

use strict;
use FindBin;
#use lib "$FindBin::Bin/../lib";
#use lib "/Users/rwarren/perl5/lib/perl5/";
use Bio::SearchIO;
use Getopt::Std;
use vars qw($opt_c $opt_d $opt_i $opt_o $opt_a);
getopts('c:d:i:o:a:');


my $version = "[v1.3]";
my ($id_cutoff,$ignore_restrictions) = (0,0);
if(! $opt_c || ! $opt_d || ! $opt_i){
   print "Usage: $0 $version\n";
   print "-c <blast config file>\n";
   print "-d <database sequences file>\n";
   print "-i <query sequences file>\n";
   print "-a <ignore blast alignment restrictions 1=yes/0=no (default=$ignore_restrictions)>\n";
   die "-o <sequence id cutoff (default=$id_cutoff)>\n";
}

my $configFile = $opt_c;
my $database = $opt_d;
my $query = $opt_i;
$ignore_restrictions = $opt_a;
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

my $command;

$config->{'alignments'} = "" if($ignore_restrictions);###ADDED 8OCT2015

if($config->{'program'}=~/2\.2\.2[89]/){#blast+
   $command = "$config->{'program'} $config->{'options'} $config->{'alignments'} -db $database -query $query";
}else{
   $command = "$config->{'program'} $config->{'options'} $config->{'alignments'} -d $database -i $query";
}

print "Running: $command\n";

if(! -e $config->{'program'}){
   die "Can't find executable $config->{'program'} as indicated in $configFile -- fatal.\n";
}

my $fh;
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
      my $qacc = $result->query_accession;
      my $qdesc = $result->query_description;
      $qname = $qdesc if($qname=~/^Query\_/i);#blast+

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
        #print "$qname,$qacc,$qdesc\n";
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
