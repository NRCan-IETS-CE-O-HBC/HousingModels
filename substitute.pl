#!/usr/bin/perl

# This script parses through the files

 
use warnings;
use strict;
#use File::Compare;
use Cwd;
use Cwd 'chdir';
use File::Find;
use Math::Trig;

sub runsims($);
sub postprocess($);
sub execute($);
sub stream_out($);
sub fatalerror($); 
sub round($); 
sub round1d($); 
sub min($$);



my %gTest_params;          # test parameters
my $gChoiceFile  = ""; 
my $gOptionFile  = "" ; 

my $gBPSpath            = "~/esp-r/bin/bps"; 
my $gPRJpath            = "~/esp-r/bin/prj"; 

my $gBaseModelFolder    = "NZEH-base";
my $gWorkingModelFolder = "NZEH-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "NZEH.cfg";
my $gISHcmd             = "./run.sh $gModelCfgFile";
my $gPRJZoneConCmd      = "$gPRJpath -mode text -file $gModelCfgFile -act update_con_files";
my $gPRJZoneRotCmd      = "$gPRJpath -mode text -file $gModelCfgFile -act rotate ";
my $gBPScmd             = "$gBPSpath -file $gModelCfgFile -mode text -p fullyear silent";
#$gBPScmd                = "$gBPSpath -file $gModelCfgFile -mode text -p jan silent";

my $gTotalCost          = 0; 
my $gIncBaseCosts       = 11727; 

my $gSkipSims           = 0; 

my $gRotate             = "S";

my $gGOStep             = 0; 
my $gArchGOChoiceFile   = 0; 

my %gChoices; 
my %gOptions;
my %gExtOptions; 

my $gEnergyPV; 
my $gEnergySDHW;
my $gEnergyHeating;
my $gEnergyCooling;
my $gEnergyVentilation; 
my $gEnergyWaterHeating; 
my $gEnergyEquipment; 


my @gChoiceOrder;

my $master_path = getcwd(); 

$gTest_params{"verbosity"} = "quiet"; 
$gTest_params{"logfile"}   = "$master_path/pl-log.txt"; 

open(LOG, ">".$gTest_params{"logfile"}) or fatalerror("Could not open ".$gTest_params{"logfile"}."\n"); 

# List of extentions that we should operate on

my @search_these_exts=( "cfg",
                        "aim",
                        "hvac",
                        "con",
                        "vnt",
                        "geo",
                        "constrdb",
                        "cnn",
                        "enf",
                        "dhw"
                      );
                       
                       
                        
#-------------------------------------------------------------------
# Help text. Dumped if help requested, or if no arguements supplied.
#-------------------------------------------------------------------
my $Help_msg = "

 substitute.pl: 
 
 This script searches through a suite of model input files 
 and substitutes values from a specified input file. 
 
 use: ./substitute.pl --options options.opt     \
                      --choices choices.options
                      
 use for optimization work:
 
  ./substitute.pl -c optimization-choices.opt \
                  -o optimization-options.opt  
                  -v(v);
                       
";
# dump help text, if no arguement given
if (!@ARGV){
  print $Help_msg;
  die;
}
                       
                                       

my ($arg, $cmd_arguements,@processed_args, @binaries);

# Compress arguements into a space-separated string
foreach $arg (@ARGV){
  $cmd_arguements .= " $arg ";
}

# Compress white space, and convert to ';'
$cmd_arguements =~ s/\s+/ /g;
$cmd_arguements =~ s/\s+/;/g;

# Translate shorthand arguements into longhand
$cmd_arguements =~ s/-h;/--help;/g;
$cmd_arguements =~ s/-p;/--path;/g;
$cmd_arguements =~ s/-c;/--choices;/g;
$cmd_arguements =~ s/-o;/--options;/g;
$cmd_arguements =~ s/-v;/--verbose;/g;
$cmd_arguements =~ s/-vv;/--very_verbose;/g;


# Collate options expecting arguements
$cmd_arguements =~ s/--options;/--options:/g;
$cmd_arguements =~ s/--choices;/--choices:/g;
$cmd_arguements =~ s/--rotate;/--rotate:/g;

# If any options expecting arguements are followed by other
# options, insert empty arguement:
$cmd_arguements =~ s/:-/:;-/;

# remove leading and trailing ;'s
$cmd_arguements =~ s/^;//g;
$cmd_arguements =~ s/;$//g;

# split processed arguements back into array
@processed_args = split /;/, $cmd_arguements;


# Intrepret arguements
foreach $arg (@processed_args){
  SWITCH:
  {
    if ( $arg =~/^--help/ ){
      # Dump help messages and quit.
      print $Help_msg;
      die;
      last SWITCH;
    }
    
    if( $arg =~ /^--choices:/){
      # Path to configuration file (via dakota?)
      $gChoiceFile = $arg;
      $gChoiceFile =~ s/--choices://g;
      if ( ! $gChoiceFile ){
        fatalerror("Path to choice file must be specified with --choices (or -c) option!");
      }
      last SWITCH;
    }
    
    if( $arg =~ /^--options:/){
      # Path to configuration file (via dakota?)
      $gOptionFile = $arg;
      $gOptionFile =~ s/--options://g;
      if ( ! $gOptionFile ){
        fatalerror("Path to option file must be specified with --options (or -o) option!");
      }
      last SWITCH;
    }    
    
    
    if ( $arg =~ /^--rotate:/ ){
      # stream out progess messages
      $gRotate = $arg;
      $gRotate =~ s/--rotate://g; 
      if ($gRotate !~ /^[NSEW]$/ && $gRotate !~ /AVG/ ){
        fatalerror("Could not interpret rotation direction ($gRotate). Please specifiy N,S,E,W or AVG.");
      }  
      
      last SWITCH;
    }
    
    if ( $arg =~ /^--skip-sims/ ){
      # stream out progess messages
      $gSkipSims = 1;
      last SWITCH;
    }
    
    
    if ( $arg =~ /^--verbose/ ){
      # stream out progess messages
      $gTest_params{"verbosity"} = "verbose";
      last SWITCH;
    }

    
    if ( $arg =~ /^--very_verbose/ ){
      # steam out all messages
      $gTest_params{"verbosity"} = "very_verbose";

      last SWITCH;
    }

    
    
    
    
    
    fatalerror("Arguement \"$arg\" is not understood\n");
    
    
 
    
    
  }
}

