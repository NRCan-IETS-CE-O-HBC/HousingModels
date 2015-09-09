#!/usr/bin/perl    

# This script is used in the Canadian stock GHG study and simply
# starts substitute.pl for GenOpt using two parameters:
#   1: Name of the file that contains the choice file name (used to be GenOpt-picked-these-choices.GO-tmp)
#   2: The prefix to use to run substitute.pl (depends on Windows or Linux use)
 
use warnings;
use strict;
use File::Basename;
use Cwd;

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

# Create a log file for this script
my $master_path = getcwd(); 
my $LogFile = "$master_path/Start-SubstitutePL-log.txt"; 

open(LOG, ">".$LogFile) or fatalerror("Could not open ".$LogFile."\n"); 

# dump help text, if no argument given
if (!@ARGV){
  print LOG $Help_msg."\n";
  die;
}

my($filename, $dir, $ext) = fileparse($ARGV[0]);

# Open first command line parameter file name to extract name of choice file to run
open ( GENOPTGENFILE, $ARGV[0]) or fatalerror("Could not read $ARGV[0]!\n");

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
      print LOG "Choice file name is: ".$choiceFileName."\n";
	}
  }
}
close ( GENOPTGENFILE );

#print LOG "The current directory is: ".$master_path."\n";

my $command = $ARGV[1]." ../substitute.pl -c ./GenericHome-GHG/choices/$choiceFileName -o ../options-generic-GHG.options -b ./GenericHome-GHG -vv";

#print LOG "The command is: ".$command."\n";

system ( $command );

close ( LOG );
