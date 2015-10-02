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
               "switch-all-to-electricity-ASHP"       ,    # Oil & Gas   -> conventional ASHP + elec stroage
               "switch-oil-to-electricity-CCASHP"     ,    # Oil boilers -> CCASHP + elec stroage
               "switch-all-to-electricity-CCASHP"     ,    # Oil & Gas   -> CCASHP + elec storage
               "switch-oil-to-electricity-GSHP"       ,    # Oil boilers -> CCASHP + elec storage
               "switch-all-to-electricity-GSHP"       ,    # Oil & Gas   -> CCASHP + elec storage 
               
               # Switch to gas ?
               "switch-oil-to-gas"                    ,    # Oil         -> Gas 
               "switch-electricity-to-gas"            ,    # Electricity -> Gas 
                                                      
                                                      
               # Upgrade heating- ( no fuel switching scenarios )                     
               #"upgrade-heating-high-efficiency"      ,    # As found to high efficiency equivlant
               
               # Switch heating to disruptive tech ? 
               #"upgrade-heating-P9-combos"            ,    # Gas systems to high-effciency p9 combo
               #"upgrade-heating-P9+zoning"            ,    # Gas systems to p9 combos + zoned dist
               #"upgrade-heating-CCASHP"               ,    # Elect baseboard systems to CCASHP
               #"upgrade-heating-GSHP"                 ,    # Elect baseboard systems to CGHP
               
               # Envelope upgrades to come. 
               
               
               ); 




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

foreach my $upgrade ( @upgrades ){
      print "> $upgrade \n "; 
}


close (OPTLISTFILE);

$ChoiceFileList =~ s/\s*,\s*$//g; 
$ChoiceFileList =~ s/\.\///g; 
print "\n\n CHOICE LIST ->$ChoiceFileList<- \n"; 



#--------------------------------------------------------------------
# Upgrade rule sets:
#--------------------------------------------------------------------
sub UpgradeRuleSet($){


  my ($upgrade) = @_; 

  my $validupgrade = 0; 
  
  SWITCH:{
    if ( $upgrade =~ /as-found/ ){
      
      # As found condition - no changes needed.
      
      $validupgrade = 1; 
      last SWITCH; 
  
    }
    
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
    if ( $upgrade =~ /switch-all-to-electricity.*/ ){
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Oil/ || $choiceHash{"Opt-GhgHeatingCooling"} =~ /Gas/ ){
        
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
    
      if ( $choiceHash{"Opt-GhgHeatingCooling"} =~ /Elect/ || $choiceHash{"Opt-GhgHeatingCooling"} =~ /CCHP/ ){

          $choiceHash{"Opt-GhgHeatingCooling"} = "oee-gas-ref"  ;
          $choiceHash{"Opt-DHWSystem"}         = "oee-gasdhw-ref" ; 
          
          $validupgrade = 1;
          
      }

      
      last SWITCH; 
    }
    
    
    
    
    

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