# Create base folder for working model
if (! -d "$gBaseModelFolder" && -d "../$gBaseModelFolder" ){ 
  execute ("cp -fr ../$gBaseModelFolder ./");
}



if (! -r "$gOptionFile" && -r "../$gOptionFile" ){ 
  execute ("cp ../$gOptionFile ./");
}


stream_out (" > substitute.pl path: $master_path \n");
stream_out (" >               ChoiceFile: $gChoiceFile \n");
stream_out (" >               OptionFile: $gOptionFile \n");



# Parse option file 
open ( OPTIONS, "$gOptionFile") or fatalerror("Could not read $gOptionFile!");
stream_out("\n\nReading $gOptionFile...");
my $linecount = 0;
my $currentAttributeName ="";
my $AttributeOpen = 0;
my $ExternalAttributeOpen = 0;

my %currentOptions; 
my %currentTags; 

while ( my $line = <OPTIONS> ){
  
  $line =~ s/\!.*$//g; 
  $line =~ s/\s*//g;
  $linecount++;

    
  
  stream_out ("  Line: $linecount >$line<\n");
  
  if ( $line ) {
    
    my ( $token, $value ) = split /=/, $line ;

    # Allow value to contain spaces: if 
    $value =~ s/~/ /g;

    # Open up a new attribute    
    if ( $token =~ /^\*attribute:start/ ){
    
      $AttributeOpen = 1; 
    
    }

    # Open up a new external attribute    
    if ( $token =~ /^\*ext-attribute:start/ ){
    
      $ExternalAttributeOpen = 1; 
    
    }

    
    # Parse attribute contents Name/Tag/Option(s)
    if ( $AttributeOpen || $ExternalAttributeOpen ) {
    
      # Read name
      if ( $token =~ /^\*attribute:name/ ){
    
        $currentAttributeName = $value ;
        
      }
      
      
      # For options that need to be replaced in the 
      # external file. 
      if ( $token =~ /^\*attribute:tag/ ){
    
        my($rubbish,$junk,$TagIndex) = split /:/, $token;
    
        $currentTags{$TagIndex} = $value;
    
      }
      
      
      if ( $token =~ /^\*option:.+:value:[0-9]+$/){
      
        my( $rubbish, $OptionName, $junk, $ValueIndex ) = split /:/, $token;
        
        $currentOptions{$OptionName}{"values"}{$ValueIndex} = $value; 
      
      }
      
      
      # Get cost data 
      stream_out "? $token ?"; 
      if ( $token =~ /^\*option:.+:cost$/){
      
        my( $rubbish, $OptionName, $junk ) = split /:/, $token;
        
        # Strip '$', if present
        $value =~ s/\$//g;
        
        $currentOptions{$OptionName}{"cost"} = $value; 
        stream_out "+++ $OptionName cost: $value";
      }
      stream_out "\n"; 
      # Get energy produced by components modelled outside ESP-r (ext. 
      # components only). Components are tagged as "production-elec",
      # "production-SH" or "production-DHW"
      if ( $token =~ /^\*option:.+:production-.+$/){
      
        my( $rubbish, $OptionName, $ProdEnergyType ) = split /:/, $token;
        
        $ProdEnergyType =~ s/production-//g; 
        
        $currentOptions{$OptionName}{$ProdEnergyType} = $value; 
      
      }
      
      
      
      if ( $token =~ /^\*option:.+:meta$/){
      
        my( $rubbish, $OptionName, $junk ) = split /:/, $token;
        
        $currentOptions{$OptionName}{"meta"} = $value; 
      
      }
    
    }
    
    
    
    # Close attribute and append contents to global options array
    if ( $token =~ /^\*attribute:end/ ){
    
       $AttributeOpen = 0; 
    
      # Store tags 
      for my $TagIndex (keys (%currentTags ) ){
      
        $gOptions{$currentAttributeName}{"tags"}{$TagIndex} = $currentTags{$TagIndex}; 
      
      }

      # Store options 
      for my $optionIndex ( keys (%currentOptions) ){

        my $valHash = $currentOptions{$optionIndex}{"values"};
      
        for my $ValueIndex ( keys ( %$valHash ) ) {
        
          $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"values"}{$ValueIndex}
                                    = $currentOptions{$optionIndex}{"values"}{$ValueIndex};
        
        
        }
        stream_out ">+> $currentAttributeName:$optionIndex:cost: ". $currentOptions{$optionIndex}{"cost"}."\n";
                                    
        $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"cost"}
                                  = $currentOptions{$optionIndex}{"cost"}; 
        
        $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"meta"}
                                  = $currentOptions{$optionIndex}{"meta"};
        
      }
     
      stream_out " $currentAttributeName -> gOptions \n"; 
     
      for ( keys %currentOptions ){ delete $currentOptions{$_} ;}
      for ( keys %currentTags )   { delete $currentTags{$_} ;}   
      
    }
    
    
    
    
    
    # Close external attribute and append contents to global options 
    # array 
    if ( $token =~ /^\*ext-attribute:end/ ){
      $ExternalAttributeOpen = 0; 
      
      # Store options. Option index will be the name of each option 
      # for each attribute. 
      for my $optionIndex ( keys (%currentOptions) ){

        stream_out "() $optionIndex\n";
 
        $gExtOptions{$currentAttributeName}{"options"}{$optionIndex}{"cost"}
                                  = $currentOptions{$optionIndex}{"cost"}; 
        

        $gExtOptions{$currentAttributeName}{"options"}{$optionIndex}{"elec"}
                                  = $currentOptions{$optionIndex}{"elec"}; 
                           
        $gExtOptions{$currentAttributeName}{"options"}{$optionIndex}{"SH"}
                                  = $currentOptions{$optionIndex}{"SH"};  

        $gExtOptions{$currentAttributeName}{"options"}{$optionIndex}{"DHW"}
                                  = $currentOptions{$optionIndex}{"DHW"}; 
                                  
        
        
      }
      # Delete holding arrays
      for ( keys %currentOptions ){ delete $currentOptions{$_} ;}
      for ( keys %currentTags )   { delete $currentTags{$_} ;}   
      
    }
    
  }
  
}
close (OPTIONS);
 

