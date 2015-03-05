#!/usr/bin/perl    

# This script parses through the files
 
use warnings;
use strict;
#use File::Compare;
use Cwd;
use Cwd 'chdir';
use File::Find;
use Math::Trig;

use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove); 

sub UpdateCon();
sub runsims($);
sub postprocess($);
sub execute($);
sub debug_out($);
sub fatalerror($); 
sub round($); 
sub round1d($); 
sub min($$);
sub stream_out($);
sub stream_out($);
sub postprocessDakota();


my $gDebug = 0; 

my %gTest_params;          # test parameters
my $gChoiceFile  = ""; 
my $gOptionFile  = "" ; 

my $gBPSpath            = "~/esp-r/bin/bps"; 
my $gPRJpath            = "~/esp-r/bin/prj"; 


#### Please Don't change these --- use the -b option instead! ###
# $gBaseModelFolder initialized here but can be over-ridden by command line value with -b option
my $gBaseModelFolder    = "GenericHome-2storey";
my $gWorkingModelFolder = "MODEL-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "GenericHome-2storey.cfg";

my $gTotalCost          = 0; 
my $gIncBaseCosts       = 11727; 
my $cost_type           = 0;
my $gSkipSims           = 0; 

my $gRotate             = "S";

my $gGOStep             = 0; 
my $gArchGOChoiceFile   = 0; 

my %gChoices; 
my %gOptions;
my %gExtraDataSpecd; 

my $ThisError   = ""; 
my $ErrorBuffer = ""; 

my $SaveVPOutput = 0; 

my $gEnergyPV; 
my $gEnergySDHW;
my $gEnergyHeating;
my $gEnergyCooling;
my $gEnergyVentilation; 
my $gEnergyWaterHeating; 
my $gEnergyEquipment; 
my $gERSNum = 0;		# ERS number

my $gDakota = 0; 
my $gPostProcDakota = 0;
my $gERSCalcMode = 0;
my $gReorder = 0;

my $gRegionalCostAdj;   

my $gRotationAngle; 

my $gSkipPRJ = 0; 
my $gEnergyElec = 0;
my $gEnergyGas = 0;
my $gEnergyOil = 0; 
my $gEnergyWood = 0; 
my $gEnergyPellet = 0; 
my $gEnergyHardWood = 0;
my $gEnergyMixedWood = 0;
my $gEnergySoftWood = 0;
my $gEnergyTotalWood = 0;

my $gTotalBaseCost = 0;
my $gUtilityBaseCost = 0; 
my $PVTarrifDollarsPerkWh = 0.10;

my $gMasterPath = "";

# Variables that store the average utility costs, energy amounts.  
my $gAvgCost_NatGas    = 0 ;
my $gAvgCost_Electr    = 0 ;
my $gAvgEnergy_Total   = 0 ; 
my $gAvgCost_Propane   = 0 ;
my $gAvgCost_Oil       = 0 ;
my $gAvgCost_Wood      = 0 ;
my $gAvgCost_Pellet    = 0 ;
my $gAvgPVRevenue      = 0; 
my $gAvgElecCons_KWh    = 0; 
my $gAvgPVOutput_kWh    = 0; 
my $gAvgCost_Total      = 0; 
my $gAvgEnergyHeatingGJ = 0; 
my $gAvgEnergyCoolingGJ = 0; 
my $gAvgEnergyVentilationGJ  = 0; 
my $gAvgEnergyWaterHeatingGJ = 0; 
my $gAvgEnergyEquipmentGJ    = 0; 
my $gAvgNGasCons_m3     = 0; 
my $gAvgOilCons_l       = 0; 
my $gAvgPropCons_l      = 0; 
my $gAvgPelletCons_tonne = 0; 
my $gDirection = "";

my $gEnergyHeatingElec = 0;
my $gEnergyVentElec = 0;
my $gEnergyHeatingFossil = 0;
my $gEnergyWaterHeatingElec = 0;
my $gEnergyWaterHeatingFossil = 0;
my $gAvgEnergyHeatingElec = 0;
my $gAvgEnergyVentElec = 0;
my $gAvgEnergyHeatingFossil = 0;
my $gAvgEnergyWaterHeatingElec = 0;
my $gAvgEnergyWaterHeatingFossil = 0;
my $gAmtWood = 0;
my $gAmtOil = 0;

# Data from Hanscomb 2011 NBC analysis
my %RegionalCostFactors  = (  "Halifax"      =>  0.95 ,
                              "Edmonton"     =>  1.12 ,
                              "Calgary"      =>  1.12 ,  # Assume same as Edmonton?
                              "Ottawa"       =>  1.00 ,
                              "Toronto"      =>  1.00 ,
                              "Quebec"       =>  1.00 ,  # Assume same as Montreal?
                              "Montreal"     =>  1.00 ,
                              "Vancouver"    =>  1.10 ,
							  "PrinceGeorge" =>  1.10 ,
							  "Kamloops"     =>  1.10 ,
                              "Regina"       =>  1.08 ,  # Same as Winnipeg?
                              "Winnipeg"     =>  1.08 ,
                              "Fredricton"   =>  1.00 ,  # Same as Quebec?
                              "Whitehorse"   =>  1.00 ,
                              "Yellowknife"  =>  1.38 ,
							  "Inuvik"       =>  1.38   ); 

# Heating Degree Days (18C base), Source = HOT2000 v10.x (V10WeatherRPT.doc)
my %RegionalHDD			= ( "Halifax"    	=>  4100,
							"Edmonton"   	=>  5400,
							"Calgary"    	=>  5200,
							"Ottawa"     	=>  4600,
							"Toronto"    	=>  3650,
							"Quebec"     	=>  5200,
							"Montreal"   	=>  4250,
							"Vancouver"  	=>  2925,
							"PrinceGeorge" 	=>  5250,
							"Kamloops"     	=>  3650,
							"Regina"     	=>  5750,
							"Winnipeg"   	=>  5900,
							"Fredricton" 	=>  4650,
							"Whitehorse" 	=>  6900,
                            "Yellowknife"  	=>  8500,
							"Inuvik"       	=>  10050);

# Water main temperature (C)
my %RegionalWaterMainTemp = ( "Halifax"    	=>  11.02,
							"Edmonton"   	=>  8.02,
							"Calgary"    	=>  9.02,
							"Ottawa"     	=>  12.03,
							"Toronto"    	=>  14.04,
							"Quebec"     	=>  10.02,
							"Montreal"   	=>  11.03,
							"Vancouver"  	=>  14.02,
							"PrinceGeorge" 	=>  9.02,
							"Kamloops"     	=>  13.03,
							"Regina"     	=>  9.02,
							"Winnipeg"   	=>  9.02,
							"Fredricton" 	=>  11.02,
							"Whitehorse" 	=>  6.01,
                            "Yellowknife"  	=>  4.01,
							"Inuvik"       	=>  1.01);
							  
my @gChoiceOrder;

my $master_path = getcwd(); 

$gTest_params{"verbosity"} = "quiet"; 
$gTest_params{"logfile"}   = "$master_path/SubstitutePL-log.txt"; 

open(LOG, ">".$gTest_params{"logfile"}) or fatalerror("Could not open ".$gTest_params{"logfile"}."\n"); 

# List of extensions that we should operate on

my @search_these_exts=( "cfg",
                        "aim",
                        "hvac",
                        "con",
                        "vnt",
                        "geo",
                        "constrdb",
                        "cnn",
                        "enf",
                        "bsm",
                        "ctl",
                        "opr",
                        "dhw"
                      );
                       
                       
                        
#-------------------------------------------------------------------
# Help text. Dumped if help requested, or if no arguments supplied.
#-------------------------------------------------------------------
my $Help_msg = "

 substitute.pl: 
 
 This script searches through a suite of model input files 
 and substitutes values from a specified input file. 
 
 use: ./substitute.pl --options options.opt     \
                      --choices choices.options  \
                      --base_folder BaseFolderName
                      
 example use for optimization work:
 
  ./substitute.pl -c optimization-choices.opt \
                  -o optimization-options.opt \
                  -b BaseFolderName           \
                  -v(v)
                  
 other options: 
    -d : Use Dakota format for input (and processing). Choice file different!
    -e : Calculate ERS value (produces a second run, if required)
    -z : Run this script as Dakota post-processor (implies -d)
         Note: Need options (-o) and choice (-c) files but
               don't need -b option
    -r : Reorder Dakota postprocessed output to match GenOpt
         (Implies -d and -z.)
		 
";

# dump help text, if no argument given
if (!@ARGV){
  print $Help_msg;
  die;
}


my ($arg, $cmd_arguements,@processed_args, @binaries);

# Compress arguments into a space-separated string
foreach $arg (@ARGV){
  $cmd_arguements .= " $arg ";
}

# Compress white space, and convert to ';'
$cmd_arguements =~ s/\s+/ /g;
$cmd_arguements =~ s/\s+/;/g;

# Translate shorthand arguments into longhand
$cmd_arguements =~ s/-h;/--help;/g;
$cmd_arguements =~ s/-p;/--path;/g;			# Not used!
$cmd_arguements =~ s/-c;/--choices;/g;
$cmd_arguements =~ s/-o;/--options;/g;
$cmd_arguements =~ s/-v;/--verbose;/g;
$cmd_arguements =~ s/-vv;/--very_verbose;/g;
$cmd_arguements =~ s/-vvv;/--very_very_verbose;/g;
$cmd_arguements =~ s/-b;/--base_folder;/g;
$cmd_arguements =~ s/-svp;/--save-vp-output;/g;
$cmd_arguements =~ s/-d;/--dakota;/g; 
$cmd_arguements =~ s/-z;/--postprocdakota;/g; 
$cmd_arguements =~ s/-e;/--erscalc;/g; 
$cmd_arguements =~ s/-r;/--reorder;/g; 

# Collate options expecting arguments
$cmd_arguements =~ s/--options;/--options:/g;
$cmd_arguements =~ s/--choices;/--choices:/g;
$cmd_arguements =~ s/--rotate;/--rotate:/g;
$cmd_arguements =~ s/--base_folder;/--base_folder:/g;

# If any options expecting arguments are followed by other
# options, insert empty argument:
$cmd_arguements =~ s/:-/:;-/;

# remove leading and trailing ;'s
$cmd_arguements =~ s/^;//g;
$cmd_arguements =~ s/;$//g;

# split processed arguments back into array
@processed_args = split /;/, $cmd_arguements;

# Interpret arguments
foreach $arg (@processed_args){
  SWITCH:
  {
    if ( $arg =~ /^--help/ ){
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
      # stream out progress messages
      $gRotate = $arg;
      $gRotate =~ s/--rotate://g; 
      if ($gRotate !~ /^[NSEW]$/ && $gRotate !~ /AVG/ ){
        fatalerror("Could not interpret rotation direction ($gRotate). Please specifiy N,S,E,W or AVG.");
      }  
      
      last SWITCH;
    }
    
    if ( $arg =~ /^--skip-sims/ ){
      # stream out progress messages
      $gSkipSims = 1;
      last SWITCH;
    }

    if ( $arg =~ /^--skip-prj/ ){
      # skip PRJ related operations
      $gSkipPRJ = 1;
      last SWITCH;
    }
    
    if ( $arg =~ /^--dakota/ ) { 
       # use dakota format instead
       $gDakota = 1; 
       last SWITCH; 
    }   

    if ( $arg =~ /^--postprocdakota/ ) { 
       # post process Dakota output (and also set Dakota fag)
       $gDakota = 1;
	   $gPostProcDakota = 1;
       last SWITCH; 
    } 

    if ( $arg =~ /^--reorder/ ) { 
       # post process Dakota output (and also set Dakota fag)
       $gDakota = 1;
	   $gPostProcDakota = 1;
	   $gReorder = 1;
       last SWITCH; 
    } 
	
    if ( $arg =~ /^--erscalc/ ) { 
       # ERS calculation mode
       $gERSCalcMode = 1;
       last SWITCH; 
    } 
    
    if ( $arg =~ /^--verbose/ ){
      # stream out progress messages
      $gTest_params{"verbosity"} = "verbose";
      last SWITCH;
    }
    
    if ( $arg =~ /^--very_verbose/ ){
      # steam out all messages
      $gTest_params{"verbosity"} = "very_verbose";

      last SWITCH;
    }
    
    if ( $arg =~ /^--very_very_verbose/ ){
      # steam out all messages
      $gTest_params{"verbosity"} = "very_very_verbose";
      $gDebug = 1; 
      last SWITCH;
    }    
    
    if ( $arg =~ /^--save-vp-output/ ){ 
        $SaveVPOutput = 1; 
        last SWITCH; 
    }
    
    if ( $arg =~ /^--base_folder/ ){
		# Base folder name overrides initialized value (at top)
		$gBaseModelFolder = $arg;
		$gBaseModelFolder =~ s/--base_folder://g;
		$gBaseModelFolder =~ s/^.*\///g; 
		$gBaseModelFolder =~ s/^.*\\//g; 
		$gModelCfgFile = "$gBaseModelFolder.cfg"; 

		if ( ! $gBaseModelFolder ){
			fatalerror("Base folder name missing after --base_folder (or -b) option!");
		}
		if (! -d "$gBaseModelFolder" && ! -d "../$gBaseModelFolder" ){ 
			fatalerror("Base folder does not exist - create and populate folder first!");
		}

		last SWITCH;
    }
    
    fatalerror("Arguement \"$arg\" is not understood\n");
    
  }
}

if ($gTest_params{"verbosity"} ne "quiet"){
	print @processed_args; 
}

# Update ESP-r commands to use defined cfg file name.

my $gISHcmd             = "./run.sh $gModelCfgFile";
my $gPRJZoneConCmd      = "$gPRJpath -mode text -file $gModelCfgFile -act update_con_files";
my $gPRJZoneRotCmd      = "$gPRJpath -mode text -file $gModelCfgFile -act rotate ";
my $gBPScmd             = "$gBPSpath -h3k -file $gModelCfgFile -mode text -p fullyear silent";
   
   
# Create base folder for working model
if (!$gPostProcDakota && ! -d "$gBaseModelFolder" && -d "../$gBaseModelFolder" ){ 
  execute ("cp -fr ../$gBaseModelFolder ./");
}



