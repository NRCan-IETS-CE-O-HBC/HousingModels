#!/usr/bin/perl
use warnings;
use strict; 


my $DBPath = "./NZEH-base/dbs/material.db3-flat"; 

open (CRAP,$DBPath) or die ("Could not open $DBPath!");

my $output =   "D-ClassFlag"                      .", ".
               "D-ClassID"                        .", ".
               "D-#-in-class"                     .", ".
               "Catagory-Name"                    .", ".
               "D-ItemFlag"                       .", ".
               "Material name"                    .", ".
               "Material ID"                      .", ".
               "Material-cat-pointer"             .", ".
               "Material Description"             .", ".
               "DatCond"                          .", ".
               "DatDens"                          .", ".
               "DatSpecH"                         .", ".
               "DatEmissOut"                      .", ".
               "DatEmissIn"                       .", ".
               "DatAbsOut"                        .", ".
               "DatAbsIn"                         .", ".
               "DatDiff"                          .", ".
               "DatDefThickness"                  .", ".
               "DatFlag"                          .", ".
               "DatWinData1"                      .", ".
               "DatWinData2"                      .", ".
               "DatWinData3"                      .", ".
               "DatWinData4"                      .", ".
               "DatWinData5"                      .", ".
               "DatWinData6"                      .", ".
               "DatWinData7"                      .", ".
               "DatWinData8"                      .", ".
               "DatGasData1"                      .", ".
               "DatGasData2"                      .", ".
               "DatGasData3"                      .", ".
               "DatGasData4"                      .", ".
               "DatGasData5"                      .", ".
               "DatGasData6"                      .", ".
               "DatGasData7"                      .", ".
               "DatGasData8"                      .", ".
               "DatGasData9"                      .", ".
               "DatGasData1"                      .", ".
               "DatGasData1"                      .", ".
               "DatGasData1"                      .", ".
               "DatGasData1"                      .", ".
               "DatGasData1"                      ."\n" ; 

; 
my $lineopen = 0;  
my $lastlinecontents=""; 
my $catagoryconents=""; 


while (my $line = <CRAP>){

    $line =~ s/\n//g; 
    if ($line =~ /^#/ ){
        # Comment - do nothing
    }elsif($lineopen){
    
        # Read Data associated with line 
        
        #print " $line\n"; 
    
        my @Data = split /,/ , $line ; 
    
        my $DatCond         = $Data[0]  ;
        my $DatDens         = $Data[1]  ;
        my $DatSpecH        = $Data[2]  ;
        my $DatEmissOut     = $Data[3]  ;
        my $DatEmissIn      = $Data[4]  ;
        my $DatAbsOut       = $Data[5]  ;
        my $DatAbsIn        = $Data[6]  ;
        my $DatDiff         = $Data[7]  ;
        my $DatDefThickness = $Data[8]  ;
        my $DatFlag         = $Data[9]  ;
        
        my $DatWinData1     =  ""; 
        my $DatWinData2     =  ""; 
        my $DatWinData3     =  ""; 
        my $DatWinData4     =  ""; 
        my $DatWinData5     =  ""; 
        my $DatWinData6     =  ""; 
        my $DatWinData7     =  ""; 
        my $DatWinData8     =  ""; 

        my $DatGasData1     = ""; 
        my $DatGasData2     = ""; 
        my $DatGasData3     = ""; 
        my $DatGasData4     = ""; 
        my $DatGasData5     = ""; 
        my $DatGasData6     = ""; 
        my $DatGasData7     = ""; 
        my $DatGasData8     = ""; 
        my $DatGasData9     = ""; 
        my $DatGasData10    = ""; 
        my $DatGasData11    = ""; 
        my $DatGasData12    = ""; 
        my $DatGasData13    = ""; 
        my $DatGasData14    = ""; 
        
       
   
        if ( $DatFlag =~ /t/ ) {
        
            $DatWinData1 = $Data[10] ; 
            $DatWinData2 = $Data[11] ; 
            $DatWinData3 = $Data[12] ; 
            $DatWinData4 = $Data[13] ; 
            $DatWinData5 = $Data[14] ; 
            $DatWinData6 = $Data[15] ; 
            $DatWinData7 = $Data[16] ; 
            $DatWinData8 = $Data[17] ; 
        
        }
        
        if ($DatFlag =~ /g/ || $DatFlag =~ /h/  ){

            $DatGasData1  = $Data[10] ; 
            $DatGasData2  = $Data[11] ; 
            $DatGasData3  = $Data[12] ; 
            $DatGasData4  = $Data[13] ; 
            $DatGasData5  = $Data[14] ; 
            $DatGasData6  = $Data[15] ; 
            $DatGasData7  = $Data[16] ; 
            $DatGasData8  = $Data[17] ;         
            $DatGasData9  = $Data[18] ; 
            $DatGasData10 = $Data[19] ; 
            
            if ($DatFlag =~ /h/  ){
                $DatGasData11 = $Data[20] ; 
                $DatGasData12 = $Data[21] ; 
                $DatGasData13 = $Data[22] ; 
                $DatGasData14 = $Data[23] ;
            }
            
        }
        
        $output .= $catagoryconents     .", "
                  .$lastlinecontents   .", "
                  .$DatCond            .", "
                  .$DatDens            .", "
                  .$DatSpecH           .", "
                  .$DatEmissOut        .", "
                  .$DatEmissIn         .", "
                  .$DatAbsOut          .", "
                  .$DatAbsIn           .", "
                  .$DatDiff            .", "
                  .$DatDefThickness    .", "
                  .$DatFlag            .", "
                  .$DatWinData1        .", "
                  .$DatWinData2        .", "
                  .$DatWinData3        .", "
                  .$DatWinData4        .", "
                  .$DatWinData5        .", "
                  .$DatWinData6        .", "
                  .$DatWinData7        .", "
                  .$DatWinData8        .", "
                  .$DatGasData1        .", "
                  .$DatGasData2        .", "
                  .$DatGasData3        .", "
                  .$DatGasData4        .", "
                  .$DatGasData5        .", "
                  .$DatGasData6        .", "
                  .$DatGasData7        .", "
                  .$DatGasData8        .", "
                  .$DatGasData9        .", "
                  .$DatGasData10       .", "
                  .$DatGasData11       .", "
                  .$DatGasData12       .", "
                  .$DatGasData13       .", "
                  .$DatGasData14       ." \n "; 
               
                  
        $lineopen = 0; 
        
        
        
    
    }elsif ( $line =~ /^Catagory/ ) {
        
      # Dumb comment. Do nothing.
      
    }elsif ( $line =~ /^\*class/){
        
        $catagoryconents = $line; 
    
    }elsif ( $line =~ /^\*item/ ) {
    
       #print ">$line"; 
        $lineopen = 1; 
        $lastlinecontents = $line; 
    
    }else{

        #print $line; 
        
    }

}

print $output; 

open (DBout, ">./Materials-db-exp.csv") or die ("Could not open Materials.db.export for writing"); 

print DBout $output ; 

close (DBout); 
