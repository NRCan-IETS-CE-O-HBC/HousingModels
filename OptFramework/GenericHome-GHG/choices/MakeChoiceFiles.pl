#!/usr/bin/perl    

# This script creates choices files from a supplied csv file with
# specific choice attributes set. 
 
use warnings;
use strict;

sub UpgradeRuleSet($);
sub WriteChoiceFile($);
sub fatalerror($);

#--------------------------------------------
# Help text. Dumped if no arguments supplied.
#--------------------------------------------
my $Help_msg = "

 MakeOptFiles.pl: 
 
 This script searches through the supplied command line argument file
 and creates one choice file per row in the supplied csv file. 
 
 use: ./MakeOptFiles.pl RunFile.csv
                      
";

# dump help text, if no argument given
if (!@ARGV){
  print $Help_msg;
  die;
}


my $OptListFile = $ARGV[0];

open ( OPTLISTFILE, "$OptListFile") or fatalerror("Could not read $OptListFile!");

my $linecount;
my @choiceAttKeys;
my @choiceAttValues;
my %choiceHash = ();



my $ChoiceFileList =""; 

my @upgrades= (

               # No changes  
               "as-found"                             ,    # Original definitions
                                                      
               # Fuel Switching senarios ( heating and water-heating )        
               "switch-oil-to-electricity-ASHP"       ,    # Oil boilers -> conventional ASHP + elec storage
               "switch-gas-to-electricity-ASHP"       ,    # Oil & Gas   -> conventional ASHP + elec stroage
               "switch-oil-to-electricity-CCASHP"     ,    # Oil boilers -> CCASHP + elec stroage
               "switch-gas-to-electricity-CCASHP"     ,    # Oil & Gas   -> CCASHP + elec storage
               "switch-oil-to-electricity-GSHP"       ,    # Oil boilers -> CCASHP + elec storage
               "switch-gas-to-electricity-GSHP"       ,    # Oil & Gas   -> CCASHP + elec storage 
               
               # Switch to gas ( heating and water-heating ) ?
               "switch-oil-to-gas"                    ,    # Oil         -> Gas 
               "switch-electricity-to-gas"            ,    # Electricity -> Gas 
                                                      
                                                      
               # Upgrade heating- ( no fuel switching scenarios )                     
               "retrofit-oil-heating-high-effciency"      ,    # As found to high efficiency equivlant
               "retrofit-gas-heating-high-effciency"      ,    # As found to high efficiency equivlant
               "retrofit-elec-heating-CCASHP"             ,    # As found to high efficiency equivlant
               "retrofit-elec-heating-GSHP"               ,   # As found to high efficiency equivlant

               # Upgrade Hot water - ( no fuel switching scenarios )                     
               "retrofit-oil-dhw-high-effciency"      ,    # As found to high efficiency equivlant
               "retrofit-gas-dhw-high-effciency"      ,    # As found to high efficiency equivlant
               "retrofit-elec-dhw-storage"            ,    # As found to high efficiency equivlant
               "retrofit-elec-dhw-hp"                 ,  # As found to high efficiency equivlant
               

               #Envelope systems - retrofit : 
               "retrofit-main-wall-a",
               "retrofit-main-wall-b",
               
               #Attic Insulation - Retrofit 
               "retrofit-Ceil-add-06in-cellulous",
               "retrofit-Ceil-add-12in-cellulous",
               
               #Attic Insulation - New 
               "NewCodes-ceilR70",
               "NewCodes-ceilR80",  
               "NewCodes-ceilR90",
               
               
                                
               
               # Air sealing - Retrofit 
               "retrofit-airseal-level-a",
               #"retrofit-airseal-level-b"
               #"NewCodes-airseal-level-a",
               "NewCodes-ACH-1.5",
               "NewCodes-ACH-1.0",
               "NewCodes-ACH-0.6",
               
               # New construction: Main wall
               "NewCodes-MainWallInsulation-R34",
               "NewCodes-MainWallInsulation-R23",
               "NewCodes-MainWallInsulation-R25",
               "NewCodes-MainWallInsulation-R29",
               "NewCodes-MainWallInsulation-R34",
               "NewCodes-MainWallInsulation-R39",
               "NewCodes-MainWallDblStd-R34",
               "NewCodes-MainWallDblStd-R41",
               
               # New constuction: Founation 
               "NewCodes-Foundation-RSI3.73",
               "NewCodes-Foundation-RSI5.46",
               
               # New codes: Windows 
               "NewCodes-Windows-LG-Double",
               "NewCodes-Windows-HG-Double",
               "NewCodes-Windows-LGi89-Triple",
               "NewCodes-Windows-HGi89-Triple-b",
               
               "Retrofit-Windows-LG-Double",
               "Retrofit-Windows-HG-Double",
               "Retrofit-Windows-LGi89-Triple",
               "Retrofit-Windows-HGi89-Triple-b",
               
               
               
               # Switch heating to disruptive tech ? 
               #"retrofit-heating-P9-combos"            ,    # Gas systems to high-effciency p9 combo
               #"retrofit-heating-P9+zoning"            ,    # Gas systems to p9 combos + zoned dist
               #"retrofit-heating-CCASHP"               ,    # Elect baseboard systems to CCASHP
               #"retrofit-heating-GSHP"                 ,    # Elect baseboard systems to CGHP
 
               # SDHW
               
               "Renewables-DWHR-4-60",
               "Renewables-SDHW-2-plate",
               "Renewables-SDHW-2-plate+DWHR-60",
               "Renewables-5kW-PV",
               
               
               
               ); 