if (! -r "$gOptionFile" && -r "../$gOptionFile" ){ 
  execute ("cp ../$gOptionFile ./");
}


stream_out (" > substitute.pl path: $master_path \n");
stream_out (" >               ChoiceFile: $gChoiceFile \n");
stream_out (" >               OptionFile: $gOptionFile \n");
stream_out (" >               base model: $gBaseModelFolder \n"); 



# Parse option file. This file defines the available choices and costs
# that substitute.pl can pick from 

open ( OPTIONS, "$gOptionFile") or fatalerror("Could not read $gOptionFile!");
stream_out("\n\nReading $gOptionFile...");
my $linecount = 0;
my $currentAttributeName ="";
my $AttributeOpen = 0;
my $ExternalAttributeOpen = 0;
my $ParametersOpen = 0; 

my %gParameters;

# Parse the option file. 
while ( my $line = <OPTIONS> ){

	$line =~ s/\!.*$//g; 
	$line =~ s/\s*//g;
	$linecount++;
  
	#debug_out ("  Line: $linecount >$line<");
  
	if ( $line !~ /^\s*$/ ) {
		#debug_out (" processing...\n");
		my ( $token, $value ) = split /=/, $line ;

		# Allow value to contain spaces: if 
		if ($value) { $value =~ s/~/ /g; }
	
		# The file contains 'attributes that are either internal (evaluated by ESP-r
		# or external (computed elsewhere and post-processed). 
	
		# Open up a new attribute    
		if ( $token =~ /^\*attribute:start/ ){
			$AttributeOpen = 1; 
		}

		# Open up a new external attribute    
		if ( $token =~ /^\*ext-attribute:start/ ){
			$ExternalAttributeOpen = 1; 
		}

		# Open up parameter block
		if ( $token =~ /^\*ext-parameters:start/ ){
			$ParametersOpen = 1; 
		}
    
		# Parse parameters. 
		if ( $ParametersOpen ) {
			
			# Read parameters. Format: 
			#  *param:NAME = VALUE 
			if ( $token =~ /^\*param/ ){
				$token =~ s/\*param://g; 
				#stream_out (">>>> TEST: $token => $value \n") ;
				$gParameters{"$token"} = $value; 
			} 
		}
    
		# Parse attribute contents Name/Tag/Option(s)
		if ( $AttributeOpen || $ExternalAttributeOpen ) {
    
			# Read name
			if ( $token =~ /^\*attribute:name/ ){
    
				$currentAttributeName = $value ;
				if ( $ExternalAttributeOpen) { 
					$gOptions{$currentAttributeName}{"type"} = "external"; 
				} else {
					$gOptions{$currentAttributeName}{"type"} = "internal"; 
				}
        
				$gOptions{$currentAttributeName}{"default"}{"defined"} = 0 ;
        
				#debug_out ("    ---> $currentAttributeName \n"); 
			}
      
      
			# For options that need to be replaced in the 
			# external file. Note: External Attribubes do not have tags...
			if ( $token =~ /^\*attribute:tag/ ){
    
				my($rubbish,$junk,$TagIndex) = split /:/, $token;
        
				#$currentTags{$TagIndex} = $value;
				$gOptions{$currentAttributeName}{"tags"}{$TagIndex} = $value ; 
			}
      
			# Standard form (no conditions) --- option:Name:MetaInfo:Index
	  
			# Possibly define default value. 
			if ( $token =~ /^\*attribute:default/ ) {
	  
				$gOptions{$currentAttributeName}{"default"}{"defined"} = 1 ;
				$gOptions{$currentAttributeName}{"default"}{"value"} = $value ;
			}

			if ( $token =~ /^\*option/ ){
				# Format: 
		
				#  *Option:NAME:MetaType:Index or 
				#  *Option[CONDITIONS]:NAME:MetaType:Index or 	
				# MetaType is:
				#  - cost
				#  - value 
				#  - alias (for Dakota)
				#  - production-elec
				#  - production-sh
				#  - production-dhw
				
				my @breakToken = split /:/, $token; 
				my @OptionConditions = (); 
				my $condition_string = ""; 
				#if ($breakToken[0]){debug_out (" + bt0: ". $breakToken[0] ."\n"); }
				#if ($breakToken[1]){debug_out (" + bt1: ". $breakToken[1] ."\n"); }
				#if ($breakToken[2]){debug_out (" + bt2: ". $breakToken[2] ."\n"); }
				#if ($breakToken[3]){debug_out (" + bt3: ". $breakToken[3] ."\n"); }
				#if ($breakToken[4]){die (" + bt4: ". $breakToken[4] ."\n"); }
				#if ($breakToken[5]){debug_out (" + bt5: ". $breakToken[5] ."\n"); }
				
				# Check option keyword to see if it has specific conditions
				# format is *option[condition1>value1;condition2>value2 ...] 
				
				if ($breakToken[0]=~/\[.+\]/ ) {
					
					$condition_string = $breakToken[0]; 
					$condition_string =~ s/\*option\[//g; 
					$condition_string =~ s/\]//g; 
					$condition_string =~ s/>/=/g; 
					#debug_out ("  + Reading conditions >$condition_string<!!!\n");
					
				} else {
					$condition_string = "all"; 
				}

				#debug_out ("  + Reading conditions >$condition_string<!!!\n");
				
				my $OptionName = $breakToken[1];
				my $DataType   = $breakToken[2];
				
				my $ValueIndex = ""; 
				my $CostType   = "";
				
				# Assign values 

				if ( $DataType =~ /value/ ){
					$ValueIndex = $breakToken[3]; 
					$gOptions{$currentAttributeName}{"options"}{$OptionName}{"values"}{$ValueIndex}{"conditions"}{$condition_string} = $value; 
				
					#debug_out ( "++++++  \$gOptions{$currentAttributeName}{options}{ $OptionName }{values}{ $ValueIndex }{\"conditions\"}{$condition_string} = $value \n" );  
				}
				
				if ( $DataType =~ /cost/ ){
					$CostType = $breakToken[3];
					$gOptions{$currentAttributeName}{"options"}{$OptionName}{"cost-type"} = $CostType;
					$gOptions{$currentAttributeName}{"options"}{$OptionName}{"cost"} = $value;
					
					#debug_out ( "++++++ \$gOptions{$currentAttributeName}{options}{ $OptionName }{cost-type} = $CostType \n"); 
					#debug_out ( "++++++ \$gOptions{$currentAttributeName}{options}{ $OptionName }{cost} = $value  \n"); 
				}
				
				# Added for Dakota
				if ( $DataType =~ /alias/ ){
					$gOptions{$currentAttributeName}{"options"}{$OptionName}{"alias"} = $value;
				}

				# External entities...
				if ( $DataType =~ /production/ ){
					if ( $DataType =~ /cost/ ){$CostType = $breakToken[3]; }
					$gOptions{$currentAttributeName}{"options"}{$OptionName}{$DataType}{"conditions"}{$condition_string} = $value; 
					
					#debug_out ( "++++++  \$gOptions{$currentAttributeName}{options}{ $OptionName }{ $DataType }{conditions}{ $condition_string } = $value \n" );  
				}
	  
			}
    
		}
    
    
		# Close attribute and append contents to global options array
		if ( $token =~ /^\*attribute:end/ || $token =~ /^\*ext-attribute:end/){
		
			$AttributeOpen = 0; 
		
			# Store tags (what's a tag?)
			#for my $TagIndex (keys (%currentTags ) ){
			#  debug_out ("$currentAttributeName TAG -> $TagIndex ...\n"); 
			#  $gOptions{$currentAttributeName}{"tags"}{$TagIndex} = $currentTags{$TagIndex}; 
			#
			#}

			# Store options 
			debug_out ( "========== $currentAttributeName ===========\n");
			debug_out ( "Storing data for $currentAttributeName: \n" );
		  
			my $OptHash = $gOptions{$currentAttributeName}{"options"}; 
		  
			for my $optionIndex ( keys (%$OptHash ) ){
				debug_out( "    -> $optionIndex \n"); 
				my $cost_type    = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"cost-type"}; 	
				my $cost         = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"cost"}; 	
				my $ValHash = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"values"};
			
				for my $valueIndex ( keys (%$ValHash) ) {

					my $CondHash = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"values"}{$valueIndex}{"conditions"}; 
					
					for my $conditions( keys (%$CondHash) ) {
						my $tag   = $gOptions{$currentAttributeName}{"tags"}{$valueIndex};
						my $value = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"values"}{$valueIndex}{"conditions"}{$conditions};
					
						debug_out( "           - $tag -> $value [valid: $conditions ]   \n");		
					}
				 
					#Energy credits not modelled in ESP-r 
				}

				#debug_out( "           - cost = \$$cost ($cost_type) \n");
			
				my $ExtEnergyHash = $gOptions{$currentAttributeName}{"options"}{$optionIndex}; 
				for my $ExtEnergyType ( keys (%$ExtEnergyHash ) ){
					if ( $ExtEnergyType =~ /production/ ) {
						my $CondHash = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{$ExtEnergyType}{"conditions"}; 
						for my $conditions( keys (%$CondHash) ) {
							my $ExtEnergyCredit = $gOptions{$currentAttributeName}{"options"}{$optionIndex}{$ExtEnergyType}{"conditions"}{$conditions}; 
							debug_out ("              - credit:($ExtEnergyType) $ExtEnergyCredit [valid: $conditions ] \n");	
						}
					}
				}
			}
		}
		  
		if ( $token =~ /\*ext-parameters:end/ ){
			$ParametersOpen = 0; 
		}
	}
}
    
close (OPTIONS);

 
#for my $att (keys %gOptions ){ 
  #debug_out ".... $att \n"; 
#}

stream_out ("...done.\n") ; 
 
# Parse configuration (choice file ) 


open ( CHOICES, "$gChoiceFile" ) or fatalerror("Could not read $gChoiceFile!");

stream_out("\n\nReading $gChoiceFile...");

$linecount = 0;

while ( my $line = <CHOICES> ){
	
	$line =~ s/\!.*$//g; 
	# next, strip white spaces for standard (and genopt) choice files
	if ( ! $gDakota ) { 
		$line =~ s/\s*//g;
	} else {
		# Dakota uses white-space to delimit inputs:
		#       value_a token_a
		#      value_ab token_ab 
		#     value_abc token_abc
		# Translate into existing choice-value format.  
		
		$line =~ s/^\s+//; 
		$line =~ s/\s+$//; 

		my ($value, $token) = split / /, $line; 
		
		# Ignore reserved keywords that dakota puts into its 
		# input files. 
		if ($token =~ /variables/ || 
			$token =~ /functions/ ||
			$token =~ /ASV/ ||
			$token =~ /derivative_variables/ ||
			$token =~ /analysis_components/  ||
			$token =~ /eval_id/ ){
			
			# Skip dakota meta-info. 
		
			$line = ""; 
			
		} else {
			# reformat line in friendly format 
			$line = "$token:$value"; 
		}
    
	}
    
	$linecount++;
	debug_out ("  Line: $linecount >$line<\n");
  
	if ( $line ) {
		my ($attribute, $value) = split /:/, $line;
    
		# Parse config commands
		if ( $attribute =~ /^GOconfig_/ ){
			$attribute =~ s/^GOconfig_//g; 
			if ( $attribute =~ /rotate/ ) { 
				$gRotate = $value; 
				$gChoices{"GOconfig_rotate"}=$value; 
				push @gChoiceOrder, "GOconfig_rotate";
			} 
			if ( $attribute =~ /step/ ) { 
				$gGOStep = $value; 
				$gArchGOChoiceFile = 1;  
			} 
		} else {
			my $extradata = $value; 
			if ( $value =~ /\|/ ){
				$value =~ s/\|.*$//g; 
				$extradata =~ s/^.*\|//g; 
				$extradata =~ s/^.*\|//g; 
			} else {
				$extradata = ""; 
			}
				
			$gChoices{"$attribute"}=$value ;
		  
			stream_out ("::: $attribute -> $value \n"); 
		  
			# Additional data that may be used to attribute the choices. 
			$gExtraDataSpecd{"$attribute"} = $extradata ; 
		  
			# Save order of choices to make sure we apply them correctly. 
			push @gChoiceOrder, $attribute;
		}
	}
}

close( CHOICES );
stream_out ("...done.\n") ; 

# Optionally create a copy of the choice file for later use. 
#if ( $gArchGOChoiceFile and -d "../ArchGOChoiceFiles" ) { 
  #debug_out( " Archiving $gChoiceFile -> ../ArchGOChoiceFiles/$gChoiceFile-$gGOStep" ); 
  #!execute ( " cp $gChoiceFile ../ArchGOChoiceFiles/$gChoiceFile-$gGOStep ") ; 
#} 


# Post process Dakota output file and stop (-z option)
if ( $gPostProcDakota ) {
	postprocessDakota();
}


my %gChoiceAttIsExt;
my %gExtOptions;
# Report 
my $allok = 1;

debug_out("-----------------------------------\n");
debug_out("-----------------------------------\n");
debug_out("Parsing parameters ...\n");

my $gCustomCostAdjustment=0; 
my $gCostAdjustmentFactor; 

# Possibly overwrite internal parameters with user-specified parameters
while ( my ( $parameter, $value) = each %gParameters ){

	#stream_out (">>>> PARAM: $parameter | $value \n"); 

	if ( $parameter =~ /CostAdjustmentFactor/  ){
		$gCostAdjustmentFactor = $value;
		$gCustomCostAdjustment = 1; 
	}
  
	if ( $parameter =~ /PVTarrifDollarsPerkWh/ ) {
		$PVTarrifDollarsPerkWh = $value; 
	}
  
	if ( $parameter =~ /BaseUpgradeCost/ ) {
		$gIncBaseCosts = $value; 
	}
  
	if ( $parameter =~ /BaseUtilitiesCost/ ) {
		$gUtilityBaseCost = $value; 
	}
}


stream_out(" Validating choices and options...\n");  