for my $att (keys %gOptions ){ 

  stream_out ".... $att \n"; 
  
}



stream_out ("...done.\n") ; 

# Parse configuration (choice file ) 


open ( CHOICES, "$gChoiceFile" ) or fatalerror("Could not read $gChoiceFile!");

stream_out("\n\nReading $gChoiceFile...");

$linecount = 0;

while ( my $line = <CHOICES> ){
  
  $line =~ s/\!.*$//g; 
  $line =~ s/\s*//g;
  $linecount++;
  #stream_out ("  Line: $linecount >$line<\n");
  
  if ( $line ) {
    my ($attribute, $value) = split /:/, $line;
    
    
    # Parse config commands
    if ( $attribute =~ /^GOconfig_/ ){
      $attribute =~ s/^GOconfig_//g; 
      if ( $attribute =~ /rotate/ ) { $gRotate = $value; } 
      if ( $attribute =~ /step/ ) { $gGOStep = $value; 
                                      $gArchGOChoiceFile = 1;  } 
    }else{
      $gChoices{"$attribute"}=$value ;
    
      # Save order of choices to make sure we apply them correctly. 
      push @gChoiceOrder, $attribute;
    }
  }

}


close( CHOICES );
stream_out ("...done.\n") ; 

if ( $gArchGOChoiceFile and -d "../ArchGOChoiceFiles" ) { 
  #stream_out( " Archiving $gChoiceFile -> ../ArchGOChoiceFiles/$gChoiceFile-$gGOStep" ); 
  #!execute ( " cp $gChoiceFile ../ArchGOChoiceFiles/$gChoiceFile-$gGOStep ") ; 
  
} 


my %gChoiceAttIsExt;



# Report 
my $allok = 1;

while ( my ( $attribute, $choice) = each %gChoices ){
  
    
  # is attribute defined in options ?
  if ( ! defined( $gOptions{$attribute} ) && ! defined ( $gExtOptions{$attribute} ) ){
    stream_out ( "\nERROR: Attribute $attribute appears in choice file ($gChoiceFile), \n");
    stream_out (   "       but can't be found in options file ($gOptionFile)\n");
    $allok = 0;
  }
  
  if ($allok){ 
    if ( defined( $gOptions{$attribute} ) ){ 
      $gChoiceAttIsExt{$attribute} = 0; 
    }else{
      $gChoiceAttIsExt{$attribute} = 1;
    }
  }
  
  if ( ! $gChoiceAttIsExt{$attribute} ) {  
  
    if ( ! defined( $gOptions{$attribute}{"options"}{$choice} ) ){
       
       stream_out ( "\nERROR: Choice $choice (for attribute $attribute, defined \n");
       stream_out (   "       in choice file $gChoiceFile), is not defined \n");
       stream_out (   "       in options file ($gOptionFile)\n");
       $allok = 0;
       
    }
  }
  
  if ( $gChoiceAttIsExt{$attribute} ) {  
    if ( $attribute =~ /Opt-StandoffPV/ && $choice =~ /autosize/ ) {
    
      # Combination is OK: do nothing. 
    
    }elsif ( ! defined( $gExtOptions{$attribute}{"options"}{$choice} ) ){
       
       stream_out ( "\nERROR: Choice $choice (for attribute $attribute, defined \n");
       stream_out (   "       in choice file $gChoiceFile), is not defined \n");
       stream_out (   "       in options file ($gOptionFile)\n");
       $allok = 0;
       
    }
  }
  
    
       
  
  my ($BaseOption,$ScaleFactor,$BaseChoice,$BaseCost);
  
  # This section implements the multiply-cost and meta-select parameters. 
  # These are only supported on the gOptions attributes (and not gExtOptions). 
  
  if ($allok ){
    
    my $cost; 
    if ( ! $gChoiceAttIsExt{$attribute} ){
    
      $cost = $gOptions{$attribute}{"options"}{$choice}{"cost"};
    
    }else{

      $cost = $gExtOptions{$attribute}{"options"}{$choice}{"cost"};
    
    }
    
    my $repcost = defined( $cost ) ? $cost : "?" ; 
    
    
    
    my $ScaleCost = 0; 
    
    
    # Scale cost by some other parameter. 
    if ( $repcost =~/\<MULTIPLY-COST:.+/){
    
      my $multiplier = $cost;
      
      $multiplier =~ s/\<//g;
      $multiplier =~ s/\>//g;
      $multiplier =~ s/MULTIPLY-COST://g;
    
      ($BaseOption,$ScaleFactor) = split /\*/, $multiplier;
      
      $BaseChoice = $gChoices{$BaseOption};
      $BaseCost   = $gOptions{$BaseOption}{"options"}{$BaseChoice}{"cost"};
      
      my $CompCost = $BaseCost * $ScaleFactor; 
    
      $ScaleCost = 1; 
      if ( $gChoiceAttIsExt{$attribute} ){
        $gExtOptions{$attribute}{"options"}{$choice}{"cost"} = $CompCost; 
      }else{
        $gOptions{$attribute}{"options"}{$choice}{"cost"} = $CompCost; 
      }
      
      
    }
    
    $cost = $gChoiceAttIsExt{$attribute} ? $gExtOptions{$attribute}{"options"}{$choice}{"cost"}  : 
                                           $gOptions{$attribute}{"options"}{$choice}{"cost"} ;
    if ( ! defined ($cost) ){ $cost = "0" ; }                                       
    stream_out ( "\n\nMAPPING for $attribute = $choice (@ \$".
                 round($cost).
                 " inc. cost): \n"); 
    if ( $ScaleCost ){
      stream_out (     "  (cost computed as $ScaleFactor *  ".round($BaseCost)." [cost of $BaseChoice])\n");
    }
    
    
    if ( ! $gChoiceAttIsExt{$attribute} ){
     

    
      my $TagHash = $gOptions{$attribute}{"tags"}; 
      my $ValHash = $gOptions{$attribute}{"options"}{$choice}{"values"};
      
      
      for my $tagIndex ( sort keys (%$TagHash) ){
        my $tag   = ${$TagHash}{$tagIndex};
        my $value = ${$ValHash}{$tagIndex};
        
        
        
  #      stream_out ("          looking for : \$gOptions{ $attribute }{\"options\"}{ $choice }{\"values\"}\n");
        
        stream_out ("          $tag -> $value \n");
        
        if ( $value =~/\<METASELECT:.+/ ) {
        
          # If value contains a METASELECT statement, turn statement 
          # into a ruleset we can use. 
          $value =~ s/\<//g;
          $value =~ s/\>//g;
          $value =~ s/^METASELECT://g;
          
          my ($MetaOption,$MetaRuleString) = split /\?/ , $value;  
          my @MetaRules = split /,/, $MetaRuleString; 
          my %MetaRuleResult;
          foreach my $rule (@MetaRules){
            my ($match,$result)=split /:/, $rule; 
            $MetaRuleResult{$match} = $result;
          }
          
          # Find the matching option for specified statement
          
          my($MetaChoice) = $gChoices{$MetaOption};
          my($MetaValue)  = $gOptions{$MetaOption}{"options"}{$MetaChoice}{"meta"}; 
          my($ReMapValue) = $MetaRuleResult{$MetaValue};
          #stream_out ("          $tag -> $value \n");
          
          stream_out ("             ->  REMAPPING Metaselect: $MetaOption | $MetaRuleString \n");
          stream_out ("                           Querying  : $MetaChoice in option $MetaOption  \n");
          stream_out ("                           Found:    : $MetaValue \n");
          stream_out ("                           Rewriting : ".${$ValHash}{$tagIndex}."->".$ReMapValue."\n");
          
          $gOptions{$attribute}{"options"}{$choice}{"values"}{$tagIndex} = $ReMapValue; 
          stream_out ("          $tag -> ".$gOptions{$attribute}{"options"}{$choice}{"values"}{$tagIndex}." \n");        
        }
        
        

      }
    }
  }
 
  
}