#my @upgrades= ( "as-found") ; 

while ( my $line = <OPTLISTFILE> ){

  $line =~ s/\!.*$//g; 
  $line =~ s/\s*//g;
  $linecount++;

    
  # First record is header with choice file attribute names
  if($linecount == 1) {
    @choiceAttKeys = split /,/, $line;
  } else {
    @choiceAttValues = split /,/, $line;
  
    
    # Hash created for current record, write the corresponding choice file
       
    foreach my $upgrade ( @upgrades ){
      
      # Populate choice hash - do this on every upgrade because it gets overwritten
      my $count = 0;
      foreach (@choiceAttKeys){
        $choiceHash{ $choiceAttKeys[$count] } = $choiceAttValues[$count];
        $count++;
      }
      # extra keys that weren't part of the original spreadsheet - "as-found condition"
      $choiceHash{"Opt-DWHRandSDHW"} = "none"; 
      
       my $Scenario = $choiceHash{"Scenario"} ; 
       my $ID       = $choiceHash{"ID"} ; 
          
      
      # Call upgrade rule set to see if this upgrade can be applied 
            
      if ( UpgradeRuleSet($upgrade) ){
      
        my $choiceFilename = "./".$Scenario."~".$choiceHash{"ID"} ."~".$upgrade.".choices";
      
        print ( "> $ID : Generating scenario: $upgrade   \n"); 
      
      
        # Generate corresponding Choice File
        WriteChoiceFile($choiceFilename); 
      
        # Append name to list of choice files to be run. 
        $ChoiceFileList .= " $choiceFilename , "; 
  
    
      }
      
      
    
    }
  
    
  }
}



close (OPTLISTFILE);

$ChoiceFileList =~ s/\s*,\s*$//g; 
$ChoiceFileList =~ s/\.\///g; 

print "\n\n CHOICE LIST ->$ChoiceFileList<- \n"; 

print " =============================\n";
print " UPGRADES CONSIDERED:\n";
foreach my $upgrade ( @upgrades ){
      print "   -> $upgrade \n"; 
}