while ( my ( $option, $null ) = each %gOptions ){
    stream_out ("> option : $option ?\n"); 
    if ( ! defined( $gChoices{$option} ) ) {
 
		$ThisError = "\nWARNING: Option $option found in options file ($gOptionFile) \n";
		$ThisError .=  "         was not specified in Choices file ($gChoiceFile) \n";       
		$ErrorBuffer .= $ThisError; 
		stream_out ( $ThisError ); 
   
        if ( ! $gOptions{$option}{"default"}{"defined"}  ) {
             
            $ThisError = "\nERROR: No default value for option $option defined in \n";
            $ThisError .=  "       Options file ($gOptionFile)\n";       
            $ErrorBuffer .= $ThisError; 
            fatalerror ( $ThisError );              
             
        } else {    
            # Add default value. 
            $gChoices{$option} =   $gOptions{$option}{"default"}{"value"}; 
            # Apply them at the end. 
            push @gChoiceOrder, $option;
            
            $ThisError = "\n         Using default value (".$gChoices{$option}.") \n";
            $ErrorBuffer .= $ThisError; 
            stream_out ( $ThisError ); 
        }

    }
    $ThisError = ""; 
}


# Search through choices and determine if they match options in the Options file. 
while ( my ( $attribute, $choice) = each %gChoices ){
  
	debug_out ( "\n ======================== $attribute ============================\n");
	debug_out ( "Choosing $attribute -> $choice \n"); 
    
	# is attribute used in choices file defined in options ?
	if ( ! defined( $gOptions{$attribute} ) ){
		$ThisError  = "\nERROR: Attribute $attribute appears in choice file ($gChoiceFile), \n"; 
		$ThisError .=  "       but can't be found in options file ($gOptionFile)\n"; 
		$ErrorBuffer .= $ThisError; 
		stream_out( $ThisError ); 
		$allok = 0;
	} else {
		debug_out ( "   - found \$gOptions{\"$attribute\"} \n"); 
	}
  
	# is choice in options ?
	if ( ! defined( $gOptions{$attribute}{"options"}{$choice} ) ){
		$allok =0; 
		
		# Catch integer choice values used for Dakota!
		# - Modify choice that uses integer alias to use option name
		if ( $gDakota && $choice =~ /\d{3,4}/ ){
			#Use option text string that matches this integer alias
			my $OptHash = $gOptions{$attribute}{"options"}; 
			for my $optionIndex ( keys (%$OptHash) ){
				my $Test = $gOptions{$attribute}{"options"}{$optionIndex}{"alias"};
				if ( $Test && $Test =~ /^$choice$/ ) {
					$gChoices{$attribute} = $optionIndex;	# Update hash entry
					$choice = $optionIndex;					# Update $choice too!
					$allok = 1;
					if ( $attribute =~ /rotate/ ) {
						$gRotate = $optionIndex;
					}
					if ( $choice =~ /\|/ ) {
						my $extradata = $choice; 
						my $value = $choice;
						$value =~ s/\|.*$//g; 
						$extradata =~ s/^.*\|//g; 
						$extradata =~ s/^.*\|//g; 
						$gChoices{$attribute}=$value ;
						$gExtraDataSpecd{$attribute} = $extradata; # Additional data
					} else {
						$gExtraDataSpecd{$attribute} = ""; # Additional data
					}
					# Make sure that this opt name string (from alias) is in options hash!
					if( ! defined( $gOptions{$attribute}{"options"}{$choice} )) {
						$allok = 0;
					}
					last;	# found alias so exit this inner "for" loop (alias is unique!)
				}
			}
		}
		if ( ! $allok ){ 
			$ThisError  = "\nERROR: Choice $choice (for attribute $attribute, defined \n"; 
			$ThisError .=   "       in choice file $gChoiceFile), is not defined \n"; 
			$ThisError .=   "       in options file ($gOptionFile)\n";
			$ErrorBuffer .= $ThisError; 
			stream_out( $ThisError );
		} else {
			debug_out ( "   - found \$gOptions{\"$attribute\"}{\"options\"}{\"$choice\"} \n"); 
		}
	}
	
	if ( ! $allok ){ 
		fatalerror ( "" );
	}
}

# Check if extra run required for ERS conditions ...
my $gNumRunSetsRqd = 1;
my $gHRVctl = $gChoices{"OPT-HRV_ctl"};
my $gElecLS = $gChoices{"Opt-ElecLoadScale"};
my $gDHWLS  = $gChoices{"Opt-DHWLoadScale"};

if ( $gERSCalcMode ) {
	if ( $gElecLS =~ /"NoReduction"/ && $gDHWLS =~ /"OLDERS"/ ) {
		# Conditions already set correctly to calculate ERS!
		$gNumRunSetsRqd = 1;
	} else {
		$gNumRunSetsRqd = 2;
        $gChoices{"OPT-HRV_ctl"} = "ERSp3ACH";
		$gChoices{"Opt-ElecLoadScale"} = "NoReduction";
		$gChoices{"Opt-DHWLoadScale"} = "OldERS";
	}
}


for ( my $iRun = 1; $iRun <= $gNumRunSetsRqd; $iRun++ ) {

	# Now we need to process conditions. Note that we need to redo the %gChoices loop. The loop
	# above ensured that, if Dakota aliases where used, all aliases were replaced with valid 
	# option string names. Conditions can use multiple option string names and we can't ensure
	# the order of processing above!
	VALCHOICES: while ( my ( $attribute, $choice) = each %gChoices ){	

		my $ValRef = $gOptions{$attribute}{"options"}{$choice}{"values"}; 
		
		if (defined ($ValRef)){
			my %ValHash = %$ValRef; 
		  
			for my $ValueIndex (keys %ValHash){
			
				# for each value, check if corresponding conditions are valid
				my $CondRef = $gOptions{$attribute}{"options"}{$choice}{"values"}{$ValueIndex}{"conditions"}; 
				my %CondHash = %$CondRef; 
		  
				# Check for 'all' conditions
				my $ValidConditionFound = 0;
			  
				if ( defined( $CondHash{"all"} ) ) { 
					debug_out ("   - VALINDEX: $ValueIndex : found valid condition: \"all\" !\n");
					$gOptions{$attribute}{"options"}{$choice}{"result"}{$ValueIndex} = $CondHash{"all"};
					$ValidConditionFound = 1; 
				} else {
					# Loop through hash 
					for my $conditions ( keys %CondHash ) {
						if ($conditions !~ /else/ ){ 
							debug_out ( " >>>>> Testing |$conditions| <<<\n" ) ; 
							my $valid_condition = 1; 
							foreach my $condition (split /;/, $conditions ){
								debug_out ("      $condition \n"); 
								my ($TestAttribute, $TestValueList) = split /=/, $condition; 
								if ( ! $TestValueList ) {
									$TestValueList = "XXXX";
								}
								my @TestValueArray = split /\|/, $TestValueList;
								my $thesevalsmatch =0; 
								foreach my $TestValue (@TestValueArray){
									if ( $gChoices{$TestAttribute} =~ /$TestValue/ ) { 
										$thesevalsmatch = 1; 
									}
						 
									debug_out ("      \$gChoices{".$TestAttribute."} = ".$gChoices{$TestAttribute}." / $TestValue / -> $thesevalsmatch \n"); 
								}
								if ( ! $thesevalsmatch ){
									$valid_condition = 0;
								}
							}
							if ( $valid_condition ) { 
								$gOptions{$attribute}{"options"}{$choice}{"result"}{$ValueIndex}  = $CondHash{$conditions};
								$ValidConditionFound = 1; 
								debug_out ("   - VALINDEX: $ValueIndex : found valid condition: \"$conditions\" !\n");
							}
						}
					}
				}
				# Check if else condition exists. 
				if ( ! $ValidConditionFound ) {
					debug_out ("Looking for else!: ".$CondHash{"else"}."<\n" ); 
					if ( defined( $CondHash{"else"} ) ){
						$gOptions{$attribute}{"options"}{$choice}{"result"}{$ValueIndex} = $CondHash{"else"};
						$ValidConditionFound = 1;
						debug_out ("   - VALINDEX: $ValueIndex : found valid condition: \"else\" !\n");
					}
				}
			  
				if ( ! $ValidConditionFound ) {
					$ThisError  = "\nERROR: No valid conditions were defined for $attribute \n";
					$ThisError .=   "       in options file ($gOptionFile). Choices must match one \n";
					$ThisError .=   "       of the following:\n";
					for my $conditions ( keys %CondHash ) {
						$ThisError .=   "            -> $conditions \n" ;
					}

					$ErrorBuffer .= $ThisError; 
					stream_out( $ThisError );  
			 
					$allok = 0; 
				} else {
					$allok = 1;
				}
			}
		}
		
		# Check conditions on external entities that are not 'value' or 'cost' ...
		my $ExtRef = $gOptions{$attribute}{"options"}{$choice}; 
		my %ExtHash = %$ExtRef;
	   
		foreach my $ExternalParam ( keys %ExtHash ){
			
			if ( $ExternalParam =~ /production/ ){
				
				my $CondRef = $gOptions{$attribute}{"options"}{$choice}{$ExternalParam}{"conditions"}; 
				my %CondHash = %$CondRef; 
		  
				# Check for 'all' conditions
				my $ValidConditionFound = 0;
			  
				if ( defined( $CondHash{"all"} ) ) { 
					debug_out ("   - EXTPARAM: $ExternalParam : found valid condition: \"all\" ! (".$CondHash{"all"}.")\n");
					$gOptions{$attribute}{"options"}{$choice}{"ext-result"}{$ExternalParam} = $CondHash{"all"};
					$ValidConditionFound = 1; 
					
				} else {
				
					# Loop through hash 
				
					for my $conditions ( keys %CondHash ) {
						
						#debug_out ( " >>>>> Testing $conditions \n" ) ; 
					
						my $valid_condition = 1; 
						foreach my $condition (split /;/, $conditions ){
							
						#debug_out ("      $condition \n"); 
						my ($TestAttribute, $TestValueList) = split /=/, $condition; 
						if ( ! $TestValueList ) {
							$TestValueList = "XXXX";
						}
						my @TestValueArray = split /\|/, $TestValueList;
						my $thesevalsmatch =0; 
						foreach my $TestValue (@TestValueArray){
							if ( $gChoices{$TestAttribute} =~ /$TestValue/ ) { 
								$thesevalsmatch = 1; 
							}
						 
							#debug_out ("      \$gChoices{".$TestAttribute."} = ".$gChoices{$TestAttribute}." / $TestValue / -> $thesevalsmatch \n"); 
						}
						if ( ! $thesevalsmatch ){
							$valid_condition = 0;
						}
						}
						
						if ( $valid_condition ) { 
							$gOptions{$attribute}{"options"}{$choice}{"ext-result"}{$ExternalParam}= $CondHash{$conditions};
							$ValidConditionFound = 1; 
							debug_out ("   - EXTPARAM: $ExternalParam : found valid condition: \"$conditions\" (".$CondHash{$conditions}.")\n");
						}

					}
				
				}
				
				# Check if else condition exists. 
				if ( ! $ValidConditionFound ) {
					if ( defined( $CondHash{"else"} ) ){
						$gOptions{$attribute}{"options"}{$choice}{"ext-result"}{$ExternalParam} = $CondHash{"else"};
						$ValidConditionFound = 1;
						debug_out ("   - EXTPARAM: $ExternalParam : found valid condition: \"else\" ! (".$CondHash{"else"}.")\n");
					}
				}
			  
				if ( ! $ValidConditionFound ) {
					$ThisError  = "\nERROR: No valid conditions were defined for $attribute \n";
					$ThisError .=   "       in options file ($gOptionFile). Choices must match one \n";
					$ThisError .=   "       of the following:\n";
					for my $conditions ( keys %CondHash ) {
						$ThisError .=  "            -> $conditions \n" ;
					}
					
					$ErrorBuffer .= $ThisError; 
					stream_out( $ThisError );            
					
					$allok = 0; 
				} else {
					$allok = 1;
				}
			}
		}
		
		#debug_out (" >>>>> ".$gOptions{$attribute}{"options"}{$choice}{"result"}{"production-elec-perKW"}."\n"); 
	  
		my ($BaseOption,$ScaleFactor,$BaseChoice,$BaseCost);
	  
		# This section implements the multiply-cost 
	  
		if ($allok ){
		   
			my $cost = $gOptions{$attribute}{"options"}{$choice}{"cost"};
			my $cost_type = $gOptions{$attribute}{"options"}{$choice}{"cost-type"};
			my $repcost = defined( $cost ) ? $cost : "?" ; 
		    
			if ( ! defined ($cost_type) ){ $cost_type = "" ; }
			if ( ! defined ($cost) ){ $cost = "" ; }
			debug_out ("   - found cost: \$$cost ($cost_type) \n"); 
		
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
				$gOptions{$attribute}{"options"}{$choice}{"cost"} = $CompCost; 
			}
		
			$cost = $gOptions{$attribute}{"options"}{$choice}{"cost"} ;
			if ( ! defined ($cost) ){ $cost = "0" ; }
			if ( ! defined ($cost_type) ){ $cost_type = "" ; }
			debug_out ( "\n\nMAPPING for $attribute = $choice (@ \$".
					 round($cost).
					 " inc. cost [$cost_type] ): \n"); 
			if ( $ScaleCost ){
				debug_out (     "  (cost computed as $ScaleFactor *  ".round($BaseCost)." [cost of $BaseChoice])\n");
			}
		}
	   
		# Check on value of error flag before continuing with while loop
		# (the flag may be reset in the next iteration!)
		if ( ! $allok ) {
			last VALCHOICES;	# exit the loop - don't process rest of choices against options
		}
	}


	# Seems like we've found everything!


	if ( ! $allok ) { 

		stream_out("\n--------------------------------------------------------------\n");
		stream_out("\nSubstitute.pl encountered the following errors:\n"); 
		stream_out($ErrorBuffer); 

		fatalerror(" Choices in $gChoiceFile do not match options in $gOptionFile!");
	} else {
		stream_out (" done.\n");
	} 


	# Now create a copy of our base ESP-r file for manipulation. 
	stream_out("\n\n Creating a working folder for optimization work...");
	if ( ! $gSkipSims ) {
	  system ("rm -fr $gWorkingModelFolder ");
	  system ("cp -fr $gBaseModelFolder $gWorkingModelFolder ");
	}
	stream_out("done.\n");


	# This cmd seems to duplicate definition of $master_path above.
	$gMasterPath = getcwd();

	# Optimization runs need climate files, which will vary between linux and 
	# windows systems. We need to find the approprate climate folder, and link to it 
	# within the model directory. 
	#
	# Check to see if working folder contains link to climate directory
	# 

	debug_out ("? cwd ?: $gMasterPath / $master_path \n"); 

	my $system = `uname`; 
	debug_out (">>>System is $system \n"); 
	my $source_clm_dir="UNKNOWN"; 
	my $clm_link_target = ""; 
	if ( $system =~ /cygwin/i ) {$source_clm_dir = "climate_cygwin";}
	if ( $system =~ /linux/i ) {$source_clm_dir = "climate_linux";}
	debug_out ( " Creating link to $source_clm_dir \n "); 

	# Find the approprate path. If substitute has been invoked directly, 
	# Cli
	if  ( -d "$gMasterPath/$source_clm_dir" ) {
		debug_out ( "Found $gMasterPath/$source_clm_dir. Linking (a).\n");
		$clm_link_target = "$gMasterPath/$source_clm_dir"; 
	}
	# Fi
	elsif ( -d "$gMasterPath/../$source_clm_dir" ) {
		debug_out ( "Found $gMasterPath/../$source_clm_dir. Linking (b).\n");
		$clm_link_target = "$gMasterPath/../$source_clm_dir"; 
	}
	else {
		debug_out ( "Could not find $source_clm_dir. \n");
		
		$ThisError  = "\nERROR: Climate file directory ($source_clm_dir) could not be found.  \n"; 
		$ErrorBuffer .= $ThisError; 
		debug_out ( "$ThisError \n");
		$allok = 0; 
		fatalerror ( " Could not locate climate files !" ); 
	  
	}

	# Now create the link

	stream_out ("Linking  $clm_link_target $gWorkingModelFolder/climate -> $clm_link_target"); 
	if ( $system =~ /linux/i ) {
	  execute ( "cp -fr  $clm_link_target $gWorkingModelFolder/climate "); 
	}else{
	  execute ( "ln -s  $clm_link_target $gWorkingModelFolder/climate ");
	}


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




	# Could allow SE/NE/SW/NW here, or even NNE, ENE, ESE, SSE. Note that our solar calculations will not reflect 
	# orientation changes. For now, we assume the arrays must always point south.
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

	# Defined at top and zeroed here because if we are running multiple orientations, 
	# we must average them as we go.	   
	$gAvgCost_NatGas    		= 0;
	$gAvgCost_Electr    		= 0;
	$gAvgEnergy_Total   		= 0; 
	$gAvgCost_Propane   		= 0;
	$gAvgCost_Oil       		= 0;
	$gAvgCost_Wood      		= 0;
	$gAvgCost_Pellet    		= 0;
	$gAvgPVRevenue      		= 0; 
	$gAvgElecCons_KWh    		= 0; 
	$gAvgPVOutput_kWh			= 0; 
	$gAvgCost_Total				= 0; 
	$gAvgEnergyHeatingGJ		= 0; 
	$gAvgEnergyCoolingGJ		= 0; 
	$gAvgEnergyVentilationGJ	= 0; 
	$gAvgEnergyWaterHeatingGJ	= 0; 
	$gAvgEnergyEquipmentGJ		= 0; 
	$gAvgNGasCons_m3			= 0; 
	$gAvgOilCons_l				= 0; 
	$gAvgPropCons_l				= 0; 
	$gAvgPelletCons_tonne		= 0; 
	$gDirection                 ="";
	$gEnergyHeatingElec 		= 0;
	$gEnergyVentElec            = 0;
	$gEnergyHeatingFossil 		= 0;
	$gEnergyWaterHeatingElec 	= 0;
	$gEnergyWaterHeatingFossil 	= 0;
	$gAvgEnergyHeatingElec 		= 0;
	$gAvgEnergyVentElec         = 0;
	$gAvgEnergyHeatingFossil 	= 0;
	$gAvgEnergyWaterHeatingElec = 0;
	$gAvgEnergyWaterHeatingFossil = 0;
	$gAmtWood = 0;
	$gAmtOil = 0;
	
	UpdateCon();  
	 
	for my $Direction  ( @Orientations ){

		$gDirection = $Direction; 

		if ( ! $gSkipSims ) { 
		
			runsims( $angles{$Direction} ); 
			
		}
		
		postprocess($ScaleResults);
	}
	
	# Currently the ERS number is NOT being averaged when all 4 orientations are run.  The calculation
	# that follows uses the results of the last orientation run!
	if ( $gERSCalcMode && $iRun == 1 ) {
		# Calculate ERS number for output. All energy values in MJ
		my $SpcElecEnergy = ( $gAvgEnergyHeatingElec + $gAvgEnergyVentElec ) * 1000.;
		my $SpcFuelEnergy = $gAvgEnergyHeatingFossil * 1000.;
		# NG/Propane:0.90, Oil:0.83, All Wood:0.75
		my $FuelEff = $gEnergyTotalWood > 0 ? 0.75 : $gAmtOil > 0 ? 0.83 : 0.90;
		my $SpcHtConsump = $SpcElecEnergy * 1.0 + $SpcFuelEnergy * $FuelEff;  
		my $DHWElec = $gAvgEnergyWaterHeatingElec * 1000.;
		my $DHWFuel = $gAvgEnergyWaterHeatingFossil * 1000.;
		my $OccConsump = 1.136 * ( $DHWElec * 0.88 + $DHWFuel * 0.57 );
		my $EstTotEnergy = $SpcHtConsump + $OccConsump - $gAvgPVOutput_kWh*3.6;
		$EstTotEnergy = $EstTotEnergy < 0 ? 0.0 : $EstTotEnergy;
		
		my $Locale = $gChoices{"Opt-Location"};
		my $HseVol = $gOptions{"Opt-geometry"}{"options"}{$gChoices{"Opt-geometry"}}{"values"}{17}{"conditions"}{"all"};
		my $HDD =$RegionalHDD{$Locale};
		my $SpcHtBM = 3.6 * ( 49. * $HDD / 6000. ) * ( 40. + $HseVol / 2.5 );
		my $TempWM = $RegionalWaterMainTemp{$Locale};
		my $DHWBM = 1.136 * 17082. * (5. - $TempWM) / (55. - 9.5);
		my $BaseLdBM = 31536.;
		my $BenchmarkTotEnergy = $SpcHtBM + $DHWBM + $BaseLdBM;
		
		$gERSNum = 100 - ( $EstTotEnergy / $BenchmarkTotEnergy ) * 20;
		
		# Set back the choices to original values, if necessary (for 2nd run)!
		if ( $gNumRunSetsRqd == 2 ) {
            $gChoices{"OPT-HRV_ctl"} = $gHRVctl;
			$gChoices{"Opt-ElecLoadScale"} = $gElecLS;
			$gChoices{"Opt-DHWLoadScale"} = $gDHWLS;
		}
	}	
	
}	# End of loop controlling ERS run (1 or 2 runs).

