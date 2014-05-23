#!/usr/bin/perl

$FirstFile = 1; 
$OUPTUT = ""; 
open (WRITEOUT, ">JoinedCSVFiles.csv"); 


for $file (@ARGV){

  print " Processing : $file \n"; 
  
  
  $LineNum = 1; 
  
  open ( READIN, $file ); 
  
  while ( my $line = <READIN> ){
  
    if ( $FirstFile && $LineNum == 1 ) {

      print WRITEOUT "Filename,$line";
      
    }elsif( $LineNum > 1 ) {

      print WRITEOUT "$file,$line";
    
    }
    
    
  
    
    $LineNum++;     
    
  }
  
  $FirstFile = 0; 
  
  close (READIN); 
  
}



close (WRITEOUT); 

