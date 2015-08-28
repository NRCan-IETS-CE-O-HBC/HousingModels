#!/usr/bin/perl    

# This script is used in the Canadian stock GHG study and simply
# starts substitute.pl using two parameters:
#   1: Name of the file that contains the choice file name (usually GenOpt-picked-these-choices.GO-tmp)
#   2: the prefix to use to run substitute.pl (depends on Windows or Linux use)
 
use warnings;
use strict;

#--------------------------------------------
# Help text. Dumped if no arguments supplied.
#--------------------------------------------
my $Help_msg = "

 start-substitute.pl: 
 
 This script searches through the supplied command line argument file
 and creates one choice file per row in the supplied csv file. 
 
 use: ./start-substitute.pl param1 param2
 
 where: param1 = GenOpt-picked-these-choices.GO-tmp
        param2 = perl  for Windows or ./ for Linux
		
";

# dump help text, if no argument given
if (!@ARGV){
  print $Help_msg;
  die;
}

# Open first command line parameter file name to extract name of choice file to run
open ( GENOPTGENFILE, $ARGV[0]) or fatalerror("Could not read $ARGV[0]!");

my $choiceFileName;
my $linecount;
while ( my $line = <GENOPTGENFILE> ){
  $line =~ s/\!.*$//g; 
  $line =~ s/\s*//g;
  $linecount++;
  if ( $line ) {
    my ($attribute, $value) = split /:/, $line;
	if ($attribute =~ "Opt-ChoiceFileNames" ) {
	  $choiceFileName = $value;
	}
  }
}
close ( GENOPTGENFILE );

my $command = $ARGV[1]." substitute.pl -c GenericHome-GHG/choices/".$choiceFileName." -o options-generic-GHG.options -b GenericHome-GHG -vv";

system($command);