$gAvgCost_Total   = $gAvgCost_Electr + $gAvgCost_NatGas + $gAvgCost_Propane + $gAvgCost_Oil + $gAvgCost_Wood + $gAvgCost_Pellet ;

$gAvgPVRevenue =  $gAvgPVOutput_kWh * $PVTarrifDollarsPerkWh ;  

my $payback ; 
my $gAvgUtilCostNet = $gAvgCost_Total - $gAvgPVRevenue; 

my $gUpgCost    = $gTotalCost - $gIncBaseCosts; 
my $gUpgSavings = $gUtilityBaseCost - $gAvgUtilCostNet ; 


if ( abs( $gUpgSavings ) < 1.00 ) {
  # Savings are practically zero. Set payback to a very large number. 
  $payback = 10000.;

# Case when upgrade is cheaper than base cost
} elsif ( $gTotalCost< $gIncBaseCosts) { 

    # Does it also save on bills? 
    if ( $gUpgSavings > 0. ) { 
    
        # No-brainer. Payback should be zero.
     
        $payback = 0 ;
     
    }else{
    
        # it may be cheap, but it costs in the long run. set 
        # payback to a very large #.
        
        $payback = 100000.; 
        
    }

} else { 

  # Compute payback. 
  $payback = ($gTotalCost-$gIncBaseCosts)/($gUtilityBaseCost-($gAvgCost_Total-$gAvgPVRevenue)) ; 
  
  # Paybacks can be less than zero if design costs more in utility bills. Set negative paybacks to very large numbers.
  if ( $payback < 0 ){$payback = 100000.;}
  
}

# Proxy for cost of ownership 
$payback = $gAvgUtilCostNet + ($gTotalCost-$gIncBaseCosts)/25.; 

open (SUMMARY, ">$gMasterPath/SubstitutePL-output.txt") or fatalerror ("Could not open $gMasterPath/SubstitutePL-output.txt");


my $PVcapacity = $gChoices{"Opt-StandoffPV"}; 

$PVcapacity =~ s/[a-zA-Z:\s'\|]//g;

if (! $PVcapacity ) { 
	$PVcapacity = 0. ; 
}

if ( $gDakota ) {

    print SUMMARY "$gAvgEnergy_Total \n"; 
    print SUMMARY "$gAvgCost_Total   \n";
    print SUMMARY "$gAvgPVRevenue    \n"; 
    print SUMMARY "".eval($gAvgCost_Total-$gAvgPVRevenue). "\n"; 
    print SUMMARY "$gAvgCost_Electr  \n";
    print SUMMARY "$gAvgCost_NatGas  \n";
    print SUMMARY "$gAvgCost_Propane \n";
    print SUMMARY "$gAvgCost_Oil \n";
	print SUMMARY "$gAvgCost_Wood \n";
	print SUMMARY "$gAvgCost_Pellet \n";

    print SUMMARY "$gAvgPVOutput_kWh \n";
    #print SUMMARY "$gEnergySDHW \n";
    print SUMMARY "$gAvgEnergyHeatingGJ \n";
    print SUMMARY "$gAvgEnergyCoolingGJ \n";
    print SUMMARY "$gAvgEnergyVentilationGJ \n";
    print SUMMARY "$gAvgEnergyWaterHeatingGJ \n";
    print SUMMARY "$gAvgEnergyEquipmentGJ \n";  
    print SUMMARY "$gAvgElecCons_KWh \n";
    print SUMMARY "$gAvgNGasCons_m3  \n";
    print SUMMARY "$gAvgOilCons_l    \n";
  	print SUMMARY "$gAvgPelletCons_tonne   \n";
	
	print SUMMARY "".eval($gTotalCost-$gIncBaseCosts)."\n"; 
    print SUMMARY "". $payback ."\n"; 

    print SUMMARY "".$PVcapacity."\n"; 
	
	if ( $gERSCalcMode ) {
		print SUMMARY "$gERSNum \n";
	}

} else {

    print SUMMARY "Energy-Total-GJ   =  $gAvgEnergy_Total \n"; 
    print SUMMARY "Util-Bill-gross   =  $gAvgCost_Total   \n";
    print SUMMARY "Util-PV-revenue   =  $gAvgPVRevenue    \n"; 
    print SUMMARY "Util-Bill-Net     =  ".eval($gAvgCost_Total-$gAvgPVRevenue). "\n"; 
    print SUMMARY "Util-Bill-Elec    =  $gAvgCost_Electr  \n";
    print SUMMARY "Util-Bill-Gas     =  $gAvgCost_NatGas  \n";
    print SUMMARY "Util-Bill-Prop    =  $gAvgCost_Propane \n";
    print SUMMARY "Util-Bill-Oil     =  $gAvgCost_Oil \n";
	print SUMMARY "Util-Bill-Wood    =  $gAvgCost_Wood \n";
	print SUMMARY "Util-Bill-Pellet  =  $gAvgCost_Pellet \n";

    print SUMMARY "Energy-PV-kWh     =  $gAvgPVOutput_kWh \n";
    #print SUMMARY "Energy-SDHW      =  $gEnergySDHW \n";
    print SUMMARY "Energy-HeatingGJ  =  $gAvgEnergyHeatingGJ \n";
    print SUMMARY "Energy-CoolingGJ  =  $gAvgEnergyCoolingGJ \n";
    print SUMMARY "Energy-VentGJ     =  $gAvgEnergyVentilationGJ \n";
    print SUMMARY "Energy-DHWGJ      =  $gAvgEnergyWaterHeatingGJ \n";
    print SUMMARY "Energy-PlugGJ     =  $gAvgEnergyEquipmentGJ \n";  
    print SUMMARY "EnergyEleckWh     =  $gAvgElecCons_KWh \n";
    print SUMMARY "EnergyGasM3       =  $gAvgNGasCons_m3  \n";
    print SUMMARY "EnergyOil_l       =  $gAvgOilCons_l    \n";
	print SUMMARY "EnergyPellet_t    =  $gAvgPelletCons_tonne   \n";
    print SUMMARY "Upgrade-cost      =  ".eval($gTotalCost-$gIncBaseCosts)."\n"; 
    print SUMMARY "SimplePaybackYrs  =  ". $payback ."\n"; 
    
	my $PVcapacity = $gChoices{"Opt-StandoffPV"}; 

	$PVcapacity =~ s/[a-zA-Z:\s'\|]//g;
	if (! $PVcapacity ) { 
		$PVcapacity = 0. ; 
	}

    print SUMMARY "PV-size-kW      =  ".$PVcapacity."\n"; 

	if ( $gERSCalcMode ) {
		print SUMMARY "ERS-Value         =  ". $gERSNum."\n";
	}

}

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
    my $matched =0;
	my $linecopy = $line;   
    
    foreach my $attribute ( @gChoiceOrder ){

      if ( $gOptions{$attribute}{"type"} eq "internal" ){
            
        my $choice =  $gChoices{$attribute};
        
        my $tagHash = $gOptions{$attribute}{"tags"};
        my $valHash = $gOptions{$attribute}{"options"}{$choice}{"result"};
        
        for my $tagIndex ( keys ( %{$tagHash} ) ){
          my $tag   = ${$tagHash}{$tagIndex};
          my $value = ${$valHash}{$tagIndex};
          if (!defined($value)){
		     debug_out (">>>ERR on $tag\n");
			 $value = "";
		  }        
          if ( $line =~ /$tag/ ){ 
		    $matched = 1; 
		  }
          $line =~ s/$tag/$value/g; 
        }
        
      }
	  
    }
    # if ($matched ){debug_out("> $linecopy| $line");}
    push @file_contents, $line;
 
  }
  
  close(READIN);
  
  open(WRITEOUT,">$file_path") or fatalerror("Could not open $file_path for writing!");

  print WRITEOUT @file_contents;
  
  close(WRITEOUT);
  
  chdir $startpath; 
  
}


