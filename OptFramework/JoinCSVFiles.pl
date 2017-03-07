#!/usr/bin/perl

$FirstFile = 1; 
$OUPTUT = ""; 
open (WRITEOUT, ">JoinedCSVFiles.csv"); 


my %masterheaders; 
$masterheaders{"aaa-filename"} = 1 ; 
$masterheaders{"id"} = 1 ; 

my %NumRows = {}; 

my %data = () ;

# Parse input 

my $id = 0; 

for $file (@ARGV){

  print " reading data from : $file ... "; 
  open (TSRESULTS, "$file") or fatalerror("Could not open ".getcwd()."/$file!");

  my $RowNumber = 0; 
  my $firstline = 1;
  my @headers;
  my @numbers;
 
  while ( my $line = <TSRESULTS> ){
    
    $line =~ s/\s+/ /g; 
    $line =~ s/,\s*/,/g;
    $line =~ s/^\s//g;
    $line =~ s/,,/,/g; 
    $line =~ s/\s*$//g; 
    
    if ( $firstline ){
      
      @headers = split /,/, $line;  
      $firstline = 0;
      
      my $index = 0;
      for( $index=0; $index<$#headers; $index++){
        
        my $colName = $headers[$index]; 
        
        if ( ! exists ( $masterheaders{$colName} ) ) { $masterheaders{$colName} = 1; }
        
        #if ( grep( /$colName/, @masterheaders ) ){} else{ push @masterheaders, $colName;} 

      }
      
      
    }else{
    
      @numbers = split /,/, $line; 
      
      my $index = 0;
      
      for( $index=0; $index<$#headers; $index++){
        
        my $header = $headers[$index];
        my $value  = $numbers[$index];

        $data{$file}{$header}[$RowNumber] = $value; 
        
        
        #if ( $RowNumber == 0 ) {debug_out (" > header: >$header<\n");}
      }
      $data{$file}{"id"}[$RowNumber] = $id;
      $data{$file}{"aaa-filename"}[$RowNumber] = $file; 
      

      $RowNumber++;
      $id++; 
    }
    
  }
  
  $NumRows{$file}=$RowNumber; 
  
  close (TSRESULTS);

  print " done. ($RowNumber rows)\n";
}

# Compute header roe 
my $headerRow = ""; 
my $noCol = 0; 
my $headerDone = 0; 


foreach my $column ( sort keys %masterheaders ){

  $headerRow .= "$column,"; 
  
  print " - $noCol, $column \n "; 
  $noCol ++; 

}
$headerRow = "$headerRow\n";


my $content = ""; 

for $file (@ARGV ){ 

  print "Writing results for $file \n";

  for (my $row = 0; $row < $NumRows{$file}; $row++ ){
  #for (my $row = 0; $row < 5 ; $row++ ){
    
    foreach my $column ( sort keys %masterheaders ){
      #print " $row > $column \n";
      
      
      if (exists( $data{$file}{$column}[$RowNumber] ) ) { 
       $content .=  $data{$file}{$column}[$row] ;  
      }else{
        $content .="0.0";
      } 
      $content .= ","
       
    }
    $content .= "\n"; 
  }
}

print WRITEOUT $headerRow; 
print WRITEOUT $content; 

close WRITEOUT; 




  
  
#  $LineNum = 1; 
#  
#  open ( READIN, $file ); 
#  
#  while ( my $line = <READIN> ){
#  
#    if ( $FirstFile == 1 && $LineNum == 1 ) {
#
#      print WRITEOUT "Filename,$line";
#      
#    }elsif( $LineNum > 1 ) {
#
#      print WRITEOUT "$file,$line";
#    
#    }
#    
#    
#  
#    
#    $LineNum++;     
#    
#  }
#  
#  $FirstFile = 0; 
#  
#  close (READIN); 
#  
#}
#
#
#
#close (WRITEOUT); 