if ( ! $allok ) { 
    fatalerror(" Choices in $gChoiceFile do not match options in $gOptionFile!");
}


# Now create a copy of our base ESP-r file for manipulation. 
stream_out("\n\n Creating a working folder for optimization work...");
if ( ! $gSkipSims ) {
  system ("rm -fr $gWorkingModelFolder ");
  system ("cp -fr $gBaseModelFolder $gWorkingModelFolder ");
}
stream_out("done.\n\n");



my $gMasterPath = getcwd();

# Search through all files in the working directory, and perform substitutions as needed 
 find( sub{
          # move on to next file if (1) file is a directory,
          # (2) file is not readable, or (3) file is not
          # cfg file.
          return if -d;
          return unless -r;
          return if $File::Find::name =~ m/CVS./;
          my $MatchExt = 0;
          for my $ext ( @search_these_exts ){
            if ( $File::Find::name =~ /$ext$/ ) {$MatchExt = 1;} 
          }
          if ( ! $MatchExt ) {return; }
          
          process_file($File::Find::name);
        },  $gWorkingModelFolder );


# Could allow SE/NE/SW/NW here, or even NNE, ENE, ESE, SSE ... 
my %angles = ( "S" => 0 , 
               "E" => 90,
               "N" => 180,
               "W" => 270  ); 


# Orientations is an array we populate with a single member if the orientation 
# is specified, or with all of the orientations to be run if 'AVG' is spec'd.               
my @Orientations;               


if ( $gRotate =~  /AVG/ ) 
{ 
  @Orientations = ( "S", "N", "E", "W" ); 
}
else 
{ 
  @Orientations = ( $gRotate ); 
}