sub UpdateCon(){

	chdir $gWorkingCfgPath;
	debug_out ("\n\n Moved to path:". getcwd()."\n"); 
  
	# Update con files. 
	if ( ! $gSkipPRJ && ! $gSkipSims ) {

		# Update construction files 
		stream_out ("\n\n Invoking prj to update con files (\"$gPRJZoneConCmd\")...");
		execute($gPRJZoneConCmd);
		stream_out ("done. \n");  
	}
	
}


sub runsims($){

	my ($RotationAngle) = @_;

	# Save rotation angle for reporting
	$gRotationAngle = $RotationAngle; 
  
	chdir $gWorkingCfgPath; 
   
	#execute("rm ../zones/*.con ../zones/*.tmc ../zones/*.shd ../zones/*.shda "); 
	if ( ! $gSkipSims ) { 
		execute ("rm out.*"); 
	}
  
	debug_out ("\n\n Moved to path:". getcwd()."\n"); 

	# Spin the model 
	if ( ! $gSkipPRJ ) {

		stream_out("\n\n Involing prj to rotate the model by $RotationAngle degrees (\"$gPRJZoneRotCmd $RotationAngle\")...");
		execute("$gPRJZoneRotCmd $RotationAngle"); 
		stream_out ("done. \n");   
	}

	# Loop through zone shading status flag, and regenerate
	# shading for any 'shaded zones' using ish. 



	open(CFG_FILE, "$gModelCfgFile" ) or fatalerror("Could not open $gModelCfgFile!");


	my %zone_shading_status; 
	my $zone_number; 
	while ( my $line = <CFG_FILE> ) {
		# rename results libraries for consistency


		#--------------------------------------------
		# Save zone geo file paths & shading tags
		# for use when regenerating shading files.
		#--------------------------------------------

    
		# If line describes zone #, parse number
		if ($line =~ /^\*zon\s+/ ){
			$zone_number = $line;
			$zone_number =~ s/^\s*\*zon\s+([0-9]+).*$/$1/g;
			$zone_number =~ s/\s*\n*//g;
			debug_out ("> ZONE $zone_number / $line \n"); 
			# initialize zone shading file flag to zero.
			$zone_shading_status{$zone_number} = 0;
		}
    
		# If line describes zone geometry record, save
		#   in zone geo buffer.
		#if ( $line =~ /^\*geo\s+/ ){
		#  $zone_geo_files{$zone_number} = $line;
		#  $zone_geo_files{$zone_number} =~ s/^\*geo\s+([^\s]+).*$/$1/g;
		#}

		# Check if line describes zone shading file, and set flag

		if ( $line =~ /\*isi\s+/ ){
			$zone_shading_status{$zone_number} = 1;
		stream_out (" -> Found shading for zone # $zone_number  / $line \n"); 
		}
	}
	
	close (CFG_FILE);
  
	while ( my($zone,$regen) = each ( %zone_shading_status ) ){
		if ( $regen ) {
			stream_out("\n\n Invoking ish via run.sh...");
			stream_out("   Regenerating shading files for zone $zone using ish"); 
			my $cmd = "~/esp-r/bin/ish -mode text -file $gModelCfgFile -zone $zone -act update_silent";
			execute($cmd);      
			stream_out("   Done.\n");
		}
		stream_out ("done. \n");         
	}        

	stream_out ("\n\n Invoking ESP-r (\"$gBPScmd\")..." );
	execute($gBPScmd); 
          
	# Save output files
	if ( ! -d "$gMasterPath/sim-output" ) {
		execute("mkdir $gMasterPath/sim-output") or debug_out ("Could not create $gMasterPath/sim-output!\n"); 
	}
	 
	if ( -d "$gMasterPath/sim-output") { 
		execute("cp $gMasterPath/$gWorkingCfgPath/out* $gMasterPath/sim-output/");
	}
         
	# # Cleanup
	# debug_out("\n\n Deleting working folder...");
	#  #system ("rm -fr $gWorkingModelFolder ");
	#  debug_out("done.");ls 
  
	chdir $gMasterPath;
	
} 

  
sub postprocess($){
  
  my ($ScaleData) = @_; 

  
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

  my $ElecRateEsc = 1.0; # 1.49; 

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

  #=======================================================================                           
  # Fuel cost parameters: 

  my $NGasIncreaseFrac    = 1.0; #1.53;      # Scale for future forecast

  
  my $NGasFixedCharge; 
  my $NGasSupplyCharge; 
  my %NGasDeliveryTier; 
  my $NGasTrasportCharge;
  
  my $ElecFixedCharge; 
  my $ElecTotalOtherCharges; 
  
  my $OilFixedCharge      = 0.0 ; 
##  my $OilSupplyCharge     = 1.34;    # Whitehorse cost of furnace oil / arctic stove oil is $1.34/l  (Yukon energy statistics)

  # Adding Local Oil costs
  my %OilSupplyCharge   = (  "Halifax"      =>  0.0 ,
                             "Edmonton"     =>  0.0 ,
                             "Calgary"      =>  0.0 ,
                             "Vancouver"    =>  0.0 ,
                             "PrinceGeorge" =>  0.0 ,
                             "Kamloops"     =>  0.0 ,
                             "Ottawa"       =>  0.0 , 
                             "Regina"       =>  0.0 ,
                             "Winnipeg"     =>  0.0 ,
                             "Fredricton"   =>  0.0 ,
                             "Whitehorse"   =>  1.34 ,
                             "Yellowknife"  =>  1.28 ,
							 "Inuvik"       =>  1.50 ); 
    
  my $OilTransportCharge;
  my $OilDeliveryCharge; 
  
  my $PropaneFixedCharge     = 0.0 ; 
  my $PropaneSupplyCharge    = 0.855;   # Yukon cost of propane supply (LPG) $0.855 per litre. YK bureau of statistics.Aug 2013. http://www.eco.gov.yk.ca/stats/pdf/fuel_aug13.pdf  1l of LPG expands to about 270l gaseous propane at 1bar. 
  my $PropaneDeliveryCharge; 
  my $PropaneTrasportCharge;
  
  my $WoodFixedCharge = 0.0; 
  my $WoodSupplyCharge    = 325.0 ;  # Northern Fuel Cost Library Spring 2014 # 260.0;   ESC Heat Info Sheet - Assumes 18700 MJ / cord
#  my %WoodDeliveryTier; 
#  my $WoodTrasportCharge;
  
  my $PelletsFixedCharge = 0.0; 
  my $PelletsSupplyCharge    =  337.0  ; # Northern Fuel Cost Library Spring 2014  #340.0;   ESC Heat Info Sheet - Assumes 18000 MJ/ton of pellets
#  my %PelletsDeliveryTier; 
#  my $PelletsTrasportCharge;
  
  my $NGTierType;  

  # Assume summer and winter rates are the same. 
  #$ElecPeakCharges{"winter"}{"off-peak"} = $ElecPeakCharges{"summer"}{"off-peak"} ;
  #$ElecPeakCharges{"winter"}{"mid-peak"} = $ElecPeakCharges{"summer"}{"mid-peak"} ;
  #s$ElecPeakCharges{"winter"}{"on-peak"}  = $ElecPeakCharges{"summer"}{"on-peak"}  ;
  
  
  
  
  #_------------------------- New rates ! -------------------------
  
   
  # Base charges for electricity ($/month)
  my %Elec_BaseCharge = ( "Halifax"      =>  10.83  ,
                          "Edmonton"     =>  21.93  ,
                          "Calgary"      =>  17.55  ,
                          "Ottawa"       =>  9.42   ,
                          "Toronto"      =>  18.93  ,
                          "Quebec"       =>  12.36  ,
                          "Montreal"     =>  12.36  ,
                          "Vancouver"    =>  4.58   ,
						  "PrinceGeorge" =>  4.58   ,
						  "Kamloops"     =>  4.58   ,
                          "Regina"       =>  20.22  ,
                          "Winnipeg"     =>  6.85   ,
                          "Fredricton"   =>  19.73  ,
                          "Whitehorse"   =>  16.25  ,
                          "Yellowknife"  =>  18.52  , #From Artic Energy Alliance Spring 2014
						  "Inuvik"       =>  18.00    ); #From Artic Energy Alliance Spring 2014
	
  # Base charges for natural gas ($/month)
  my %NG_BaseCharge = ( "Halifax"      =>  21.87 ,
                        "Edmonton"     =>  28.44 ,
                        "Calgary"      =>  28.44 ,
                        "Ottawa"       =>  20.00 ,
                        "Toronto"      =>  20.00 ,
                        "Quebec"       =>  14.01 ,
                        "Montreal"     =>  14.01 ,
                        "Vancouver"    =>  11.83 ,
						"Kamloops"     =>  11.83 ,
						"PrinceGeorge" =>  11.83 ,
                        "Regina"       =>  18.85 ,
                        "Winnipeg"     =>  14.00 ,
                        "Fredricton"   =>  16.00 ,
                        "Whitehorse"   =>  "nil" ,
                        "Yellowknife"  =>  "nil" , ,
						"Inuvik"       =>  "nil"  ); 	

   my %Elec_TierType  = ( "Halifax"      =>  "none" ,
                          "Edmonton"     =>  "none" ,
                          "Calgary"      =>  "none" ,
                          "Ottawa"       =>  "OntTOU" ,
                          "Toronto"      =>  "OntTOU" ,
                          "Quebec"       =>  "1-day" ,
                          "Montreal"     =>  "1-day" ,
                          "Vancouver"    =>  "2-month",
						  "PrinceGeorge" =>  "2-month",
						  "Kamloops"     =>  "2-month",
                          "Regina"       =>  "none" ,
                          "Winnipeg"     =>  "none" ,
                          "Fredricton"   =>  "none" ,
                          "Whitehorse"   =>  "1-month" ,
                          "Yellowknife"  =>  "none" ,
                          "Inuvik"       =>  "none"  );  
 
    my %NG_TierType  = (  "Halifax"      =>  "none" ,
                          "Edmonton"     =>  "none" ,
                          "Calgary"      =>  "none" ,
                          "Ottawa"       =>  "1-month" ,
                          "Toronto"      =>  "1-month" ,
                          "Quebec"       =>  "1-month" ,
                          "Montreal"     =>  "1-month" ,
                          "Vancouver"    =>  "none",
						  "PrinceGeorge" =>  "none",
						  "Kamloops"     =>  "none",
                          "Regina"       =>  "none" ,
                          "Winnipeg"     =>  "none" ,
                          "Fredricton"   =>  "none" ,
                          "Whitehorse"   =>  "NA"   ,
						  "Yellowknife"  =>  "NA"   ,
						  "Inuvik"       =>  "NA" ); 
 
    
    my %EffElectricRates = ( "Halifax"     => 0.1436 ,
                             "Edmonton"    => 0.1236 ,
                             "Calgary"     => 0.1224 ,
                             "Regina"      => 0.1113 ,
                             "Winnipeg"    => 0.0694 ,
                             "Fredricton"  => 0.0985 ,
                             "Yellowknife" => 0.29   , # Arctic Energy Alliance Spring 2014
							 "Inuvik"      => 0.29   ); # Arctic Energy Alliance Spring 2014
							 
    # TOU for Ottawa (As of May 2014), Toronto (Feb 2013).                        
    $EffElectricRates{"Ottawa"}{"off-peak"} =  0.1243 ;                        
    $EffElectricRates{"Ottawa"}{"mid-peak"} =  0.1626 ;
    $EffElectricRates{"Ottawa"}{"on-peak"}  =  0.1865 ;
        
    $EffElectricRates{"Toronto"}{"off-peak"} =  0.0967 ;  
    $EffElectricRates{"Toronto"}{"mid-peak"} =  0.1327 ;
    $EffElectricRates{"Toronto"}{"on-peak"}  =  0.1517 ;
  
    # Tiers for Montreal, Quebec 
    $EffElectricRates{"Montreal"}{"30"}   = 0.0532 ;
    $EffElectricRates{"Montreal"}{"9.9E99"} = 0.0751 ; 
    $EffElectricRates{"Quebec"} = $EffElectricRates{"Montreal"}; 
    
    # Tiers for Vancouver, PrinceGeorge and Kamloops
    $EffElectricRates{"Vancouver"}{"1350"} = 0.0714 ; 
    $EffElectricRates{"Vancouver"}{"9.9E99"} = 0.1070 ; 
    $EffElectricRates{"Kamloops"}{"1350"} = 0.0714 ; 
    $EffElectricRates{"Kamloops"}{"9.9E99"} = 0.1070 ;  
	$EffElectricRates{"PrinceGeorge"}{"1350"} = 0.0714 ; 
    $EffElectricRates{"PrinceGeorge"}{"9.9E99"} = 0.1070 ; 
 
    # Tiers for Whitehorse 
    $EffElectricRates{"Whitehorse"}{"1000"} =  0.0967 ; 
    $EffElectricRates{"Whitehorse"}{"2500"} =  0.1327 ;
    $EffElectricRates{"Whitehorse"}{"9.9E99"} =  0.1517 ;
  
    my %EffGasRates  = (  "Halifax"      =>  0.5124 ,
                          "Edmonton"     =>  0.1482 ,
                          "Calgary"      =>  0.1363 ,
                          "Vancouver"    =>  0.2923 ,
                          "PrinceGeorge" =>  0.2923 ,
                          "Kamloops"     =>  0.2923 ,
                          "Regina"       =>  0.2163 ,
                          "Winnipeg"     =>  0.2298 ,
                          "Fredricton"   =>  0.6458 ,
                          "Whitehorse"   =>  99999.9,
                          "Yellowknife"  =>  99999.9,
						  "Inuvik"       =>  99999.9 ); 
   
    # Tiers for Ottawa (Apr. 1, 2014), Toronto
    $EffGasRates{"Ottawa"}{"30"}     = 0.3090; 
    $EffGasRates{"Ottawa"}{"85"}     = 0.3043; 
    $EffGasRates{"Ottawa"}{"790"}    = 0.3006; 
    $EffGasRates{"Ottawa"}{"9.9E99"} = 0.2978;
    $EffGasRates{"Toronto"} = $EffGasRates{"Ottawa"} ; 
  
    # Tiers for Montreal, Quebec 
    $EffGasRates{"Montreal"}{"30"}     = 0.5001; 
    $EffGasRates{"Montreal"}{"100"}    = 0.4229; 
    $EffGasRates{"Montreal"}{"300"}    = 0.4106; 
    $EffGasRates{"Montreal"}{"9.9E99"} = 0.3749;
    $EffGasRates{"Quebec"} = $EffGasRates{"Montreal"} ; 
	
   
  
  # ------ READ IN Summary Data.                            
  
  my $gMasterPath = getcwd();

  # Move to working CFG directory, and parse out.summary file
  chdir $gWorkingCfgPath; 
  debug_out ("\n\n Moved to path:". getcwd()."\n"); 
  open (SIMRESULTS, "out.summary") or fatalerror("Could not open ".getcwd()."/out.summary!");

  my %gSimResults; 

  while ( my $line = <SIMRESULTS> ){

    my ( $token, $value, $units ) = split / /, $line; 
    
    if ( $units =~ /GJ/ || $units =~ /kWh\/s/ || $units =~ /m3\/s/ || $units =~ /l\/s/  || $units =~ /tonne\/s/ ) {
    
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

        
        #if ( $RowNumber == 0 ) {debug_out (" > header: >$header<\n");}
      }

      $RowNumber++;
      
    }
    
    
    
  }

  close (TSRESULTS);

  my $Locale = $gChoices{"Opt-Location"}; 
  
  
  if ( $SaveVPOutput ) {
    fcopy ( "out.csv","$gMasterPath/../VP-sim-output/$Locale-$gDirection-out.csv" );  
  }
  
  if ( $gCustomCostAdjustment ) { 
  
    $gRegionalCostAdj = $gCostAdjustmentFactor; 
  
  }else{
  
    $gRegionalCostAdj = $RegionalCostFactors{$Locale};
    
  }
  
  my $NumberOfRows = scalar(@{$data{$headers[0]}});

  stream_out("done (parsed $NumberOfRows rows)\n"); 

  # Recover electrical, natural gas, oil, propane, wood, or pellet consumption data 
  my @Electrical_Use = @{ $data{" total fuel use:electricity:all end uses:quantity (kWh/s)"} };
  my @NaturalGas_Use = @{ $data{" total fuel use:natural gas:all end uses:quantity (m3/s)"}  };
  my @Oil_Use        = @{ $data{" total fuel use:oil:all end uses:quantity (l/s)"}  };
  my @Propane_Use    = @{ $data{" total fuel use:propane:all end uses:quantity (m3/s)"}  };
  my @Wood_Use       = @{ $data{" total fuel use:mixed wood:all end uses:quantity (tonne/s)"}  };
  my @Pellets_Use    = @{ $data{" total fuel use:wood pellets:all end uses:quantity (tonne/s)"}  };
  #my @Wood_Use       = @{ $data{" total fuel use:wood:all end uses:quantity (cord/s)"}  };
  #my @Pellets_Use    = @{ $data{" total fuel use:pellets:all end uses:quantity (ton/s)"}  };
  # Recover Day, Hour & Month
  my @DayOfYear   = @{  $data{" building:day:future (day)"}     } ;
  my @HourOfDay   = @{  $data{" building:hour:future (hours)"}  } ;
  my @MonthOfYear = @{  $data{" building:month (-)"}            } ; 

  # Now loop through data and apply energy rates

  # Variables to track running tallies for energy consumption 
  my $row; 

  my $ElecConsumptionCost = 0; 
  my $MonthGasConsumption = 0; 
  my $GasConsumptionCost  = 0; 
  my $OilConsumptionCost  = 0; 
  my $PropaneConsumptionCost  = 0; 
  my $WoodConsumptionCost  = 0; 
  my $PelletsConsumptionCost  = 0; 

  my $GasCurrConsumpionForTiers = 0; 
  my $ElecCurrConsumpionForTiers = 0; 
  
  
  my $CurrDayOfWeek = $FirstDay_Day_Of_Week; 

  my $OldDay   = 1; 
  my $OldMonth = 1; 
  
  

  my $BiMonthCounter = 1; 

  for ( $row = 0; $row < $NumberOfRows; $row++){

    my $DayRollover = 0; 
    my $MonthRollover = 0; 
    my $BiMonthRollover = 0; 
  
    # Get current hour, day & month as integers
    my $CurrDay   =  int($DayOfYear[$row])   ;
    my $CurrMonth =  int($MonthOfYear[$row]) ;
    my $CurrHour  =  int($HourOfDay[$row])   ;  
   
    
    # Check to see if this is a new day, and increment day of week as needed
    if ( $CurrDay != $OldDay ) {
    
      $CurrDayOfWeek++; 
      
      $DayRollover = 1; 
      
      # Roll over week after 7 days. 
      if ( $CurrDayOfWeek > 7 ){ $CurrDayOfWeek = 1; }
      
      $OldDay = $CurrDay; 
    }
    
    # Check to see if this is a new month for billing tiers 
    if ( $CurrMonth != $OldMonth ) {
    
      $MonthRollover = 1;
      # Increment counter for bi-monthly billing periods       
      $BiMonthCounter++; 
      
      $OldMonth = $CurrMonth ; 
    
    }
    
    # Check to see if bimontly counter has reached 3 for bimonthly 
    # billing tiers. 
    if ( $BiMonthCounter > 2 ){
        $BiMonthRollover = 1; 
        $BiMonthCounter = 1; 
    } 
            
    
    # Determine if this is a weekday, weekend, or holiday for 
    # TOU calculations
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
    
    # For Tiered energy use, check tier type and possibly reset energy 
    # consumption for tier period 
    
    my $ElecTierType = $Elec_TierType{$Locale}; 
    my $GasTierType  = $NG_TierType{$Locale}; 
    if ( ( $ElecTierType eq "1-day"   && $DayRollover     ) || 
         ( $ElecTierType eq "1-month" && $MonthRollover   ) || 
         ( $ElecTierType eq "2-month" && $BiMonthRollover )    ){
       $ElecCurrConsumpionForTiers = 0; 
    }
    if ( ( $GasTierType eq "1-day"   && $DayRollover     ) || 
         ( $GasTierType eq "1-month" && $MonthRollover   ) || 
         ( $GasTierType eq "2-month" && $BiMonthRollover )    ){
       $GasCurrConsumpionForTiers = 0; 
    }    
    
    # ELECTRICITY---------------------------------------------------------
    
    # Now apply electrical rates.
    
    my $ElecConsumption = $Electrical_Use[$row] * $TSLength;  # kWh 
    
    my $EffElecRate; 
    
    if ( $Elec_TierType{$Locale} eq "none" ) {
      # No tier --- province has a single rate`   
      $EffElecRate = $EffElectricRates{$Locale}; 
      $ElecConsumptionCost += $ElecConsumption * $EffElecRate
    
    }elsif ( $Elec_TierType{$Locale} eq "OntTOU" ) {
      # Ontario TOU
      $EffElecRate = $EffElectricRates{$Locale}{$CurrPeakPeriod} ;
#      system ("echo $EffElecRate >> fileYouWantToPrintTo.txt") ; 
	  
      $ElecConsumptionCost += $ElecConsumption * $EffElecRate ; 
#      stream_out ( " S Charging $ElecConsumption kwh to tiers: ( TOU Period: $CurrPeakPeriod ) -> $ElecConsumptionCost @  $EffElecRate \n"); 
    }else {
      # Standard consumption tier. $ElecCurrConsumpionForTiers contains 
      # current consumption in Tier billing period.  
       
      my $ElecTiersRef = $EffElectricRates{$Locale}; 
      my %ElecTiers = %$ElecTiersRef; 
      my $Done = 0;  
      my $UnbilledConsumption = $ElecConsumption; 
 
      SKIPme: foreach my $tier (sort {$a <=> $b} (keys %ElecTiers)){

        my $BilledConsumption = 0; 
        # Rate for this tier: 
        $EffElecRate = $ElecTiers{$tier}; 
        
        if ( $ElecCurrConsumpionForTiers >= $tier ) { 
        
            # Next tier 
        
        }elsif ($UnbilledConsumption > 0.001 ) { 
        
          # Bill only for the amount that 'fits' in the current tier. 
          $BilledConsumption = 
              $ElecCurrConsumpionForTiers + $UnbilledConsumption > $tier ? 
              $tier - $ElecCurrConsumpionForTiers : $UnbilledConsumption   ; 
              
          # Save remaining amount of unbilled consumption for the 
          # next tier ( maybe zero). 
          
          $UnbilledConsumption -= $BilledConsumption; 

          # Add billed consumption to current amount in tier. 
          $ElecCurrConsumpionForTiers += $BilledConsumption; 
          
          # Compute cost of billed consumption
          $ElecConsumptionCost += $BilledConsumption * $EffElecRate ; 
          
        }
        
        
       # stream_out ( " >ELE Charging $ElecConsumption kwh to tiers: ( is $ElecCurrConsumpionForTiers > $tier ?) -> $BilledConsumption @  $EffElecRate \n"); 
        
        #stream_out ( "> Tiers: $tier \n" ); 
        #if ( $Done ) { last SKIPme; } 
      }
      
    }
    
         
    # Natural GAS ========================================================
    
    # Use current month's gas consumption to figure out tier of current 
    # gas consumption. 
    # stream_out ("> raw NG: $NaturalGas_Use[$row] \n"); 
    my $GasConsumption = $NaturalGas_Use[$row] < 0 ?
                         0 : $NaturalGas_Use[$row] * $TSLength; # M3
    
    #$$$$$$$$$$$$$$$$$$$$$$$$$$
    
    
    my $EffGasRate; 
    if ( $NG_TierType{$Locale} eq "NA" ) {
    
        if ($GasConsumption > 0.000001 ) {
          fatalerror ( " GAS FOUND ($GasConsumption m3), But no gas rate for $Locale !" ); 
        }else{
            $GasConsumptionCost  = 0; 
            $EffGasRate = 0; 
        }
    
    }elsif ( $NG_TierType{$Locale} eq "none" ) {
      # No tier --- province has a single rate`   
      $EffGasRate = $EffGasRates{$Locale}; 
      $GasConsumptionCost += $GasConsumption * $EffGasRate
    
    }else {
      # Standard consumption tier. $GasCurrConsumpionForTiers contains 
      # current consumption in Tier billing period.  
       
      my $GasTiersRef = $EffGasRates{$Locale}; 
      my %GasTiers = %$GasTiersRef; 
      my $UnbilledConsumption = $GasConsumption; 
      SKIPme: foreach my $tier (sort {$a <=> $b} (keys %GasTiers)){
     
        my $BilledConsumption = 0; 
        # Rate for this tier: 
        $EffGasRate = $GasTiers{$tier}; 
        
        if ( $GasCurrConsumpionForTiers >= $tier ) { 
        
            # Next tier 
        
        }elsif ($UnbilledConsumption > 0.001 ) { 
        
          # Bill only for the amount that 'fits' in the current tier. 
          $BilledConsumption = 
              $GasCurrConsumpionForTiers + $UnbilledConsumption > $tier ? 
              $tier - $GasCurrConsumpionForTiers : $UnbilledConsumption   ; 
              
          # Save remaining amount of unbilled consumption for the 
          # next tier ( maybe zero). 
          
          $UnbilledConsumption -= $BilledConsumption; 

          # Add billed consumption to current amount in tier. 
          $GasCurrConsumpionForTiers += $BilledConsumption; 
          
          # Compute cost of billed consumption
          $GasConsumptionCost += $BilledConsumption * $EffGasRate ; 
          
        }
        
        
        #print  " >GAS Charging $GasConsumption m3 to tiers: ( is $GasCurrConsumpionForTiers > $tier ?) -> $BilledConsumption @  $EffGasRate \n"; 

      }
      
    }    
    
    #$$$$$$$$$$$$$$$$$$$$$$$$$
    
    
    #### OIL 
    
    my $CurrentOilConsumption = $Oil_Use[$row] * $TSLength; # l
    
    $OilConsumptionCost += $CurrentOilConsumption * ( $OilSupplyCharge{$Locale} ); 

    #if ( $CurrMonth > 2 ) { die(); }
         
    #debug_out (" $Locale: TIER: $Elec_TierType{$Locale}  $CurrMonth $CurrDay $CurrHour | $CurrElecRatePeriod - $CurrPeakPeriod ($WeekendOrHoliday)  $ElecConsumption [kWh] * ( old:  vs new: $EffElecRate [\$/kWh] ) = $ElecConsumptionCost  \n");        

    #debug_out ("  $CurrMonth $CurrDay $CurrHour | $MonthGasConsumption -> $CurrGasTarrif | $GasConsumptionCost += $CurrentGasConsumption * $CurrGasTarrif \n"); 
  
  
    #### PROPANE
    
    my $CurrentPropaneConsumption = $Propane_Use[$row] * $TSLength; # l
    
    $PropaneConsumptionCost += $CurrentPropaneConsumption * ( $PropaneSupplyCharge ); 
  
    # debug_out ("###Debug Note $PropaneConsumptionCost  += $CurrentPropaneConsumption * ( $PropaneSupplyCharge ) \n"); 
    #if ( $CurrMonth > 2 ) { die(); }
         
    #debug_out (" $Locale: TIER: $Elec_TierType{$Locale}  $CurrMonth $CurrDay $CurrHour | $CurrElecRatePeriod - $CurrPeakPeriod ($WeekendOrHoliday)  $ElecConsumption [kWh] * ( old:  vs new: $EffElecRate [\$/kWh] ) = $ElecConsumptionCost  \n");        

    #debug_out ("  $CurrMonth $CurrDay $CurrHour | $MonthGasConsumption -> $CurrGasTarrif | $GasConsumptionCost += $CurrentGasConsumption * $CurrGasTarrif \n");  
	
	#### Wood
    
    my $CurrentWoodConsumption = $Wood_Use[$row] * $TSLength; # l
    
    $WoodConsumptionCost += $CurrentWoodConsumption * ( $WoodSupplyCharge ); 

		
	#### Pellets
    
    my $CurrentPelletsConsumption = $Pellets_Use[$row] * $TSLength; # l
    
    $PelletsConsumptionCost += $CurrentPelletsConsumption * ( $PelletsSupplyCharge ); 
  }



  my $TotalElecBill = $Elec_BaseCharge{$Locale}* 12. + $ElecConsumptionCost ; 
  my $TotalGasBill  = $GasConsumptionCost < 0.01 ? 0 : $NG_BaseCharge{$Locale} * 12. + $GasConsumptionCost  ; 
  
  my $TotalOilBill  = $OilFixedCharge * 12. + $OilConsumptionCost  ; 	
    
  my $TotalPropaneBill  = $PropaneFixedCharge * 12. + $PropaneConsumptionCost  ; 
  
  my $TotalWoodBill  = $WoodFixedCharge * 12. + $WoodConsumptionCost  ; 
	
  my $TotalPelletBill  = $PelletsFixedCharge * 12. + $PelletsConsumptionCost  ; 
  
  # Add data from externally computed SDHW (Legacy code)
  #my $sizeSDHW = $gChoices{"Opt-SolarDHW"}; 
  #$gSimResults{"SDHW production::AnnualTotal"} = -1.0 * $gOptions{"Opt-SolarDHW"}{"options"}{$sizeSDHW}{"ext-result"}{"production-DHW"};
  
    
  # Adjust solar DHW energy credit to reflect actual consumption. Assume 
  # SDHW credit cannot be more than 60% of total water load. 
  
  #$gSimResults{"SDHW production::AnnualTotal"} = min( $gSimResults{"SDHW production::AnnualTotal"}*-1.,
  #                                       0.6 * $gSimResults{"total_fuel_use/test/all_fuels/water_heating/energy_content::AnnualTotal"} 
  #                                     ) * (-1.) ; 
  
  
  
  

  # Add data from externally computed PVs. 
  
  
  my $PVsize = $gChoices{"Opt-StandoffPV"}; 
  my $PVArrayCost;
  my $PVArraySized; 
  
  if ( $PVsize !~ /SizedPV/ ){
    
    # Use spec'd PV sizes. This only works for NoPV. 
    $gSimResults{"PV production::AnnualTotal"}= 0.0 ; #-1.0*$gExtOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"ext-result"}{"production-elec-perKW"}; 
    $PVArrayCost = 0.0 ;
	
  }else{
    # Size pv according to user specification,  to max, or to size required to reach Net-Zero. 
    
    # User-specified PV size (format is 'SizedPV|XkW', PV will be sized to X kW'.
    if ( $gExtraDataSpecd{"Opt-StandoffPV"} =~ /kW/ ){
      
      $PVArraySized = $gExtraDataSpecd{"Opt-StandoffPV"};     
      $PVArraySized =~ s/kW//g; 
      
      my $PVUnitOutput = $gOptions{"Opt-StandoffPV"}{"options"}{"SizedPV"}{"ext-result"}{"production-elec-perKW"};
      my $PVUnitCost   = $gOptions{"Opt-StandoffPV"}{"options"}{"SizedPV"}{"cost"};
      
      $PVArrayCost = $PVUnitCost * $PVArraySized ; 
      
      $gSimResults{"PV production::AnnualTotal"} = -1.0 * $PVUnitOutput * $PVArraySized; 
            
      $PVsize="spec'd $PVsize | $PVArraySized kW";
    
    }else{ 
        
        # USER Hasn't specified PV size, Size PV to attempt to get to net-zero. 
        # First, compute the home's total energy requirement. 
    
        my $prePVEnergy = 0;

        # gSimResults contains all sorts of data. Filter by annual energy consumption (rows containing AnnualTotal).
        foreach my $token ( sort keys %gSimResults ){
          if ( $token =~ /AnnualTotal/  && $token =~ /all_fuels/ ){ 
            my $value = $gSimResults{$token};
            $prePVEnergy += $value; 
          }    
        }

        if ( $prePVEnergy > 0 ){
        
          # This should always be the case!
          
          my $PVUnitOutput = $gOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"ext-result"}{"production-elec-perKW"};
          my $PVUnitCost   = $gOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"cost"};
         
         $PVArraySized = $prePVEnergy / $PVUnitOutput ; # KW Capacity
          my $PVmultiplier = 1. ; 
          if ( $PVArraySized > 14. ) { $PVmultiplier = 2. ; }
          
          $PVArrayCost  = $PVArraySized * $PVUnitCost * $PVmultiplier;
                    
          $PVsize = " scaled: ".eval(round1d($PVArraySized))." kW" ;

          $gSimResults{"PV production::AnnualTotal"}=-1.0*$PVUnitOutput*$PVArraySized; 
        
        }else{
          # House is already energy positive, no PV needed. Shouldn't happen!
          $PVsize = "0.0 kW" ;
          $PVArrayCost  = 0. ;
        }
        # Degbug: How big is the sized array?
        debug_out (" PV array is $PVsize  ...\n"); 
        
    }  
  }
  $gChoices{"Opt-StandoffPV"}=$PVsize;
  $gOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"cost"} = $PVArrayCost;

  stream_out("\n\n Energy Consumption: \n\n") ; 

  my $gTotalEnergy = 0;

  foreach my $token ( sort keys %gSimResults ){
    if ( $token =~ /AnnualTotal/ && $token =~ /all_fuels/){
        my $value = $gSimResults{$token};
		$gTotalEnergy += $value; 
        stream_out ( "  + $value ( $token, GJ ) \n");
    }
  }
  
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( "    $gTotalEnergy ( Total energy, GJ ) \n");


  # Save Energy consumption for later
   
  $gEnergyPV = defined( $gSimResults{"PV production::AnnualTotal"} ) ? 
                         $gSimResults{"PV production::AnnualTotal"} : 0 ;  

  #$gEnergySDHW = defined( $gSimResults{"SDHW production"} ) ? 
  #                       $gSimResults{"SDHW production"} : 0 ;  

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

  $gEnergyElec  =  defined($gSimResults{"total_fuel_use/electricity/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/electricity/all_end_uses/quantity::Total_Average"} : 0 ;  
  
  $gEnergyGas   = defined($gSimResults{"total_fuel_use/natural_gas/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/natural_gas/all_end_uses/quantity::Total_Average"} : 0 ;  
  
  $gEnergyOil   = defined($gSimResults{"total_fuel_use/oil/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/oil/all_end_uses/quantity::Total_Average"} : 0 ;  

  $gEnergyWood  = defined($gSimResults{"total_fuel_use/mixed_wood/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/mixed_wood/all_end_uses/quantity::Total_Average"} : 0 ;  	
  $gEnergyPellet = defined($gSimResults{"total_fuel_use/wood_pellets/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/wood_pellets/all_end_uses/quantity::Total_Average"} : 0 ;  
  $gEnergyHardWood = defined( $gSimResults{"total_fuel_use/hard_wood/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/hard_wood/all_end_uses/quantity::Total_Average"} : 0 ;  
  $gEnergyMixedWood = defined( $gSimResults{"total_fuel_use/mixed_wood/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/mixed_wood/all_end_uses/quantity::Total_Average"} : 0 ;  
  $gEnergySoftWood = defined( $gSimResults{"total_fuel_use/soft_wood/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/soft_wood/all_end_uses/quantity::Total_Average"} : 0 ;  
  
  # New variables required for ERS calculation
  $gEnergyHeatingElec = defined( $gSimResults{"total_fuel_use/test/electricity/space_heating/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/electricity/space_heating/energy_content::AnnualTotal"} : 0 ;  
						 
  $gEnergyVentElec = defined( $gSimResults{"total_fuel_use/test/electricity/ventilation/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/electricity/ventilation/energy_content::AnnualTotal"} : 0 ;  

  $gEnergyHeatingFossil = defined( $gSimResults{"total_fuel_use/test/fossil_fuels/space_heating/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/fossil_fuels/space_heating/energy_content::AnnualTotal"} : 0 ;  
						 
  $gEnergyWaterHeatingElec = defined( $gSimResults{"total_fuel_use/test/electricity/water_heating/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/electricity/water_heating/energy_content::AnnualTotal"} : 0 ;  

  $gEnergyWaterHeatingFossil = defined( $gSimResults{"total_fuel_use/test/fossil_fuels/water_heating/energy_content::AnnualTotal"} ) ? 
                         $gSimResults{"total_fuel_use/test/fossil_fuels/water_heating/energy_content::AnnualTotal"} : 0 ;  
  
  $gEnergyTotalWood = $gEnergyHardWood + $gEnergyMixedWood + $gEnergySoftWood + $gEnergyPellet;

  $gAmtOil = defined( $gSimResults{"total_fuel_use/oil/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/oil/all_end_uses/quantity::Total_Average"} : 0 ;  

						 
  my $PVRevenue = $gEnergyPV * 1e06 / 3600. *$PVTarrifDollarsPerkWh; 
  
  my $TotalBill = $TotalElecBill+$TotalGasBill+$TotalOilBill+$TotalPropaneBill+$TotalWoodBill+$TotalPelletBill; 
  my $NetBill   = $TotalBill-$PVRevenue ;
  
  stream_out("\n\n Energy Cost (not including credit for PV, direction $gRotationAngle ): \n\n") ; 
  
  stream_out("  + \$ ".round($TotalElecBill)." (Electricity)\n");
  stream_out("  + \$ ".round($TotalGasBill)." (Natural Gas)\n");
  stream_out("  + \$ ".round($TotalOilBill)." (Oil)\n");
  stream_out("  + \$ ".round($TotalPropaneBill)." (Propane)\n");
  stream_out("  + \$ ".round($TotalWoodBill)." (Wood)\n");
  stream_out("  + \$ ".round($TotalPelletBill)." (Pellet)\n");
  
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( "    \$ ".round($TotalBill) ." (All utilities).\n"); 

  stream_out ( "\n") ;

  stream_out ( "  - \$ ".round($PVRevenue )." (PV revenue, ". eval($gEnergyPV * 1e06 / 3600.). " kWh at \$ $PVTarrifDollarsPerkWh / kWh)\n"); 
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( "    \$ ".round($NetBill) ." (Net utility costs).\n"); 
  
  stream_out ( "\n\n") ; 
  # Update global params for use in summary 
  $gAvgCost_NatGas    += $TotalGasBill  * $ScaleData; 
  $gAvgCost_Electr    += $TotalElecBill * $ScaleData;  
  $gAvgCost_Propane   += $TotalPropaneBill * $ScaleData; 
  $gAvgCost_Oil       += $TotalOilBill * $ScaleData; 
  $gAvgCost_Wood      += $TotalWoodBill * $ScaleData; 
  $gAvgCost_Pellet    += $TotalPelletBill * $ScaleData; 
   
  $gAvgEnergy_Total   += $gTotalEnergy  * $ScaleData; 
  $gAvgNGasCons_m3    += $gEnergyGas * 8760. * 60. * 60.  * $ScaleData ; 
  $gAvgOilCons_l      += $gEnergyOil * 8760. * 60. * 60.  * $ScaleData ;  
  $gAvgPelletCons_tonne+= $gEnergyPellet * 8760. * 60. * 60.  * $ScaleData ;
  
  $gAvgElecCons_KWh   += $gEnergyElec * 8760. * 60. * 60. * $ScaleData ; 
  
  $gAvgPVOutput_kWh   += -1.0 * $gEnergyPV * 1e06 / 3600. * $ScaleData;  
  
  $gAvgEnergyHeatingGJ      += $gEnergyHeating         * $ScaleData; 
  $gAvgEnergyCoolingGJ      += $gEnergyCooling         * $ScaleData; 
  $gAvgEnergyVentilationGJ  += $gEnergyVentilation     * $ScaleData; 
  $gAvgEnergyWaterHeatingGJ += $gEnergyWaterHeating    * $ScaleData; 
  $gAvgEnergyEquipmentGJ    += $gEnergyEquipment       * $ScaleData; 

  # Added for ERS calculation
  $gAvgEnergyHeatingElec        += $gEnergyHeatingElec        * $ScaleData;		# GJ
  $gAvgEnergyVentElec           += $gEnergyVentElec           * $ScaleData;		# GJ
  $gAvgEnergyHeatingFossil      += $gEnergyHeatingFossil      * $ScaleData;		# GJ
  $gAvgEnergyWaterHeatingElec   += $gEnergyWaterHeatingElec   * $ScaleData;		# GJ
  $gAvgEnergyWaterHeatingFossil += $gEnergyWaterHeatingFossil * $ScaleData;		# GJ

  stream_out("\n\n Energy Use (not including credit for PV, direction $gRotationAngle ): \n\n") ; 
  
  stream_out("  - ".round($gEnergyElec* 8760. * 60. * 60.)." (Electricity, kWh)\n");
  stream_out("  - ".round($gEnergyGas* 8760. * 60. * 60.)." (Natural Gas, m3)\n");
  stream_out("  - ".round($gEnergyOil* 8760. * 60. * 60.)." (Oil, l)\n");
  stream_out("  - ".round($gEnergyWood* 8760. * 60. * 60.)." (Wood, cord)\n");
  stream_out("  - ".round($gEnergyPellet* 8760. * 60. * 60.)." (Pellet, tonnes)\n");
  
  if ( $gERSCalcMode && $gERSNum > 0 ) {
	my $tmpval = round($gERSNum * 10) / 10.;
	stream_out("  - ".$tmpval." (ERS value)\n");
  }
 
  stream_out ("> SCALE $ScaleData \n"); 
  
  
  # Estimate total cost of upgrades

  $gTotalCost = 0;         
  
  stream_out ("\n\n Estimated costs in $Locale (x$gRegionalCostAdj Ottawa costs) : \n\n");

  foreach my  $attribute ( sort keys %gChoices ){
    
    my $choice = $gChoices{$attribute}; 
    my $cost; 
    $cost  = $gOptions{$attribute}{"options"}{$choice}{"cost"} * $gRegionalCostAdj;
    $gTotalCost += $cost ;

    stream_out( " +  ".round($cost)." ( $attribute : $choice ) \n");
    
  }
  stream_out ( " - ".round($gIncBaseCosts * $gRegionalCostAdj)." (Base costs for windows)  \n"); 
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( " =   ".round($gTotalCost-$gIncBaseCosts* $gRegionalCostAdj )." ( Total incremental cost ) \n\n");

  
  stream_out ( " ( Unadjusted upgrade costs: \$".eval( $gTotalCost  /  $gRegionalCostAdj )." )\n\n");
  
  
  chdir($gMasterPath);
  my $fileexists; 

  
  
}  # End of postprocess() subroutine


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

sub debug_out($){
  my($txt) = @_;
  if ($gDebug == 1){
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
  print "\n=========================================================\n"; 
  print "substitute.pl -> Fatal error: \n\n";
  print "$err_msg \n";
  print "\n\n"; 
  print "substitute.pl -> Error and warning messages:\n\n";
  print "$ErrorBuffer \n"; 
  die "Run stopped";
}


#--------------------------------------------------------------------
# Perform system commands with optional redirection
#--------------------------------------------------------------------
sub execute($){
  my($command) =@_;
  my $result;
  if ($gTest_params{"verbosity"} eq "very_verbose" || $gTest_params{"verbosity"} eq "very_very_verbose" ){    
    debug_out("\n > executing $command \n");
    debug_out(" > from path ".getcwd()."\n");
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

# -----------------------------------------------------------------------------------------
# Post process Dakota output file and stop (-z option)
# -----------------------------------------------------------------------------------------
sub postprocessDakota()
{
	my $DakotaGenerated = "all_responses.txt";
	my $DakotaOutput = "OutputListingAll-D.txt";
	my $gDakotaUtilityCmd = "dakota_restart_util to_tabular dakota.rst $DakotaGenerated";
	my $linecnt = 0;
	my $DataOut = "";

	# Execute Dakota utility to generate complete set of output data (inputs + outputs)
	execute($gDakotaUtilityCmd);
	
	# Open Dakota generated file and file to be used for processed output
	open ( READIN_DAKOTA_RESULTS, "$DakotaGenerated" ) or fatalerror( "Could not read gDakotaGenerated! This option requires access to the Dakota program dakota_restart_util!" );
	open (WRITEOUT, ">$DakotaOutput") or die ( "Could not open $DakotaOutput for writing!"); 

	stream_out("\n\nReading $DakotaGenerated and writing $DakotaOutput...\n");

	# Write out top 20 blank lines
	for ( my $i = 1; $i < 20; $i++ ) {
		print WRITEOUT "Temporary header line #$i\n"
	}

	# Parse the Dakota output file to convert integers to attribute option strings and set 
	# expected format. 
	while ( my $line = <READIN_DAKOTA_RESULTS> ){
		# Change spaces separating data to semicolons
		$line =~ s/\s+/;/g;
		# remove leading and trailing ;'s
		$line =~ s/^;//g;
		$line =~ s/;$//g;
		# Split up line into array elements for processing
		my @DataIn = split /;/, $line; 
		
		$linecnt++;
		my $eleNum = 0;
		my $IsEndOfLoop = 0;
		
		foreach my $TestValue (@DataIn){
			if ( $linecnt == 1 ) {
				# Ignore existing header row and write an alternate that uses the correct variable
				# names that Tableau expects when using existing visualizations (i.e., the "GOtag:..." names.)
				if    ( $eleNum == 0 ) { $DataIn[$eleNum]  = "Simulation Number"; }				#0:%eval_id
				elsif ( $eleNum == 1 ) { $DataIn[$eleNum]  = "Main Iteration"; }				#1:skipping "interface"
				elsif ( $eleNum == 2 ) { $DataIn[$eleNum]  = "GOtag:CalcMode"; }				#2:Opt-calcmode
				elsif ( $eleNum == 3 ) { $DataIn[$eleNum]  = "GOtag:DBFiles"; }					#3:Opt-DBFiles
				elsif ( $eleNum == 4 ) { $DataIn[$eleNum]  = "GOtag:Opt-Location"; }			#4:Opt-Location
				elsif ( $eleNum == 5 ) { $DataIn[$eleNum]  = "GOtag:GOconfig_rotate"; }			#5:GOconfig_rotate
				#no change - don't use															#6:OPT-OPR-SCHED
				#no change - don't use															#7:OPT-Furnace-Fan-Ctl
				elsif ( $eleNum == 8 ) { $DataIn[$eleNum]  = "GOtag:HRVcontrol"; }				#8:OPT-HRV_ctl
				elsif ( $eleNum == 9 ) { $DataIn[$eleNum]  = "GOtag:Opt-geometry"; }			#9:Opt-geometry
				elsif ( $eleNum == 10 ) { $DataIn[$eleNum] = "GOtag:Opt-Attachment"; }			#10:Opt-Attachment
				#no change - don't use															#11:Opt-BaseWindows
				elsif ( $eleNum == 12 ) { $DataIn[$eleNum] = "GOtag:RoofPitch"; }				#12:Opt-RoofPitch
				elsif ( $eleNum == 13 ) { $DataIn[$eleNum] = "GOtag:Opt-OverhangWidth"; }		#13:Opt-OverhangWidth
				#no change - don't use															#14:Opt-WindowOrientation
				elsif ( $eleNum == 15 ) { $DataIn[$eleNum] = "GOtag:DHWLoadScale"; }			#15:Opt-DHWLoadScale
				elsif ( $eleNum == 16 ) { $DataIn[$eleNum] = "GOtag:ElecLoadScale"; }			#16:Opt-ElecLoadScale
				elsif ( $eleNum == 17 ) { $DataIn[$eleNum] = "GOtag:Opt-AirTightness"; }		#17:Opt-AirTightness
				elsif ( $eleNum == 18 ) { $DataIn[$eleNum] = "GOtag:Opt-ACH"; }					#18:Opt-ACH
				elsif ( $eleNum == 19 ) { $DataIn[$eleNum] = "GOtag:Opt-CasementWindows"; }		#19:Opt-CasementWindows
				elsif ( $eleNum == 20 ) { $DataIn[$eleNum] = "GOtag:Opt-Ceilings"; }			#20:Opt-Ceilings
				elsif ( $eleNum == 21 ) { $DataIn[$eleNum] = "GOtag:Opt-MainWall"; }			#21:Opt-MainWall
				elsif ( $eleNum == 22 ) { $DataIn[$eleNum] = "GOtag:Opt-GenericWall_1Layer_definitions"; }	#22:Opt-GenericWall_1Layer_definitions
				elsif ( $eleNum == 23 ) { $DataIn[$eleNum] = "GOtag:Opt-ExposedFloor"; }		#23:Opt-ExposedFloor
				elsif ( $eleNum == 24 ) { $DataIn[$eleNum] = "GOtag:Opt-BasementWallInsulation"; }	#24:Opt-BasementWallInsulation
				elsif ( $eleNum == 25 ) { $DataIn[$eleNum] = "GOtag:Opt-BasementSlabInsulation"; }	#25:Opt-BasementSlabInsulation
				elsif ( $eleNum == 26 ) { $DataIn[$eleNum] = "GOtag:Ext-DryWall"; }				#26:Opt-ExtraDrywall
				elsif ( $eleNum == 27 ) { $DataIn[$eleNum] = "GOtag:Opt-FloorSurface"; }		#27:Opt-FloorSurface
				elsif ( $eleNum == 28 ) { $DataIn[$eleNum] = "GOtag:Opt-DHWSystem"; }			#28:Opt-DHWSystem
				elsif ( $eleNum == 29 ) { $DataIn[$eleNum] = "GOtag:Opt-HVACSystem"; }			#29:Opt-HVACSystem
				elsif ( $eleNum == 30 ) { $DataIn[$eleNum] = "GOtag:Opt-Cooling-Spec"; }		#30:Opt-Cooling-Spec
				elsif ( $eleNum == 31 ) { $DataIn[$eleNum] = "GOtag:Opt-HRVSpec"; }				#31:Opt-HRVspec
				elsif ( $eleNum == 32 ) { $DataIn[$eleNum] = "GOtag:Opt-HRVduct"; }				#32:Opt-HRVduct
				elsif ( $eleNum == 33 ) { $DataIn[$eleNum] = "GOtag:Opt-StandoffPV"; }			#33:Opt-StandoffPV
				elsif ( $eleNum == 34 ) { $DataIn[$eleNum] = "GOtag:Opt-DWHRandSDHW"; }			#34:Opt-DWHRandSDHW
				elsif ( $gReorder && $eleNum == 35 ) { 											
					$DataIn[59] = "Sub Iteration"; 												#59 for GenOpt
					$DataIn[60] = "Step Number"; 												#60 for GenOpt
					$DataIn[61] = "Garbage1";	#Used for Dakota unmapped GenOpt fields
					$DataIn[62] = "Garbage2";	#Used for Dakota unmapped GenOpt fields
					$DataIn[63] = "Garbage3";	#Used for Dakota unmapped GenOpt fields
					$DataIn[64] = "Garbage4";	#Used for Dakota unmapped GenOpt fields
				}
			}
			elsif ( $eleNum == 1 ) {
				$DataIn[$eleNum] = $DataIn[0];	# Same as Simulation Number
				if ( $gReorder ) {
					# Set values for GenOpt values not read in
					$DataIn[59] = 1; 		#Sub Iteration
					$DataIn[60] = 1;		#Step Number
					$DataIn[61] = "Empty";	#Used for unmapped fields
					$DataIn[62] = "Empty";	#Used for unmapped fields
					$DataIn[63] = "Empty";	#Used for unmapped fields
					$DataIn[64] = "Empty";	#Used for unmapped fields
				}
			}
			elsif ( $eleNum > 1 && $eleNum < 35 && $TestValue =~ /\d{3,4}/ ){
				# Get attribute name for data values that are Dakota aliases
				while ( my ( $attribute, $dummy) = each %gChoices ){
					my $OptHash = $gOptions{$attribute}{"options"}; 
					for my $optionIndex ( keys (%$OptHash) ){
						my $Test = $gOptions{$attribute}{"options"}{$optionIndex}{"alias"};
						if ( $Test && $Test =~ /^$TestValue$/ ) {
							$TestValue = $optionIndex;	# Modify array element with option name
							$IsEndOfLoop = 1;
							last;	# found alias so exit this for loop (alias is unique!)
						}
					}
					if ( $IsEndOfLoop ) {
						$IsEndOfLoop = 0;
						keys( %gChoices );	# This resets the %gChoices hash!
						last;				# End inner while loop
					}
				}
			}
			
			# DataIn array now updated with attribute option names (or correct header names)
			
			# $DataOut in order of data read in
			$DataOut .= "$DataIn[$eleNum]\t";	# Tab Separate vars (expected by recover_results.pl)

			# Write out the data if at end of current input line
			if ( $eleNum == scalar(@DataIn)-1 ) {
				if ( $gReorder ) {
					# Reorder the output to match order of Genopt Data (ignores elements 42,43,53, 57). See GenOpt-Dakota Output Mapping.xlsx for mapping (Jeff).
					$DataOut = "$DataIn[0]\t$DataIn[1]\t$DataIn[59]\t$DataIn[60]\t$DataIn[56]\t$DataIn[35]\t$DataIn[36]\t$DataIn[37]\t$DataIn[38]\t$DataIn[39]\t$DataIn[40]\t$DataIn[41]\t$DataIn[42]\t$DataIn[45]\t$DataIn[46]\t$DataIn[47]\t$DataIn[48]\t$DataIn[49]\t$DataIn[50]\t$DataIn[51]\t$DataIn[52]\t$DataIn[53]\t$DataIn[55]\t$DataIn[57]\t$DataIn[58]\t$DataIn[2]\t$DataIn[3]\t$DataIn[8]\t$DataIn[4]\t$DataIn[9]\t$DataIn[10]\t$DataIn[18]\t$DataIn[17]\t$DataIn[21]\t$DataIn[22]\t$DataIn[24]\t$DataIn[25]\t$DataIn[23]\t$DataIn[20]\t$DataIn[19]\t$DataIn[26]\t$DataIn[27]\t$DataIn[34]\t$DataIn[28]\t$DataIn[29]\t$DataIn[31]\t$DataIn[33]\t$DataIn[30]\t$DataIn[32]\t$DataIn[61]\t$DataIn[62]\t$DataIn[63]\t$DataIn[64]\t$DataIn[13]\t$DataIn[12]\t$DataIn[16]\t$DataIn[15]\t$DataIn[5]\n";
				} else {
					$DataOut .= "\n";
				}
				print WRITEOUT $DataOut;	# Write out one line at a time so $DataOut doesn't get huge!!
				$DataOut = "";				# Clear $DataOut
				$eleNum = 0;
			} else {
				$eleNum++;
			}
		}
	}

	close READIN_DAKOTA_RESULTS;
	close WRITEOUT;
	
	# End this script!
	stream_out("\n\nDakota output file $DakotaOutput successfully produced.\n");
	close(LOG);

	exit 0; 
}
