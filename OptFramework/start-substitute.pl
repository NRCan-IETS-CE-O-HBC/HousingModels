#!/usr/bin/perl    

# This script is used in the Canadian stock GHG study and simply
# starts substitute.pl for GenOpt using two parameters:
#   1: Name of the file that contains the choice file name (used to be GenOpt-picked-these-choices.GO-tmp)
#   2: The prefix to use to run substitute.pl (depends on Windows or Linux use)
 
use warnings;
use strict;
use File::Basename;
use Cwd;
use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove); 

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

my $ChoiceFileDir = "$master_path/../GenericHome-GHG/choices"; 

open(LOG, ">".$LogFile) or fatalerror("Could not open ".$LogFile."\n"); 


# dump help text, if no argument given
if (!@ARGV){
  print $Help_msg."\n";		# Prnt to screen!
  print LOG $Help_msg."\n";	# Prnt to log
  die;
}

my($filename, $dir, $ext) = fileparse($ARGV[0]);

# Open first command line parameter file name to extract name of choice file to run
open ( GENOPTGENFILE, $ARGV[0]) or fatalerror("Could not read $ARGV[0]!\n");

my ( $choiceFileName, $location, $hrvctl, $HCctl, $elecldscale, $dhwldscale, $linecount );

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
    if ( $attribute =~ /Location/ ){
      $location = $value; 
      print LOG "Location is $location \n";  
    }
    if ( $attribute =~ /HRV_ctl/ ){
      $hrvctl = $value; 
      print LOG "HRV control is $hrvctl \n";  
    }
    if ( $attribute =~ /ElecLoadScale/ ){
      $elecldscale = $value; 
      print LOG "Electric load scale is $elecldscale \n";  
    }
    if ( $attribute =~ /DHWLoadScale/ ){
      $dhwldscale = $value; 
      print LOG "DHW load scale is $dhwldscale \n";  
    }
    if ( $attribute =~ /HeatCool-Control/ ){
      $HCctl = $value; 
      print LOG "Heating control is $HCctl \n";  
    }
  }
}
close ( GENOPTGENFILE );

print LOG "The current directory is: ".$master_path."\n";

fcopy("$ChoiceFileDir/$choiceFileName", "$master_path/$choiceFileName" );



open (CHOICEFILE, "$master_path/$choiceFileName") 
    || die ("Could not open $master_path/$choiceFileName for reading !\n" );
    
    
my $choice_content = ""; 
    
while ( my $line = <CHOICEFILE> ){

  $line=~ s/<LOCATION>/$location/g; 
  $line=~ s/<HRVCTL>/$hrvctl/g; 
  $line=~ s/<ELECTLOADSCALE>/$elecldscale/g; 
  $line=~ s/<DHWLOADSCALE>/$dhwldscale/g; 
  $line=~ s/<Opt-HeatCool-Control>/$HCctl/g; 
  
  $choice_content .= $line; 

}

close CHOICEFILE; 

open (CHOICEFILE, ">$master_path/$choiceFileName") 
    || die ("Could not open $master_path/$choiceFileName for writing !\n" );
    
print CHOICEFILE $choice_content; 

close CHOICEFILE; 


my $command = $ARGV[1]." ../substitute.pl -e -c $choiceFileName -o ../options-generic-GHG.options -b ./GenericHome-GHG -vv";

print LOG "The command is: ".$command."\n";

system ( $command );

close ( LOG );