# Compute scale factor for averaging between orientations (=1 if only 
# one orientation is spec'd)
my $ScaleResults = 1.0/($#Orientations+1); 
               
my $gAvgCost_NatGas    = 0 ;
my $gAvgCost_Electr    = 0 ;
my $gAvgEnergy_Total   = 0 ; 
 
for my $Direction  ( @Orientations ){

    if ( ! $gSkipSims ) { runsims( $angles{$Direction} ); }
    postprocess($ScaleResults);

}

my $gAvgCost_Total   = $gAvgCost_Electr + $gAvgCost_NatGas ;

open (SUMMARY, ">$gMasterPath/pl-out.txt") or fatalerror ("Could not open $gMasterPath/pl-out.txt");

print SUMMARY "Energy-Total-GJ =  $gAvgEnergy_Total \n"; 
print SUMMARY "Util-Bill-Total =  $gAvgCost_Total   \n";
print SUMMARY "Util-Bill-Elec  =  $gAvgCost_Electr  \n";
print SUMMARY "Util-Bill-Gas   =  $gAvgCost_NatGas  \n";

print SUMMARY "Energy-PV       =  $gEnergyPV \n";
print SUMMARY "Energy-SDHW     =  $gEnergySDHW \n";
print SUMMARY "Energy-Heating  =  $gEnergyHeating \n";
print SUMMARY "Energy-Cooling  =  $gEnergyCooling \n";
print SUMMARY "Energy-Vent     =  $gEnergyVentilation \n";
print SUMMARY "Energy-DWH      =  $gEnergyWaterHeating \n";
print SUMMARY "Energy-Plug     =  $gEnergyEquipment \n";  

print SUMMARY "Upgrade-cost    =  ".eval($gTotalCost-$gIncBaseCosts)."\n"; 

my $PVcapacity = $gChoices{"Opt-StandoffPV"}; 
$PVcapacity =~ s/[a-zA-Z:\s]//g;

print SUMMARY "PV-size-kW      =  ".$PVcapacity."\n"; 
close (SUMMARY); 

close(LOG); 

########################################################################
# Search through an input file and swap values for tags defined in options 
# and choice files. 

sub process_file($){

  my ($file_path) = @_; 
  
  my $startpath = getcwd();
  chdir $gMasterPath; 
  
  stream_out("  + Performing substitutions on ".$file_path."\n");
  
  open(READIN,$file_path) or fatalerror("Could not open $file_path for reading!");
  
  my @file_contents = ();   
  
  while ( my $line = <READIN> ){
  
    
    foreach my $attribute ( @gChoiceOrder ){
    
      if ( ! $gChoiceAttIsExt{$attribute} ){
    
        my $choice =  $gChoices{$attribute};
        
        my $tagHash = $gOptions{$attribute}{"tags"};
        my $valHash = $gOptions{$attribute}{"options"}{$choice}{"values"};
      
        for my $tagIndex ( keys ( %{$tagHash} ) ){
          
          my $tag   = ${$tagHash}{$tagIndex};
          my $value = ${$valHash}{$tagIndex};
        
       
          $line =~ s/$tag/$value/g; 
          
        }
      
      }
    }
    
    push @file_contents, $line;
  
 
  }
  
  close(READIN);
  
  
  open(WRITEOUT,">$file_path") or fatalerror("Could not open $file_path for writing!");

  print WRITEOUT @file_contents;
  
  close(WRITEOUT);
  
  chdir $startpath; 
  
}


sub runsims($){


  my ($RotationAngle) = @_;

  
  #my $gBPSpath            = "/home/aferguso/esp-r/bin/bps"; 
  #my $gPRJpath            = "/home/aferguso/esp-r/bin/prj"; 
  #
  #my $gBaseModelFolder    = "NZEH-base";
  #my $gWorkingModelFolder = "NZEH-work"; 
  #my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
  #my $gModelCfgFile       = "NZEH.cfg";

  chdir $gWorkingCfgPath; 

  
  
  execute("rm ../zones/*.con ../zones/*.tmc ../zones/*.shd ../zones/*.shda "); 
  if ( ! $gSkipSims ) { execute ("rm out.*"); }
  
  stream_out ("\n\n Moved to path:". getcwd()."\n"); 

  
  # Run the simulation
  stream_out ("\n\n Invoking prj to update con files (\"$gPRJZoneConCmd\")...");
  execute($gPRJZoneConCmd);
  stream_out ("done. \n");  

   
  # Spin the model 
  stream_out("\n\n Involing prj to rotate the model by $RotationAngle degrees (\"$gPRJZoneRotCmd $RotationAngle\")...");
  execute("$gPRJZoneRotCmd $RotationAngle"); 
  stream_out ("done. \n");   


  stream_out("\n\n Invoking ish via run.sh...");
  execute($gISHcmd); 
  stream_out("done...\n"); 



  stream_out ("\n\n Invoking ESP-r (\"$gBPScmd\")..." ); 
  execute($gBPScmd); 
  stream_out ("done. \n");         
          
          
  # Save output files
 if ( ! -d "$gMasterPath/sim-output" ) {

   execute("mkdir $gMasterPath/sim-output") or stream_out ("Could not create $gMasterPath/sim-output!\n"); 
   
 }
#
 if ( -d "$gMasterPath/sim-output") { execute("cp $gMasterPath/$gWorkingCfgPath/out* $gMasterPath/sim-output/");}
#         
#         
# # Cleanup
# stream_out("\n\n Deleting working folder...");
#  #system ("rm -fr $gWorkingModelFolder ");
#  stream_out("done.");ls 

  chdir $gMasterPath;

}


sub postprocess($){

  my $ScaleData  = @_; 

  my $TSLength            = 3600. ;  # Seconds
#  my $gBaseModelFolder    = "NZEH-base";
#  my $gWorkingModelFolder = "NZEH-work"; 
#  my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
#  my $gModelCfgFile       = "NZEH.cfg";

  # First day of the year: 
  my $FirstDay_Day_Of_Week = 7;   # 2011 starts on a Saturday

  #Which days are statutory holidays in Ontario? (Days of year) 
  my @holidays = (  3,    # New years (falls on sat, observed on Monday)
                   52,    # Family day
                  115,    # Good Friday
                  143,    # Victoria day
                  182,    # Canada day
                  248,    # Labour day
                  283,    # Thanksgiving
                  360,    # Christmans (falls on Sunday, observed on Monday)
                  361 );  # Boxing day (shifted to Tuesday b/c christmas)
                  
  #=======================================================================
  # Fuel cost parameters: ELECTRICITY

  my $ElecRateEsc = 1.49; 

  # Which months are summer, and which are winter?
  my @ElecRatePeriods = ( "winter",   # Jan 
                          "winter",   # Feb 
                          "winter",   # Mar 
                          "winter",   # Apr 
                          "summer",   # May 
                          "summer",   # Jun 
                          "summer",   # Jul 
                          "summer",   # Aug 
                          "summer",   # Sep 
                          "summer",   # Oct 
                          "winter",   # Nov 
                          "winter" ); # Dec 

  # which hours are on-peak, mid-peak and off-peak?
  my %ElecPeakSchedule= (
                       summer => [ "off-peak",     # 00:00 -> #01:00
                                   "off-peak",     # 01:00 -> #02:00
                                   "off-peak",     # 02:00 -> #03:00
                                   "off-peak",     # 03:00 -> #04:00
                                   "off-peak",     # 04:00 -> #05:00
                                   "off-peak",     # 05:00 -> #06:00
                                   "off-peak",     # 06:00 -> #07:00
                                   "mid-peak",     # 07:00 -> #08:00
                                   "mid-peak",     # 08:00 -> #09:00
                                   "mid-peak",     # 09:00 -> #10:00
                                   "mid-peak",     # 10:00 -> #11:00
                                   "on-peak",      # 11:00 -> #12:00
                                   "on-peak",      # 12:00 -> #11:00
                                   "on-peak",      # 11:00 -> #12:00
                                   "on-peak",      # 12:00 -> #13:00
                                   "on-peak",      # 13:00 -> #14:00
                                   "on-peak",      # 14:00 -> #15:00
                                   "on-peak",      # 15:00 -> #16:00
                                   "on-peak",      # 16:00 -> #17:00
                                   "mid-peak",     # 17:00 -> #18:00
                                   "mid-peak",     # 18:00 -> #19:00
                                   "off-peak",     # 19:00 -> #20:00
                                   "off-peak",     # 20:00 -> #21:00
                                   "off-peak",     # 21:00 -> #22:00
                                   "off-peak",     # 22:00 -> #23:00
                                   "off-peak",     # 23:00 -> #00:00
                                   "off-peak"      # 00:00 -> #22:00 
                                 ],
                       winter => [ "off-peak",     # 00:00 -> #01:00
                                   "off-peak",     # 01:00 -> #02:00
                                   "off-peak",     # 02:00 -> #03:00
                                   "off-peak",     # 03:00 -> #04:00
                                   "off-peak",     # 04:00 -> #05:00
                                   "off-peak",     # 05:00 -> #06:00
                                   "off-peak",     # 06:00 -> #07:00
                                   "on-peak",      # 07:00 -> #08:00
                                   "on-peak",      # 08:00 -> #09:00
                                   "on-peak",      # 09:00 -> #10:00
                                   "on-peak",      # 10:00 -> #11:00
                                   "mid-peak",     # 11:00 -> #12:00
                                   "mid-peak",     # 12:00 -> #11:00
                                   "mid-peak",     # 11:00 -> #12:00
                                   "mid-peak",     # 12:00 -> #13:00
                                   "mid-peak",     # 13:00 -> #14:00
                                   "mid-peak",     # 14:00 -> #15:00
                                   "mid-peak",     # 15:00 -> #16:00
                                   "mid-peak",     # 16:00 -> #17:00
                                   "on-peak",      # 17:00 -> #18:00
                                   "on-peak",      # 18:00 -> #19:00
                                   "off-peak",     # 19:00 -> #20:00
                                   "off-peak",     # 20:00 -> #21:00
                                   "off-peak",     # 21:00 -> #22:00
                                   "off-peak",     # 22:00 -> #23:00
                                   "off-peak",     # 23:00 -> #00:00
                                   "off-peak"      # 00:00 -> #22:00 
                                 ]    
                     ); 
        
  # How much do we change for on-peak, mid-peak and off peak?      
  my %ElecPeakCharges; 

  $ElecPeakCharges{"summer"}{"off-peak"} = 0.062 * $ElecRateEsc;  # $/kWh
  $ElecPeakCharges{"summer"}{"mid-peak"} = 0.092 * $ElecRateEsc;
  $ElecPeakCharges{"summer"}{"on-peak"}  = 0.108 * $ElecRateEsc;

  $ElecPeakCharges{"winter"}{"off-peak"} = $ElecPeakCharges{"summer"}{"off-peak"} ;
  $ElecPeakCharges{"winter"}{"mid-peak"} = $ElecPeakCharges{"summer"}{"mid-peak"} ;
  $ElecPeakCharges{"winter"}{"on-peak"}  = $ElecPeakCharges{"summer"}{"on-peak"}  ;

  my $ElecFixedCharge = 10.14 ; # $/month admin fees?

  my $ElecTotalOtherCharges = (     0.0108   # Transmission
                                  + 0.0203   # Local delivery
                                  + 0.0002   # Low-voltage services
                                  + 0.0065   # Reglatory charges
                                  + 0.00694  # Debt retirement 
                              );             # (all in $/kWh 

  #=======================================================================                           
  # Fuel cost parameters: Natural Gas

  my $NGasIncreaseFrac    = 1.53;      # Scale for future forecast

  my $NGasFixedCharge     = 19.       ; # $ / month; 
  my $NGasSupplyCharge    = 0.136891 * $NGasIncreaseFrac ; # $ / m3
  my $NGasTrasportCharge  = 0.057181  ; # $ / m3
  my %NGasDeliveryTier    = (    30 => 0.082878, 
                                 85 => 0.078155,
                                170 => 0.074455,
                              10000 => 0.071699  );  # $ / m3                           
                              

  my $gMasterPath = getcwd();


  # Move to working CFG directory, and parse out.summary file
  chdir $gWorkingCfgPath; 
  stream_out ("\n\n Moved to path:". getcwd()."\n"); 
  open (SIMRESULTS, "out.summary") or fatalerror("Could not open ".getcwd()."/out.summary!");

  my %gSimResults; 

  while ( my $line = <SIMRESULTS> ){

    my ( $token, $value, $units ) = split / /, $line; 
    
    if ( $units =~ /GJ/ ) {
    
      $gSimResults{$token} = $value; 
    
    }
    
  }

  close(SIMRESULTS);



  # Read in timestep data

  stream_out("\n\n Reading timestep data...") ; 

  open (TSRESULTS, "out.csv") or fatalerror("Could not open ".getcwd()."/out.csv!");

  my $RowNumber = 0; 
  my $firstline = 1;
  my @headers;
  my @numbers;
  my %data = () ; 
  while ( my $line = <TSRESULTS> ){

    if ( $firstline ){
    
      @headers = split /,/, $line;  
      $firstline = 0;
    }else{
    
      @numbers = split /,/, $line; 
      
      my $index = 0;
      
      for( $index=0; $index<$#headers; $index++){
        
        my $header = $headers[$index];
        my $value  = $numbers[$index];

        $data{$header}[$RowNumber] = $value; 

        
        #if ( $RowNumber == 0 ) {stream_out (" > header: >$header<\n");}
      }

      $RowNumber++;
      
    }
    
    
    
  }

  close (TSRESULTS);

  my $NumberOfRows = scalar(@{$data{$headers[0]}});

  stream_out("done (parsed $NumberOfRows rows)\n"); 

  # Recover electrical & gas consumption data 
  my @Electrical_Use = @{ $data{" total fuel use:electricity:all end uses:quantity (kWh/s)"} };
  my @NaturalGas_Use = @{ $data{" total fuel use:natural gas:all end uses:quantity (m3/s)"}  };

  # Recover Day, Hour & Month
  my @DayOfYear   = @{  $data{" building:day:future (day)"}     } ;
  my @HourOfDay   = @{  $data{" building:hour:future (hours)"}  } ;
  my @MonthOfYear = @{  $data{" building:month (-)"}            } ; 

  # Now loop through data and apply 

  my $row; 

  my $ElecConsumptionCost = 0; 
  my $MonthGasConsumption = 0; 
  my $GasConsumptionCost  = 0; 

  my $CurrDayOfWeek = $FirstDay_Day_Of_Week; 

  my $OldDay   = 1; 
  my $OldMonth = 1; 


  for ( $row = 0; $row < $NumberOfRows; $row++){

   

    # Get current hour, day & month as integers
    my $CurrDay   =  int($DayOfYear[$row])   ;
    my $CurrMonth =  int($MonthOfYear[$row]) ;
    my $CurrHour  =  int($HourOfDay[$row])   ;  
   
    
    # ELECTRICITY---------------------------------------------------------
    # Check to see if this is a new day, and increment day of week as needed
    if ( $CurrDay != $OldDay ) {
    
      $CurrDayOfWeek++; 
      
      # Roll over week after 7 days. 
      if ( $CurrDayOfWeek > 7 ){ $CurrDayOfWeek = 1; }
      $OldDay = $CurrDay; 
    }
    
    
    # Determine if this is a weekday or holiday 
    my $WeekendOrHoliday = 0; 

    foreach (@holidays){
       
      if ( $CurrDay == $_ ) { $WeekendOrHoliday = "holiday"} ;
        
    }
    
    if ( $CurrDayOfWeek == 1 || $CurrDayOfWeek == 7 ){$WeekendOrHoliday = "weekend"} ; 

    
    my $CurrElecRatePeriod = $ElecRatePeriods[$CurrMonth-1]; 
    
    my $CurrPeakPeriod; 
    
    if ( $WeekendOrHoliday ){
    
      $CurrPeakPeriod = "off-peak";
    
    }else{
    
      $CurrPeakPeriod = $ElecPeakSchedule{$CurrElecRatePeriod}[$CurrHour-1]
    
    }
    
    
    
    
    
    # Now apply electrical rates.
    
    my $ElecConsumption = $Electrical_Use[$row] * $TSLength;  # kWh 
    
    my $ElecVarRate     = $ElecPeakCharges{$CurrElecRatePeriod}{$CurrPeakPeriod} ; # $/kWh
    
    my $ElecEffectRate  = $ElecVarRate + $ElecTotalOtherCharges ;  # $/kWh
    
    
    $ElecConsumptionCost += $ElecConsumption * $ElecEffectRate ; 
         
         
    # Natural GAS ========================================================

    # Check to see if this is a new month, and zero gas consumption counter 
    # if so.

    if ( $CurrMonth != $OldMonth ){

      $MonthGasConsumption = 0; 
      
      $OldMonth = $CurrMonth;
    
    }
    
    
    # Use current month's gas consumption to figure out tier of current 
    # gas consumption. 
    my $CurrentGasConsumption = $NaturalGas_Use[$row] * $TSLength; # kWh
    
    $MonthGasConsumption += $CurrentGasConsumption; 
    
    my $CurrGasTarrif;
    
    SKIP: foreach my $tier (sort {$a <=> $b} (keys %NGasDeliveryTier)){
      
      
      
      if ( $MonthGasConsumption < $tier ){
        
        $CurrGasTarrif = $NGasDeliveryTier{$tier} ; 
        last SKIP; 
      }
    
    }
    
    
    
    
    $GasConsumptionCost += $CurrentGasConsumption * (   $CurrGasTarrif 
                                                      + $NGasSupplyCharge 
                                                      + $NGasTrasportCharge ); 
    
    
    #if ( $CurrMonth > 2 ) { die(); }
         
    #stream_out ("  $CurrMonth $CurrDay $CurrHour | $CurrElecRatePeriod - $CurrPeakPeriod ($WeekendOrHoliday)  $ElecConsumption [kWh] * ( $ElecVarRate + $ElecTotalOtherCharges [\$/kWh] ) = $ElecConsumptionCost  \n");        

    #stream_out ("  $CurrMonth $CurrDay $CurrHour | $MonthGasConsumption -> $CurrGasTarrif | $GasConsumptionCost += $CurrentGasConsumption * $CurrGasTarrif \n"); 
    
    
  }



  my $TotalElecBill = $ElecFixedCharge * 12. + $ElecConsumptionCost ; 

  my $TotalGasBill  = $NGasFixedCharge * 12. + $GasConsumptionCost  ; 

  # Add data from externally computed SDHW (presently not accounting for pump energy...)
  my $sizeSDHW = $gChoices{"Opt-SolarDHW"}; 
  $gSimResults{"SDHW production"} = -1.0 * $gExtOptions{"Opt-SolarDHW"}{"options"}{$sizeSDHW }{"DHW"}; 
  
    
  # Adjust solar DHW energy credit to reflect actual consumption. Assume 
  # SDHW credit cannot be more than 60% of total water load. 
  
  $gSimResults{"SDHW production"} = min( $gSimResults{"SDHW production"}*-1.,
                                         0.6 * $gSimResults{"total_fuel_use/test/all_fuels/water_heating/energy_content::AnnualTotal"} 
                                       ) * (-1.) ; 
  
  
  
  

  # Add data from externally computed PVs. 
  
  
  my $PVsize = $gChoices{"Opt-StandoffPV"}; 
  if ( $PVsize !~ /autosize/ ){
    
    # Use spec'd PV sizes 
    $gSimResults{"PV production"}=-1.0*$gExtOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"elec"}; 
  
  }else{
    # Size pv to max, or to size required to reach Net-Zero. 
    my $prePVEnergy = 0;

    foreach my $token ( sort keys %gSimResults ){

      my $value = $gSimResults{$token};
      $prePVEnergy += $value; 
            
    }

    if ( $prePVEnergy > 0 ){
    
      # This should always be the case
    
      my $SizeFound = 0;
    
      my $PVdataHash= $gExtOptions{"Opt-StandoffPV"}{"options"}; 
      
      # Loop through sizes until sufficient production is found 
      foreach my $size ( sort keys (%$PVdataHash) ){
        if ( $size !~ /autosize/ ){
          
          my $production = ${$PVdataHash}{$size}{"elec"}  ; 
          stream_out ">$SizeFound> PV: $size -> $production ( ? $prePVEnergy ? ) \n"; 
        
          if ( ! $SizeFound ){
            $PVsize = $size; 
            
            if ( $prePVEnergy < $production ){
              
              $SizeFound = 1; 
         
              stream_out " Setting Size: $PVsize \n"; 
            }
          }
        }
      }
      
      # IF no size found, extrapolate from largest size (10 kW)
      if ( ! $SizeFound ) {
      
        $gSimResults{"PV production"} = -1.0 * $prePVEnergy ;
        
        $PVsize = " scaled: ".eval(round1d($prePVEnergy*0.248756219))." kW" ;
      
        $gExtOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"cost"} 
           = 57780 + 1383.333333 * ( $prePVEnergy - 39.42 ) ; 

      
      }else{
        
        $gSimResults{"PV production"}=-1.0*$gExtOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"elec"};
      
      }
    
    }else{
      # House is already energy positive, no PV needed. 
      $PVsize = "0.0kW"
      
    }
    print ">$PVsize ...\n"; 
    
  }  
  
  $gChoices{"Opt-StandoffPV"}=$PVsize;
  

  stream_out("\n\n Energy Consumption: \n\n") ; 

  my $gTotalEnergy = 0;

  foreach my $token ( sort keys %gSimResults ){

    my $value = $gSimResults{$token};
    $gTotalEnergy += $value; 
    
    stream_out ( "  + $value ( $token, GJ ) \n");

  }
  
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( "    $gTotalEnergy ( Total energy, GJ ) \n");


  # Save Energy consumption for later
  $gEnergyPV = defined( $gSimResults{"PV production"} ) ? 
                         $gSimResults{"PV production"} : 0 ;  

  $gEnergySDHW = defined( $gSimResults{"SDHW production"} ) ? 
                         $gSimResults{"SDHW production"} : 0 ;  


  $gEnergyHeating = defined( $gSimResults{"total_fuel_use/test/all_fuels/space_heating/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/all_fuels/space_heating/energy_content::AnnualTotal"} : 0 ;  


  $gEnergyCooling = defined( $gSimResults{"total_fuel_use/test/all_fuels/space_cooling/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/all_fuels/space_cooling/energy_content::AnnualTotal"} : 0 ;  


  $gEnergyVentilation = defined( $gSimResults{"total_fuel_use/test/all_fuels/ventilation/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/all_fuels/ventilation/energy_content::AnnualTotal"} : 0 ;  


  $gEnergyWaterHeating = defined( $gSimResults{"total_fuel_use/test/all_fuels/water_heating/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/all_fuels/water_heating/energy_content::AnnualTotal"} : 0 ;  

  $gEnergyEquipment = defined( $gSimResults{"total_fuel_use/test/all_fuels/equipment/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/all_fuels/equipment/energy_content::AnnualTotal"} : 0 ;  

      

  
  
  
  stream_out("\n\n Energy Cost (not including credit for PV): \n\n") ; 

  stream_out("  + \$ ".round($TotalElecBill)." (Electricity)\n");
  stream_out("  + \$ ".round($TotalGasBill)." (Natural Gas)\n");

  stream_out ( " --------------------------------------------------------\n");
  stream_out ( "    \$ ".round($TotalElecBill+$TotalGasBill) ." (All utilities).\n"); 

  # Update global params for use in summary 
  $gAvgCost_NatGas    = $TotalGasBill  * $ScaleData; 
  $gAvgCost_Electr    = $TotalElecBill * $ScaleData;  
  $gAvgEnergy_Total   = $gTotalEnergy  * $ScaleData; 
  

  
  # Estimate total cost of upgrades

  $gTotalCost = 0;         

  stream_out ("\n\n Estimated costs: \n\n");

  foreach my  $attribute ( sort keys %gChoices ){
    
    my $choice = $gChoices{$attribute}; 
    my $cost; 
    if ( $gChoiceAttIsExt{$attribute} ){
      $cost  = $gExtOptions{$attribute}{"options"}{$choice}{"cost"};
    }else{
      $cost  = $gOptions{$attribute}{"options"}{$choice}{"cost"};
    }
    $gTotalCost += $cost;

    stream_out( " +  ".round($cost)." ( $attribute : $choice ) \n");
    
  }
  stream_out ( " - ".round($gIncBaseCosts)." (Base costs for windows)  \n"); 
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( " =   ".round($gTotalCost-$gIncBaseCosts)." ( Total incremental cost ) \n");

  
  
  
}



#-------------------------------------------------------------------
# Optionally write text to buffer
#-------------------------------------------------------------------
sub stream_out($){
  my($txt) = @_;
  if ($gTest_params{"verbosity"} ne "quiet"){
    print $txt;
  }
  if ($gTest_params{"logfile"}){
    print LOG $txt; 
  }
}

sub round($){
  my ($var) = @_; 
  my $tmpRounded = int( abs($var) + 0.5);
  my $finalRounded = $var >= 0 ? 0 + $tmpRounded : 0 - $tmpRounded;
  return $finalRounded;
}

sub round1d($){
  my ($var) = @_; 
  my $tmpRounded = int( abs($var*10) + 0.5);
  my $finalRounded = $var >= 0 ? 0 + $tmpRounded : 0 - $tmpRounded;
  return $finalRounded/10;
}

#-------------------------------------------------------------------
# Display a fatal error and quit.
#-------------------------------------------------------------------

sub fatalerror($){
  my ($err_msg) = @_;

  if ( $gTest_params{"verbosity"} eq "very_verbose" ){
    #print echo_config();
  }
  if ($gTest_params{"logfile"}){
    print LOG "\nsubstitute.pl -> Fatal error: \n"; 
    print LOG "$err_msg\n"; 
  }
  print "\nsubstitute.pl -> Fatal error: \n";
  print "$err_msg \n";
  die;
}


#--------------------------------------------------------------------
# Perform system commands with optional redirection
#--------------------------------------------------------------------
sub execute($){
  my($command) =@_;
  my $result;
  if ($gTest_params{"verbosity"} eq "very_verbose"){    
    stream_out("\n > executing $command \n");
    stream_out(" > from path ".getcwd()."\n");
    system($command);
  }else{
    $result = `$command 2>&1`;
    if ($gTest_params{"logfile"}){
      print LOG $result."\n\n\n"; 
    }
  }
  
  return;
}


sub min($$){
  my ($a,$b) = @_; 
  if ($a > $b ) {return $b;}
  else {return $a;}
  
  return 1;
}
