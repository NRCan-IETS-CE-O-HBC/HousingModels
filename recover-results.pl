#!/usr/bin/perl

# This script parses through the files

 
use warnings;
use strict;

if ( ! $ARGV[0] || $ARGV[0] =~ /-h/ ){

    print " recover-results.pl \n"; 
    print " \n"; 
    print " usage: recover-results.pl <remote computer address> \n";
    print " \n"; 
    print " (e.g. recover-results.pl ec2-23-23-47-71.compute-1.amazonaws.com )\n\n"; 
    die(); 
}
 

my $RemoteAddress = $ARGV[0]; 
my $RemoteDir     = "NZEH-optimization"; 
my $RemoteFile    = "OutputListingAll.txt"; 
my $LocalFileName = "RecoveredFromCloud.txt"; 
my $OutputFile    = "CloudResultsAllData.csv"; 
my $Batch         = 0; 
my $TotalRows     = 0; 
my $GetFileCmd = "scp -i ../AFTrialMyKey.pem root\@$RemoteAddress:~/$RemoteDir/$RemoteFile ./$LocalFileName "; 



my @AllFiles = split /\s/, `ls /cygdrive/s/SBC/Housing_\\&_Buildings/HBCS_2012_2016_Initiatives/ecoEII_New_Housing/Optimization_results/RawData/CloudResultsPart*.txt`; 



print " Running: $GetFileCmd ... \n"; 
system ($GetFileCmd); 
print " ...done.\n"; 

push @AllFiles, $LocalFileName; 

open (WRITEOUT, ">$OutputFile") or die ( " Could not open $OutputFile for writing !"); 


foreach ( @AllFiles ) {
  print "Recovering data from $_ ... \n"; 
  $Batch++; 
  my $LocalFileName = $_; 
  open (READIN,$LocalFileName) or die ( " Could not open $LocalFileName for reading !"); 

  

  my $LineCount = 0; 
  my $headerLine = ""; 
  my $lines = ""; 
  my $row = 1;  
  
  while ( my $line =<READIN> ){

    $LineCount++; 
    
    if ( $LineCount < 20 ) {
    
        # GenOpt preamble. Do nothing. 
    
    }elsif ( $LineCount == 20 ) {
    
        # Header Row, copied for first batch only. 
        if ( $Batch == 1) {
            $line  =~ s/ /_/g; 
            $line  =~ s/\s+/,/g; 
            #print " HEADER: $line "; 
            $lines .= "ID,batch,row,$line"."junk,generation\n" ; 
        }
    }else{
        $row++; 
        $TotalRows++; 
        # All other rows
        $line =~ s/\s+/,/g; 
        $line =~ s/,$//g; 
        $lines .= "$TotalRows,$Batch,$row,$line\n" ; 
        
    
    }


    #print $lines; 

  }

  close READIN; 
  
  print WRITEOUT $lines; 

}
  
close WRITEOUT; 
system ("cp $OutputFile /cygdrive/s/SBC/Housing_\\&_Buildings/HBCS_2012_2016_Initiatives/ecoEII_New_Housing/Optimization_results/");
die ( "All done! Recovered $TotalRows Rows in $Batch files. "); 