#--------------------------------------------------------------------
# Upgrade rule sets:
#--------------------------------------------------------------------
sub UpgradeRuleSet($){


  my ($upgrade) = @_; 

  my $validupgrade = 0; 
  
  
  SWITCH:{
  
    #=========================================================================
    # Ignore 2019+ scenarios for the time being. 
    #=========================================================================
    if ( $choiceHash{"ID"} =~ /2020-2024.*/  ||  
         $choiceHash{"ID"} =~ /2025-onwards.*/ ){
         
         #Do noting. 
         last SWITCH; 
           
    }
  
  
    #=========================================================================
    # Baseline: Leave choices alone. 
    #=========================================================================
    
    if ( $upgrade =~ /as-found/ ){
      
      # As found condition - no changes needed.
      
      $validupgrade = 1; 
      last SWITCH; 
  
    }
   
  
    #=========================================================================
    # Fuel switching: 
    #     Oil -> Gas to electric heat pumps,
    #     Oil -> gas 
    #     Elect -> Gas
    #=========================================================================
   
    # Oil -> ASHP 
    if ( $upgrade =~ /switch-oil-to-electricity.*/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Oil/){
        
        #         # Switch oil to ASHP
        if ( $upgrade =~ /.*-ASHP/ ){
          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-ASHP-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-elecstorage-ref" ; 
        }
        if ( $upgrade =~ /.*-CCASHP/ ){
          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-CCASHP-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-elecstorage-ref" ; 
        }
        if ( $upgrade =~ /.*-GSHP/ ){
          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-GSHP-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-elecstorage-ref" ; 
        }
      
        $validupgrade = 1;
      }
      last SWITCH; 
    }
    
    
    # Oil & GAS  -> ASHP 
    if ( $upgrade =~ /switch-gas-to-electricity.*/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Gas/  ){
        
        # Switch oil & gas to ASHP
        if ( $upgrade =~ /.*-ASHP/ ){
          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-ASHP-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-elecstorage-ref" ; 
        }
        if ( $upgrade =~ /.*-CCASHP/ ){
          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-CCASHP-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-elecstorage-ref" ; 
        }
        if ( $upgrade =~ /.*-GSHP/ ){
          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-GSHP-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-elecstorage-ref" ; 
        }
      
        $validupgrade = 1;
        
      }
      
      last SWITCH; 
    }
    
    
    # Oil -> GAS  
    if ( $upgrade =~ /switch-oil-to-gas.*/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Oil/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-gas-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-gasdhw-ref" ; 
          
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }
    
    
    # Electricity -> GAS  
    if ( $upgrade =~ /switch-electricity-to-gas/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Elect/ || 
           $choiceHash{"Opt-GhgHeatingCooling"} =~ /CCHP/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-gas-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-gasdhw-ref" ; 
          
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }
    

    #=========================================================================
    # HVAC upgrade - heating: Upgrade baseline to high-efficiency hvac
    #                         (with no fuel switch )
    #=========================================================================    
    
    # Oil scenario
    if ( $upgrade =~ /retrofit-oil-heating-high-effciency/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Oil/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-oil-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }    
    
    
    # Gas scenario
    if ( $upgrade =~ /retrofit-gas-heating-high-effciency/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Gas/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-gas-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }       
    

    # Elec baseboard->CCASHP
    if ( $upgrade =~ /retrofit-elec-heating-CCASHP/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Elect/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-CCASHP-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }         
    
    
    # Elec Baseboard -> GSHP. 
    if ( $upgrade =~ /retrofit-elec-heating-GSHP/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Elect/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-GSHP-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }         
    
    
    #=========================================================================
    # DHW upgrade - Upgrade baseline to high-efficiency water heater
    #               (with no fuel switch )
    #=========================================================================    
    
    # Oil scenario
    if ( $upgrade =~ /retrofit-oil-dhw-high-effciency/ ){
    
      if ( $choiceHash{"Opt-DHWSystem"} =~ /Oil/ ){

          $choiceHash{"Opt-DHWSystem"} = "oee-oildhw-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }    
    
    # Gas scenario
    if ( $upgrade =~ /retrofit-gas-dhw-high-effciency/ ){
    
      if ( $choiceHash{"Opt-DHWSystem"} =~ /Gas/ ){

          $choiceHash{"Opt-DHWSystem"} = "oee-gasdhw-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }    
    
    # Elec storage scenario
    if ( $upgrade =~ /retrofit-elec-dhw-storage/ ){
    
      if ( $choiceHash{"Opt-DHWSystem"} =~ /Elect/ ){

          $choiceHash{"Opt-DHWSystem"} = "oee-elecstorage-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }    
    
    
    # Elec storage scenario
    if ( $upgrade =~ /retrofit-elec-dhw-hp/ ){
    
      if ( $choiceHash{"Opt-DHWSystem"} =~ /Elect/ ){

          $choiceHash{"Opt-DHWSystem"} = "oee-elecHP-ref"  ;
                   
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }    
        
    
    #=========================================================================
    # Envelope insulation : Main Walls, Retrofit A
    #=========================================================================
        
    if ( $upgrade =~ /retrofit-main-wall-a/ ){
    
      if ( $choiceHash{"ID"} =~ /Pre-1946.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-17-eff"  ;
                   
          $validupgrade = 1;
          
      }
      
      if ( $choiceHash{"ID"} =~ /1946-1983.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-24-eff"  ;
                   
          $validupgrade = 1;
          
      }
      
      # .........
      # 1984-1995
      if ( $choiceHash{"ID"} =~ /1984-1995_Gas/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-23-eff"  ;
                   
          $validupgrade = 1;
          
      }            

      if ( $choiceHash{"ID"} =~ /1984-1995_Elect/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-24-eff"  ;
                   
          $validupgrade = 1;
          
      }            
      
      if ( $choiceHash{"ID"} =~ /1984-1995_Oil/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-23-eff"  ;
                   
          $validupgrade = 1;
          
      }        
      
      
      # .........
      # 1996-2005
      if ( $choiceHash{"ID"} =~ /1996-2005_Gas/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-24-eff"  ;
                   
          $validupgrade = 1;
          
      }            

      if ( $choiceHash{"ID"} =~ /1996-2005_Elect/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-25-eff"  ;
                   
          $validupgrade = 1;
          
      }            
      
      if ( $choiceHash{"ID"} =~ /1996-2005_Oil/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-24-eff"  ;
                   
          $validupgrade = 1;
          
      }        
            
      
      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2006-2011_Gas/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-24-eff"  ;
                   
          $validupgrade = 1;
          
      }            

      if ( $choiceHash{"ID"} =~ /2006-2011_Elect/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-25-eff"  ;
                   
          $validupgrade = 1;
          
      }            
      
      if ( $choiceHash{"ID"} =~ /2006-2011_Oil/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-24-eff"  ;
                   
          $validupgrade = 1;
          
      }  
      
      # New construction Rulesets go here. 
      
      
      
      
      

      
      last SWITCH;  
    }    
           
    
    
    #=========================================================================
    # Envelope insulation : Main Walls, Retrofit B
    #=========================================================================
        
    if ( $upgrade =~ /retrofit-main-wall-b/ ){
    
      if ( $choiceHash{"ID"} =~ /Pre-1946.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-30-eff"  ;
                   
          $validupgrade = 1;
          
      }
      
      if ( $choiceHash{"ID"} =~ /1946-1983.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-30-eff"  ;
                   
          $validupgrade = 1;
          
      }
      


      # .........
      # 1984-1995 (b)
      if ( $choiceHash{"ID"} =~ /1984-1995_Gas/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-33-eff"  ;
                   
          $validupgrade = 1;
          
      }            

      if ( $choiceHash{"ID"} =~ /1984-1995_Elect/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1;
          
      }            
      
      if ( $choiceHash{"ID"} =~ /1984-1995_Oil/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-33-eff"  ;
                   
          $validupgrade = 1;
          
      }        
      
      
      # .........
      # 1996-2005 (b)
      if ( $choiceHash{"ID"} =~ /1996-2005_Gas/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1;
          
      }            

      if ( $choiceHash{"ID"} =~ /1996-2005_Elect/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-35-eff"  ;
                   
          $validupgrade = 1;
          
      }            
      
      if ( $choiceHash{"ID"} =~ /1996-2005_Oil/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1;
          
      }        
            
      
      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2006-2011_Gas/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1;
          
      }            

      if ( $choiceHash{"ID"} =~ /2006-2011_Elect/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-35-eff"  ;
                   
          $validupgrade = 1;
          
      }            
      
      if ( $choiceHash{"ID"} =~ /2006-2011_Oil/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1;
          
      }  
      
      # New construction Rulesets go here. 
      
      
      
      
      

      
      last SWITCH; 
    }    
    
   
    #=========================================================================
    # Envelope insulation : Attic, Retrofit A (6in-cellulous)
    #=========================================================================
        
    if ( $upgrade =~ /retrofit-Ceil-add-06in-cellulous/ ){
    
      if ( $choiceHash{"ID"} =~ /Pre-1946.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR40"  ;
                   
          $validupgrade = 1;
          
      }
      
      if ( $choiceHash{"ID"} =~ /1946-1983.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR50"  ;
                   
          $validupgrade = 1; 
          
      }
      


      # .........
      # 1984-1995
      if ( $choiceHash{"ID"} =~ /1984-1995.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR50"  ;
                   
          $validupgrade = 1;
          
      }            

      
      # .........
      # 1996-2005
      if ( $choiceHash{"ID"} =~ /1996-2005.*/ ){
          $choiceHash{"Opt-Ceilings"} = "CeilR60"  ;
          $validupgrade = 1;
          
      }            


      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2006-2011.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR60"  ;
                   
          $validupgrade = 1;
          
      }   

      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR70"  ;  # Can we get to R70?
          $validupgrade = 1;
          
      }   
      
      
      # New construction Rulesets go here. 
      
        
      last SWITCH; 
    }    
      
  
    #=========================================================================
    # Envelope insulation : Attic, Retrofit B (12in-cellulous)
    #=========================================================================
        
    if ( $upgrade =~ /retrofit-Ceil-add-12in-cellulous/ ){
    
      if ( $choiceHash{"ID"} =~ /Pre-1946.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR60"  ;
                   
          $validupgrade = 1;
          
      }
      
      if ( $choiceHash{"ID"} =~ /1946-1983.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR70"  ;  # Can we go this high?
                   
          $validupgrade = 1;
          
      }
      


      # .........
      # 1984-1995
      if ( $choiceHash{"ID"} =~ /1984-1995.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR70"  ;
                   
          $validupgrade = 1;
          
      }            

      
      # .........
      # 1996-2005
      if ( $choiceHash{"ID"} =~ /1996-2005.*/ ){
          $choiceHash{"Opt-Ceilings"} = "CeilR80"  ; # Can we get to R70
          $validupgrade = 1;
          
      }            


      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2006-2011.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR80"  ;   # Can we get to R70?
                   
          $validupgrade = 1;
          
      }   

      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR90"  ;  # Can we get to R70?
          $validupgrade = 0;  # Can't get to R90./
          
      }   
      
      
      # New construction Rulesets go here. 
      
        
      last SWITCH; 
    }    
      
      
 
    #=========================================================================
    # Envelope Air-sealing : Retrofit 
    #=========================================================================    
    
    
            
    if ( $upgrade =~ /retrofit-airseal-level-a/ ){
    
      my ( $junk1,$junk2,$oldACH ) = split /_/,  $choiceHash{"Opt-ACH"}; 
      
      my $achImp = 0;   my $newACH = 0;  
    
      if ( $choiceHash{"ID"} =~ /Pre-1946.*/ ){

          $achImp = 0.12;
                            
          $validupgrade = 1;
          
      }
      
      if ( $choiceHash{"ID"} =~ /1946-1983.*/ ){

          $achImp = 0.07;    
                   
          $validupgrade = 1;
          
      }
      


      # .........
      # 1984-1995
      if ( $choiceHash{"ID"} =~ /1984-1995.*/ ){

          $achImp = 0.05;    
                   
          $validupgrade = 1;
          
      }            

      
      # .........
      # 1996-2005
      if ( $choiceHash{"ID"} =~ /1996-2005.*/ ){
          
          $achImp = 0.04;   
          $validupgrade = 1;
          
      }            


      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2006-2011.*/ ){
     
     
          $achImp = 0.02; 
          $validupgrade = 1;
          
      }   

      # .........
      # 2006-2011 - same as prior.
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ){

          $achImp = 0.02; 
          $validupgrade = 1;
          
      }   
      
      if ( $validupgrade ){
      
        $newACH =  (int(( $oldACH * ( 1.0 - $achImp ) ) * 10.0))/10.0; 
      
        $choiceHash{"Opt-ACH"} = "retro_ACH_$newACH";  
      
      }
      
      last SWITCH;  
    }    
      
      
 
    #=========================================================================
    # Windows: Same spec, different costs depending on new/retrofit. 
    #=========================================================================    
    
          
      
    if (         
         ( $upgrade =~ /NewCodes-Windows.*/ && $choiceHash{"ID"} =~ /2012-2019.*/ ) ||
         ( $upgrade =~ /Retrofit-Windows.*/ ) 
        ){ 
    
        if ( $upgrade =~ /Windows-HG-Double/ )
           { $choiceHash{"Opt-CasementWindows"} =  "BCLEEP-LG-Double" ; $validupgrade = 1; }

        if ( $upgrade =~ /Windows-HG-Double/ )
           { $choiceHash{"Opt-CasementWindows"} =  "BCLEEP-HG-Double" ; $validupgrade = 1; }
           
        if ( $upgrade =~ /Windows-LGi89-Triple/ )
           { $choiceHash{"Opt-CasementWindows"} =  "BCLEEP-LGi89-Triple" ; $validupgrade = 1; }           
  
           
        if ( $upgrade =~ /Windows-HGi89-Triple-b/ )
           { $choiceHash{"Opt-CasementWindows"} =  "BCLEEP-HGi89-Triple-b" ; $validupgrade = 1; }           
           
       
      last SWITCH; 
    
    }elsif($upgrade =~ /NewCodes-Windows.*/ ){
      # do nothing
      last SWITCH; 
    }
    
    
    
    
    #=========================================================================
    # New construction: Envelope Air-sealing -> 1.5 / 1.0 / 0.6 ACH
    #=========================================================================    

    if ( $upgrade =~ /NewCodes-ACH-1.5/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ){
    
           $choiceHash{"Opt-ACH"} = "retro_ACH_1.5";
           $validupgrade = 1;
          
      } 
      last SWITCH; 
    }
    
    if ( $upgrade =~ /NewCodes-ACH-1.0/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ){
    
           $choiceHash{"Opt-ACH"} = "retro_ACH_1";
           $validupgrade = 1;
          
      } 
      last SWITCH; 
    }

    if ( $upgrade =~ /NewCodes-ACH-0.6/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ){
    
           $choiceHash{"Opt-ACH"} = "retro_ACH_0.6";
           $validupgrade = 1; 
          
      } 
      last SWITCH; 
    } 
    
    
 
    #=========================================================================
    # New Construction: Attic insulation :  -> R70, R80, R90
    #=========================================================================
        
    if ( $upgrade =~ /NewCodes-ceilR70/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR70"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
    
        
    if ( $upgrade =~ /NewCodes-ceilR80/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  || 
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR80"  ;
                   
          $validupgrade = 1;
          
      }
      last SWITCH; 
    }    
    
    if ( $upgrade =~ /NewCodes-ceilR90/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  || 
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-Ceilings"} = "CeilR90"  ;
                   
          $validupgrade = 1;
          
      }
      last SWITCH; 
    }     
    
    
    #=========================================================================
    # New Construction: main wall 
    #=========================================================================
        
        
    # LEEP Stud_2x6_1in_XPS_R-23
   
    if ( $upgrade =~ /NewCodes-MainWallInsulation-R23/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-23-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }

    # LEEP Stud_2x6_1.5in_XPS_R-25


    if ( $upgrade =~ /NewCodes-MainWallInsulation-R25/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-25-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
 
 
    # LEEP Stud_2x6_2in_XPS_R-29

    if ( $upgrade =~ /NewCodes-MainWallInsulation-R29/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-29-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
 
  
    # LEEP Stud_2x6_3in_XPS_R-34

    if ( $upgrade =~ /NewCodes-MainWallInsulation-R34/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
 
   
    # LEEP Stud_2x6_4in_XPS_R-39

    if ( $upgrade =~ /NewCodes-MainWallInsulation-R39/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-39-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
 
 
     # LEEP DblStud_10in_cell_R-34

    if ( $upgrade =~ /NewCodes-MainWallDblStd-R34/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-34-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
 
      # LEEP DblStud_10in_cell_R-41

    if ( $upgrade =~ /NewCodes-MainWallDblStd-R41/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){

          $choiceHash{"Opt-GenericWall_1Layer_definitions"} = "Generic_Wall_R-41-eff"  ;
                   
          $validupgrade = 1; 
          
      }
      last SWITCH; 
    }
                
    
    #=========================================================================
    # New Construction: Below-grade wall/slab
    #=========================================================================
          
    if ( $upgrade =~ /NewCodes-Foundation-RSI3.73/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){      
    
            $choiceHash{"Opt-BasementConfiguration"}= "GHG-bsm-19-RSI_3.73";
            $validupgrade = 1; 
      
      }
      last SWITCH;
      
    }     

    if ( $upgrade =~ /NewCodes-Foundation-RSI5.46/ ){
    
      if ( $choiceHash{"ID"} =~ /2012-2019.*/ ||
           $choiceHash{"ID"} =~ /2020-2024.*/  ||  
           $choiceHash{"ID"} =~ /2025-onwards.*/ ){      
    
            $choiceHash{"Opt-BasementConfiguration"}= "GHG-bsm-22-RSI_5.46";
            $validupgrade = 1; 
      
      }
      last SWITCH;
      
    }   

    
    
    
     
    #=========================================================================
    # Renewable energy systems: Similar costs / specs for new/retrofit.
    #=========================================================================
            
    
    if ( $upgrade =~ /Renewables-DWHR-4-60/ ){
    
      $choiceHash{"Opt-DWHRandSDHW"} = "DWHR-4-60";
      $validupgrade = 1; 
      last SWITCH;
    }
    
    
    if ( $upgrade =~ /Renewables-SDHW-2-plate/ ){
    
      $choiceHash{"Opt-DWHRandSDHW"} = "2-plate";
      $validupgrade = 1; 
      last SWITCH;
    }    
    
    if ( $upgrade =~ /Renewables-SDHW-2-plate+DWHR-60/ ){
    
      $choiceHash{"2-plate-DWHR-4-60"} = "";
      $validupgrade = 1; 
      last SWITCH;
    }    
        
    if ( $upgrade =~ /Renewables-5kW-PV/ ){
    
      $choiceHash{"Opt-StandoffPV"} = "SizedPV|5kW";
      $validupgrade = 1; 
      last SWITCH;
    }    
   
    
    # < New rulesets go here: >  
    
    
    
    die ("\n\nUnsupported upgrade (\"$upgrade\")!\n\n"); 

  }    
  
  return $validupgrade; 
  
  
 #my %UpgradeTable  = ( "Opt-All"               => "as-found" , 
 #                      "Opt-GhgHeatingCooling" => "oee-gas-ref",
 #                      "Opt-GhgHeatingCooling" => "oee-CCASHP-ref",
 #                      "Opt-GhgHeatingCooling" => "oee-ASHP-ref",
 #               "Opt-GhgHeatingCooling" => "oee-GSHP-ref",
 #               "Opt-DHWSystem"         => "2025-onwards-Gas-dhw", 
 #               "Opt-DHWSystem"         => "2025-onwards-Oil-dhw", 
 #               "Opt-DHWSystem"         => "2025-onwards-Elect-dhw", 
 #               "Opt-DWHRandSDHW"       => "DWHR-4-36",
 #               "Opt-DWHRandSDHW"       => "DWHR-4-60",
 #               "Opt-DWHRandSDHW"       => "1-plate",
 #               "Opt-DWHRandSDHW"       => "2-plate"
 #               
 #               
 #              ); 
 #



}

sub WriteChoiceFile($){

   my ($FileName) = @_;
     
   my $encoding = ":encoding(UTF-8)";
   open(OPTIONSOUT, ">$FileName")
       || die "$0: Can't open $FileName in write-open mode: $!";    
	
   print OPTIONSOUT "! Choice file $FileName generated for GHG work.\n";
   print OPTIONSOUT "Opt-calcmode         : calc\n";
   print OPTIONSOUT "Opt-DBFiles          : retrofit\n";
   print OPTIONSOUT "GOconfig_rotate      : E\n";
   print OPTIONSOUT "Opt-Location         : <LOCATION>\n";
   print OPTIONSOUT "OPT-HRV_ctl          : <HRVCTL>\n";
   print OPTIONSOUT "OPT-OPR-SCHED        : scheduled\n";
   print OPTIONSOUT "Opt-BaseWindows      : MinWindows\n";
   print OPTIONSOUT "Opt-geometry         : ".$choiceHash{"Opt-geometry"}."\n";
   print OPTIONSOUT "Opt-Attachment       : single\n";
   print OPTIONSOUT "Opt-WindowOrientation: all\n";
   print OPTIONSOUT "Opt-ACH              : ".$choiceHash{"Opt-ACH"}."\n";
   print OPTIONSOUT "Opt-OverhangWidth    : BaseOverhang\n";
   print OPTIONSOUT "Opt-AirTightness     : Generic\n";
   print OPTIONSOUT "Opt-MainWall         : GenericWall_1Layer\n";
	 print OPTIONSOUT "Opt-GenericWall_1Layer_definitions : ".$choiceHash{"Opt-GenericWall_1Layer_definitions"}."\n";
   print OPTIONSOUT "Opt-ExtraDrywall     : OneSheet\n";
   print OPTIONSOUT "Opt-FloorSurface     : wood\n";
   print OPTIONSOUT "Opt-Ceilings         : ".$choiceHash{"Opt-Ceilings"}."\n";
   print OPTIONSOUT "Opt-BasementWallInsulation : GenericFoundationWall\n";
   print OPTIONSOUT "Opt-BasementSlabInsulation : GenericFoundationSlab\n";
   # print OPTIONSOUT "Opt-GenericFdn_1Layer_definitions : ".$choiceHash{"Opt-GenericFdn_1Layer_definitions"}."\n";
   
   print OPTIONSOUT "Opt-BasementConfiguration : ".$choiceHash{"Opt-BasementConfiguration"}."\n"; 
   
   print OPTIONSOUT "Opt-CasementWindows  :  ".$choiceHash{"Opt-CasementWindows"}."\n";
   print OPTIONSOUT "Opt-ExposedFloor     : ".$choiceHash{"Opt-ExposedFloor"}."\n";
   print OPTIONSOUT "Opt-StandoffPV       : NoPV\n";
   print OPTIONSOUT "Opt-DWHRandSDHW      : ".$choiceHash{"Opt-DWHRandSDHW"}."\n";
   print OPTIONSOUT "Opt-ElecLoadScale    : <ELECTLOADSCALE>\n";
   print OPTIONSOUT "Opt-DHWLoadScale     : <DHWLOADSCALE>\n";
   print OPTIONSOUT "Opt-RoofPitch        : 6-12\n";
   print OPTIONSOUT "Opt-DHWSystem        : ".$choiceHash{"Opt-DHWSystem"}."\n";
      
   # Heating vs Cooling specification
   print OPTIONSOUT "Opt-GhgHeatingCooling       : ".$choiceHash{"Opt-GhgHeatingCooling"}."\n";
  
   #print OPTIONSOUT "Opt-Cooling-Spec     : ".$choiceHash{"Opt-Cooling-Spec"}."\n";
	 
   print OPTIONSOUT "Opt-HRVspec          : ".$choiceHash{"Opt-HRVspec"}."\n";
	
  
  
   close(OPTIONSOUT);
     




}




#-------------------------------------------------------------------
# Display a fatal error and quit.
#-------------------------------------------------------------------

sub fatalerror($){
  my ($err_msg) = @_;

  #if ( $gTest_params{"verbosity"} eq "very_verbose" ){
  #  #print echo_config();
  #}
  #if ($gTest_params{"logfile"}){
  #  print LOG "\nsubstitute.pl -> Fatal error: \n"; 
  #  print LOG "$err_msg\n"; 
  #}
  print "\n=========================================================\n"; 
  print "MakeOptFiles.pl -> Fatal error: \n\n";
  print "$err_msg \n";
  print "\n\n"; 
  print "MakeOptFiles.pl -> Error and warning messages:\n\n";
  #print "$ErrorBuffer \n"; 
  die "Run stopped";
}
