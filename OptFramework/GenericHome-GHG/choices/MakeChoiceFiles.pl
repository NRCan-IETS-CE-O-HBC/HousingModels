#!/usr/bin/perl    

# This script creates choices files from a supplied csv file with
# specific choice attributes set. 
 
use warnings;
use strict;

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

while ( my $line = <OPTLISTFILE> ){

  $line =~ s/\!.*$//g; 
  $line =~ s/\s*//g;
  $linecount++;

  # First record is header with choice file attribute names
  if($linecount == 1) {
    @choiceAttKeys = split /,/, $line;
  } else {
    @choiceAttValues = split /,/, $line;
    my $count = 0;
    foreach (@choiceAttKeys){
      $choiceHash{ $choiceAttKeys[$count] } = $choiceAttValues[$count];
      $count++;
    }
    # Hash created for current record, write the corresponding choice file
    my $choiceFilename = "./".$choiceHash{"ID"} . ".choices";
    my $encoding = ":encoding(UTF-8)";
    open(OPTIONSOUT, ">$choiceFilename")
        || die "$0: Can't open $choiceFilename in write-open mode: $!";    
	
    print OPTIONSOUT "! Choice file $choiceFilename generated for GHG work.\n";
    print OPTIONSOUT "Opt-calcmode         : calc\n";
    print OPTIONSOUT "Opt-DBFiles          : retrofit\n";
    print OPTIONSOUT "GOconfig_rotate      : E\n";
    print OPTIONSOUT "Opt-Location         : Ottawa\n";
    print OPTIONSOUT "OPT-HRV_ctl          : ERSp3ACH\n";
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
    print OPTIONSOUT "Opt-GenericFdn_1Layer_definitions : ".$choiceHash{"Opt-GenericFdn_1Layer_definitions"}."\n";
    print OPTIONSOUT "Opt-BasementSlabInsulation : GenericFoundationSlab\n";
    print OPTIONSOUT "Opt-BasementConfiguration : ".$choiceHash{"Opt-BasementConfiguration"}."\n";
    print OPTIONSOUT "Opt-CasementWindows  :  ".$choiceHash{"Opt-CasementWindows"}."\n";
    print OPTIONSOUT "Opt-ExposedFloor     : ".$choiceHash{"Opt-ExposedFloor"}."\n";
    print OPTIONSOUT "Opt-StandoffPV       : NoPV\n";
    print OPTIONSOUT "Opt-DWHRandSDHW      : none\n";
    print OPTIONSOUT "Opt-ElecLoadScale    : NGERSNoReduction19\n";
    print OPTIONSOUT "Opt-DHWLoadScale     : No-Reduction\n";
    print OPTIONSOUT "Opt-RoofPitch        : 6-12\n";
    print OPTIONSOUT "Opt-DHWSystem        : ".$choiceHash{"Opt-DHWSystem"}."\n";
    print OPTIONSOUT "Opt-HVACSystem       : ".$choiceHash{"Opt-HVACSystem"}."\n";
    print OPTIONSOUT "Opt-Cooling-Spec     : ".$choiceHash{"Opt-Cooling-Spec"}."\n";
	print OPTIONSOUT "Opt-HRVspec          : ".$choiceHash{"Opt-HRVspec"}."\n";
	
    close(OPTIONSOUT);
  }
}
close (OPTLISTFILE);


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
