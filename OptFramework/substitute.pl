#!/usr/bin/perl    

# This script parses through the files

 
use warnings;
use strict;
#use File::Compare;
use Cwd;
use Cwd 'chdir';
use File::Find;
use Math::Trig;

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


my $gDebug = 0; 

my %gTest_params;          # test parameters
my $gChoiceFile  = ""; 
my $gOptionFile  = "" ; 

my $gBPSpath            = "~/esp-r/bin/bps"; 
my $gPRJpath            = "~/esp-r/bin/prj"; 

# $gBaseModelFolder initialized here but can be over-ridden by command line value with -b option
my $gBaseModelFolder    = "MB-LEEP-Base";
my $gWorkingModelFolder = "MB-LEEP-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "MB-LEEP.cfg";

my $gTotalCost          = 0; 
my $gIncBaseCosts       = 11727; 
my $cost_type           = 0;
my $gSkipSims           = 0; 

my $gRotate             = "S";

my $gGOStep             = 0; 
my $gArchGOChoiceFile   = 0; 

my %gChoices; 
my %gOptions;

my $ThisError   = ""; 
my $ErrorBuffer = ""; 

my $gEnergyPV; 
my $gEnergySDHW;
my $gEnergyHeating;
my $gEnergyCooling;
my $gEnergyVentilation; 
my $gEnergyWaterHeating; 
my $gEnergyEquipment; 

my $gRotationAngle; 

my $gSkipPRJ = 0; 
my $gEnergyElec = 0;
my $gEnergyGas = 0;
my $gEnergyOil = 0; 

# Data from Hanscomb 2011 NBC analysis
my %RegionalCostFactors  = (  "Halifax"      =>  0.95 ,
                              "Edmonton"     =>  1.12 ,
                              "Calgary"      =>  1.12 ,  # Assume same as edmonton?
                              "Ottawa"       =>  1.00 ,
                              "Toronto"      =>  1.00 ,
                              "Quebec"       =>  1.00 ,  # Assume same as montreal?
                              "Montreal"     =>  1.00 ,
                              "Vancouver"    =>  1.10 ,
                              "Regina"       =>  1.08 ,  # Same as Winnipeg?
                              "Winnipeg"     =>  1.08 ,
                              "Fredricton"   =>  1.00 ,  # Same as Quebec?
                              "Whitehorse"   =>  1.00    ); # Same as yellowknife, 1.38?


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
                      
 use for optimization work:
 
  ./substitute.pl -c optimization-choices.opt \
                  -o optimization-options.opt \
                  -b BaseFolderName           \
                  -v(v);
				  
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
$cmd_arguements =~ s/-p;/--path;/g;
$cmd_arguements =~ s/-c;/--choices;/g;
$cmd_arguements =~ s/-o;/--options;/g;
$cmd_arguements =~ s/-v;/--verbose;/g;
$cmd_arguements =~ s/-vv;/--very_verbose;/g;
$cmd_arguements =~ s/-vvv;/--very_very_verbose;/g;
$cmd_arguements =~ s/-b;/--base_folder;/g;

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
    
    if ( $arg =~ /^--base_folder/ ){
      # Base folder name overrides initialized value (at top)
      $gBaseModelFolder = $arg;
      $gBaseModelFolder =~ s/--base_folder://g;
      $gModelCfgFile = "$gBaseModelFolder.cfg"; 
      

      if ( ! $gBaseModelFolder ){
        fatalerror("Base folder name missing after --base_folder (or -b) option!");
      }
      if (! -d "$gBaseModelFolder"){ 
		fatalerror("Base folder does not exist - create and populate folder first!");
	  }

	  last SWITCH;
    }
    
    
    
    
    
    fatalerror("Arguement \"$arg\" is not understood\n");
    
    
 
    
    
  }
}


# Update ESP-r commands to use defined cfg file name.

my $gISHcmd             = "./run.sh $gModelCfgFile";
my $gPRJZoneConCmd      = "$gPRJpath -mode text -file $gModelCfgFile -act update_con_files";
my $gPRJZoneRotCmd      = "$gPRJpath -mode text -file $gModelCfgFile -act rotate ";
my $gBPScmd             = "$gBPSpath -h3k -file $gModelCfgFile -mode text -p fullyear silent";
   
   
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



# Parse option file. This file defines the available choices and costs
# that substitute.pl can pick from 

open ( OPTIONS, "$gOptionFile") or fatalerror("Could not read $gOptionFile!");
stream_out("\n\nReading $gOptionFile...");
my $linecount = 0;
my $currentAttributeName ="";
my $AttributeOpen = 0;
my $ExternalAttributeOpen = 0;


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


    
    # Parse attribute contents Name/Tag/Option(s)
    if ( $AttributeOpen || $ExternalAttributeOpen ) {
    
      # Read name
      if ( $token =~ /^\*attribute:name/ ){
    
        $currentAttributeName = $value ;
		if ( $ExternalAttributeOpen) { 
			$gOptions{$currentAttributeName}{"type"} = "external"; 
		}else{
			$gOptions{$currentAttributeName}{"type"} = "internal"; 
		}
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
	  
	  
	  
	  if ( $token =~ /^\*option/ ){
	    # Format: 
		
		#  *Option:NAME:MetaType:Index or 
		#  *Option[CONDITIONS]:NAME:MetaType:Index or 	
		# MetaType is:
		#  - cost
		#  - value 
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
		
		# Cjeck option keyword to see if it has specific conditions
		# format is *option[condition1>value1;condition2>value2 ...] 
		
		if ($breakToken[0]=~/\[.+\]/ ) {
			
			$condition_string = $breakToken[0]; 
			$condition_string =~ s/\*option\[//g; 
			$condition_string =~ s/\]//g; 
			$condition_string =~ s/>/=/g; 
			#debug_out ("  + Reading conditions >$condition_string<!!!\n");
			
						
		}else{
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
			if ( $DataType =~ /cost/ ){$CostType = $breakToken[3]; }
			$gOptions{$currentAttributeName}{"options"}{$OptionName}{"cost-type"} = $CostType;
			$gOptions{$currentAttributeName}{"options"}{$OptionName}{"cost"} = $value;
			
			#debug_out ( "++++++ \$gOptions{$currentAttributeName}{options}{ $OptionName }{cost-type} = $CostType \n"); 
			#debug_out ( "++++++ \$gOptions{$currentAttributeName}{options}{ $OptionName }{cost} = $value  \n"); 
			
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
		debug_out( "           - cost = \$$cost ($cost_type) \n");
		
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
      

    }
  
  
  #else{debug_out (" skipped...\n");}
}


close (OPTIONS);
 


 
 
 
for my $att (keys %gOptions ){ 

  #debug_out ".... $att \n"; 
  
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
  #debug_out ("  Line: $linecount >$line<\n");
  
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

# Optionally create a copy of the choice file for later use. 


if ( $gArchGOChoiceFile and -d "../ArchGOChoiceFiles" ) { 
  #debug_out( " Archiving $gChoiceFile -> ../ArchGOChoiceFiles/$gChoiceFile-$gGOStep" ); 
  #!execute ( " cp $gChoiceFile ../ArchGOChoiceFiles/$gChoiceFile-$gGOStep ") ; 
  
} 





my %gChoiceAttIsExt;


my %gExtOptions;
# Report 
my $allok = 1;

debug_out("-----------------------------------\n");
debug_out("-----------------------------------\n");
stream_out(" Validating choices and options...\n");  

while ( my ( $attribute, $choice) = each %gChoices ){
  
  debug_out ( "\n ======================== $attribute ============================\n");
  debug_out ( "Choosing $attribute -> $choice \n"); 
    
  # is attribute defined in options ?
  if ( ! defined( $gOptions{$attribute} ) ){
    $ThisError  = "\nERROR: Attribute $attribute appears in choice file ($gChoiceFile), \n"; 
    $ThisError .=  "       but can't be found in options file ($gOptionFile)\n"; 
    $ErrorBuffer .= $ThisError; 
    stream_out( $ThisError ); 
    $allok = 0;
  }else{
  
	debug_out ( "   - found \$gOptions{\"$attribute\"} \n"); 
  
  }
  

  if ( ! defined( $gOptions{$attribute}{"options"}{$choice} ) ){
    $ThisError  = "\nERROR: Choice $choice (for attribute $attribute, defined \n"; 
    $ThisError .=   "       in choice file $gChoiceFile), is not defined \n"; 
    $ThisError .=   "       in options file ($gOptionFile)\n";
    $ErrorBuffer .= $ThisError; 
    stream_out( $ThisError );   
       
    $allok = 0;
       
  }else{ 
	debug_out ( "   - found \$gOptions{\"$attribute\"}{\"options\"}{\"$choice\"} \n"); 
  }
  # Now we need to process conditions.
  
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
			
		  }else{
			
			# Loop through hash 
			
			for my $conditions ( keys %CondHash ) {
			
				#debug_out ( " >>>>> Testing $conditions \n" ) ; 
				
				my $valid_condition = 1; 
				foreach my $condition (split /;/, $conditions ){

				  #debug_out ("      $condition \n"); 
				  my ($TestAttribute, $TestValueList) = split /=/, $condition; 
				  if ( ! $TestValueList ) {$TestValueList = "XXXX";}
				  my @TestValueArray = split /\|/, $TestValueList;
				  my $thesevalsmatch =0; 
				  foreach my $TestValue (@TestValueArray){
				    if ( $gChoices{$TestAttribute} eq $TestValue ) { $thesevalsmatch = 1; }
					 
				   # debug_out ("      \$gChoices{".$TestAttribute."} = ".$gChoices{$TestAttribute}." / $TestValue / -> $thesevalsmatch \n"); 
				  }
				  if ( ! $thesevalsmatch ){$valid_condition = 0;}
				  
				}
				if ( $valid_condition ) { 
				  $gOptions{$attribute}{"options"}{$choice}{"result"}{$ValueIndex}  = $CondHash{$conditions};
				  $ValidConditionFound = 1; 
				  debug_out ("   - VALINDEX: $ValueIndex : found valid condition: \"$conditions\" !\n");
				}

			}
			
		  }
		  # Check if else condition exists. 
		  if ( ! $ValidConditionFound ) {
		    if ( defined( $CondHash{"else"} ) ){
			  $gOptions{$attribute}{"options"}{$choice}{"result"}{$ValueIndex} = $CondHash{"else"};
			  $ValidConditionFound = 1;
			  #debug_out ("   - VALINDEX: $ValueIndex : found valid condition: \"else\" !\n");
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
			
		  }else{
			
			# Loop through hash 
			
			for my $conditions ( keys %CondHash ) {
			
				#debug_out ( " >>>>> Testing $conditions \n" ) ; 
				
				my $valid_condition = 1; 
				foreach my $condition (split /;/, $conditions ){

				  #debug_out ("      $condition \n"); 
				  my ($TestAttribute, $TestValueList) = split /=/, $condition; 
				  if ( ! $TestValueList ) {$TestValueList = "XXXX";}
				  my @TestValueArray = split /\|/, $TestValueList;
				  my $thesevalsmatch =0; 
				  foreach my $TestValue (@TestValueArray){
				    if ( $gChoices{$TestAttribute} eq $TestValue ) { $thesevalsmatch = 1; }
					 
				    #debug_out ("      \$gChoices{".$TestAttribute."} = ".$gChoices{$TestAttribute}." / $TestValue / -> $thesevalsmatch \n"); 
				  }
				  if ( ! $thesevalsmatch ){$valid_condition = 0;}
				  
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
     
	debug_out ("   - found cost: \$$cost ($cost_type) \n"); 
    
	# NOW, 
	
	
	
	
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
    debug_out ( "\n\nMAPPING for $attribute = $choice (@ \$".
                 round($cost).
                 " inc. cost [$cost_type] ): \n"); 
    if ( $ScaleCost ){
      debug_out (     "  (cost computed as $ScaleFactor *  ".round($BaseCost)." [cost of $BaseChoice])\n");
    }
    
  
    
  }
 
  

}

while ( my ( $option, $null ) = each %gOptions ){
    #stream_out ("> option : $option ?\n"); 
    if ( ! defined( $gChoices{$option} ) ) { 
             $ThisError = "\nWARNING: Option $option found in in options file ($gOptionFile) \n";
             $ThisError .=   "         was not specified in Choices file ($gChoiceFile) \n";       
             $ErrorBuffer .= $ThisError; 
             
             stream_out ( $ThisError ); 

    }
    $ThisError = ""; 
}

  


# Seems like we've found everything!




if ( ! $allok ) { 

    stream_out("\n--------------------------------------------------------------\n");
    stream_out("\nSubstitute.pl encountered the following errors:\n"); 
    stream_out($ErrorBuffer); 

    fatalerror(" Choices in $gChoiceFile do not match options in $gOptionFile!");
}else{
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
my $gMasterPath = getcwd();

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
    debug_out ( "Found $gMasterPath/$source_clm_dir. Linking.\n");
    $clm_link_target = "$gMasterPath/$source_clm_dir"; 
}
# Fi
elsif ( -d "$gMasterPath/../$source_clm_dir" ) {
    debug_out ( "Found $gMasterPath/$source_clm_dir. Linking.\n");
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
execute ( "ln -s  $clm_link_target $gWorkingModelFolder/climate "); 


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
               
			   
# Variables that store the average utilit costs, energy amounts. Defined here because if we are running 
# multiple orientations, we must average them as we go.	   
my $gAvgCost_NatGas    = 0 ;
my $gAvgCost_Electr    = 0 ;
my $gAvgEnergy_Total   = 0 ; 
my $gAvgCost_Propane   = 0 ;
my $gAvgCost_Oil       = 0 ;

my $gAvgElecCons_KWh    = 0; 
my $gAvgNGasCons_m3     = 0; 
my $gAvgOilCons_l       = 0; 
my $gAvgPropCons_l      = 0; 

UpdateCon();  
 
for my $Direction  ( @Orientations ){

   if ( ! $gSkipSims ) { runsims( $angles{$Direction} ); }

    
    postprocess($ScaleResults);

}

my $gAvgCost_Total   = $gAvgCost_Electr + $gAvgCost_NatGas + $gAvgCost_Propane + $gAvgCost_Oil ;



open (SUMMARY, ">$gMasterPath/SubstitutePL-output.txt") or fatalerror ("Could not open $gMasterPath/SubstitutePL-output.txt");

print SUMMARY "Energy-Total-GJ =  $gAvgEnergy_Total \n"; 
print SUMMARY "Util-Bill-Total =  $gAvgCost_Total   \n";
print SUMMARY "Util-Bill-Elec  =  $gAvgCost_Electr  \n";
print SUMMARY "Util-Bill-Gas   =  $gAvgCost_NatGas  \n";
print SUMMARY "Util-Bill-Prop  =  $gAvgCost_Propane \n";
print SUMMARY "Util-Bill-Oil   =  $gAvgCost_Oil \n";

print SUMMARY "Energy-PV       =  $gEnergyPV \n";
print SUMMARY "Energy-SDHW     =  $gEnergySDHW \n";
print SUMMARY "Energy-Heating  =  $gEnergyHeating \n";
print SUMMARY "Energy-Cooling  =  $gEnergyCooling \n";
print SUMMARY "Energy-Vent     =  $gEnergyVentilation \n";
print SUMMARY "Energy-DHW      =  $gEnergyWaterHeating \n";
print SUMMARY "Energy-Plug     =  $gEnergyEquipment \n";  
print SUMMARY "EnergyElec      =  $gAvgElecCons_KWh \n";
print SUMMARY "EnergyGas       =  $gAvgNGasCons_m3  \n";
print SUMMARY "EnergyOil       =  $gAvgOilCons_l    \n";
print SUMMARY "Upgrade-cost    =  ".eval($gTotalCost-$gIncBaseCosts)."\n"; 

my $PVcapacity = $gChoices{"Opt-StandoffPV"}; 
$PVcapacity =~ s/[a-zA-Z:\s]//g;
if (! $PVcapacity ) { $PVcapacity = 0. ; }

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
          if (!defined($value)){debug_out (">>>ERR on $tag\n");}        
          if ( $line =~ /$tag/ ){ $matched = 1; }
          $line =~ s/$tag/$value/g; 
          
        }
        
      }
	  
    }
    #if ($matched ){debug_out("> $linecopy| $line");}
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
  if ( ! $gSkipSims ) { execute ("rm out.*"); }
  
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
    # rename results libraries for consistancy



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
    if ( $regen ) {stream_out("\n\n Invoking ish via run.sh...");
      stream_out("   Regenerating shading files for zone $zone using ish"); 
      my $cmd = "~/esp-r/bin/ish -mode text -file $gModelCfgFile -zone $zone -act update_silent";
      execute($cmd);      
      stream_out("   Done.\n");
    }stream_out ("done. \n");         
  }        

  stream_out ("\n\n Invoking ESP-r (\"$gBPScmd\")..." );
  execute($gBPScmd); 
          
  # Save output files
 if ( ! -d "$gMasterPath/sim-output" ) {
  
   execute("mkdir $gMasterPath/sim-output") or debug_out ("Could not create $gMasterPath/sim-output!\n"); 
   
 }
# 
 if ( -d "$gMasterPath/sim-output") { execute("cp $gMasterPath/$gWorkingCfgPath/out* $gMasterPath/sim-output/");}
#         
#         
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
  
  my $OilFixedCharge; 
  my $OilSupplyCharge     = 1.34;    # Whitehorse cost of furnace oil / arctic stove oil is $1.34/l  (Yukon energy statistics)
  my $OilTransportCharge;
  my $OilDeliveryCharge; 
  
  my $PropaneFixedCharge; 
  my $PropaneSupplyCharge    = 0.855;   # Yukon cost of propane supply (LPG) $0.855 per litre. YK bureau of statistics.Aug 2013. http://www.eco.gov.yk.ca/stats/pdf/fuel_aug13.pdf  1l of LPG expands to about 270l gaseous propane at 1bar. 
  my $PropaneDeliveryCharge; 
  my $PropaneTrasportCharge;
  
  #my $WoodFixedCharge; 
  #my $WoodSupplyCharge    = 260.0;   # ESC Heat Info Sheet - Assumes 18700 MJ / cord
  #my %WoodDeliveryTier; 
  #my $WoodTrasportCharge;
  
  #my $PelletsFixedCharge; 
  #my $PelletsSupplyCharge    = 340.0;   # ESC Heat Info Sheet - Assumes 18000 MJ/ton of pellets
  #my %PelletsDeliveryTier; 
  #my $PelletsTrasportCharge;
  
  my $NGTierType;  

  # Assume summer and winter rates are the same. 
  #$ElecPeakCharges{"winter"}{"off-peak"} = $ElecPeakCharges{"summer"}{"off-peak"} ;
  #$ElecPeakCharges{"winter"}{"mid-peak"} = $ElecPeakCharges{"summer"}{"mid-peak"} ;
  #s$ElecPeakCharges{"winter"}{"on-peak"}  = $ElecPeakCharges{"summer"}{"on-peak"}  ;
  
  
  
  
  #_------------------------- New rates ! -------------------------
  
   
  # Base charges for natural gas ($/month)
  my %Elec_BaseCharge = ( "Halifax"      =>  10.83  ,
                          "Edmonton"     =>  21.93  ,
                          "Calgary"      =>  17.55  ,
                          "Ottawa"       =>  9.42   ,
                          "Toronto"      =>  18.93  ,
                          "Quebec"       =>  12.36  ,
                          "Montreal"     =>  12.36  ,
                          "Vancouver"    =>  4.58   ,
                          "Regina"       =>  20.22  ,
                          "Winnipeg"     =>  6.85   ,
                          "Fredricton"   =>  19.73  ,
                          "Whitehorse"   =>  16.25    ); 
	
  # Base charges for natural gas ($/month)
  my %NG_BaseCharge = ( "Halifax"      =>  21.87 ,
                        "Edmonton"     =>  28.44 ,
                        "Calgary"      =>  28.44 ,
                        "Ottawa"       =>  20.00 ,
                        "Toronto"      =>  20.00 ,
                        "Quebec"       =>  14.01 ,
                        "Montreal"     =>  14.01 ,
                        "Vancouver"    =>  11.83 ,
                        "Regina"       =>  18.85 ,
                        "Winnipeg"     =>  14.00 ,
                        "Fredricton"   =>  16.00 ,
                        "Whitehorse"   =>  "nil"  ); 	

   my %Elec_TierType  = ( "Halifax"      =>  "none" ,
                          "Edmonton"     =>  "none" ,
                          "Calgary"      =>  "none" ,
                          "Ottawa"       =>  "OntTOU" ,
                          "Toronto"      =>  "OntTOU" ,
                          "Quebec"       =>  "1-day" ,
                          "Montreal"     =>  "1-day" ,
                          "Vancouver"    =>  "2-month",
                          "Regina"       =>  "none" ,
                          "Winnipeg"     =>  "none" ,
                          "Fredricton"   =>  "none" ,
                          "Whitehorse"   =>  "1-month"   ); 
 
    my %NG_TierType  = (  "Halifax"      =>  "none" ,
                          "Edmonton"     =>  "none" ,
                          "Calgary"      =>  "none" ,
                          "Ottawa"       =>  "1-month" ,
                          "Toronto"      =>  "1-month" ,
                          "Quebec"       =>  "1-month" ,
                          "Montreal"     =>  "1-month" ,
                          "Vancouver"    =>  "none",
                          "Regina"       =>  "none" ,
                          "Winnipeg"     =>  "none" ,
                          "Fredricton"   =>  "none" ,
                          "Whitehorse"   =>  "NA"   ); 
 
    
    my %EffElectricRates = ( "Halifax"    => 0.1436 ,
                             "Edmonton"   => 0.1236 ,
                             "Calgary"    => 0.1224 ,
                             "Regina"     => 0.1113 ,
                             "Winnipeg"   => 0.0694 ,
                             "Fredricton" => 0.0985   ); 
    # TOU for ottawa, toronto.                        
    $EffElectricRates{"Ottawa"}{"off-peak"} =  0.1025 ;                        
    $EffElectricRates{"Ottawa"}{"mid-peak"} =  0.1385 ;
    $EffElectricRates{"Ottawa"}{"on-peak"}  =  0.1575 ;
        
    $EffElectricRates{"Toronto"}{"off-peak"} =  0.0967 ;  
    $EffElectricRates{"Toronto"}{"mid-peak"} =  0.1327 ;
    $EffElectricRates{"Toronto"}{"on-peak"}  =  0.1517 ;
  
    # Tiers for Montreal, Quebec 
    $EffElectricRates{"Montreal"}{"30"}   = 0.0532 ;
    $EffElectricRates{"Montreal"}{"9.9E99"} = 0.0751 ; 
    $EffElectricRates{"Quebec"} = $EffElectricRates{"Montreal"}; 
    
    # Tiers for Vancouver
    $EffElectricRates{"Vancouver"}{"1350"} = 0.0714 ; 
    $EffElectricRates{"Vancouver"}{"9.9E99"} = 0.1070 ; 
  
    # Tiers for Whitehorse 
    $EffElectricRates{"Whitehorse"}{"1000"} =  0.0967 ; 
    $EffElectricRates{"Whitehorse"}{"2500"} =  0.1327 ;
    $EffElectricRates{"Whitehorse"}{"9.9E99"} =  0.1517 ;
  
  
  
    my %EffGasRates  = (  "Halifax"      =>  0.5124 ,
                          "Edmonton"     =>  0.1482 ,
                          "Calgary"      =>  0.1363 ,
                          "Vancouver"    =>  0.2923 ,
                          "Regina"       =>  0.2163 ,
                          "Winnipeg"     =>  0.2298 ,
                          "Fredricton"   =>  0.6458 ,
                          "Whitehorse"   =>  99999.9   ); 
   
    # Tiers for ottawa, toronto
    $EffGasRates{"Ottawa"}{"30"}     = 0.2669; 
    $EffGasRates{"Ottawa"}{"85"}     = 0.2622; 
    $EffGasRates{"Ottawa"}{"790"}    = 0.2586; 
    $EffGasRates{"Ottawa"}{"9.9E99"} = 0.2564;
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
    
    if ( $units =~ /GJ/ || $units =~ /kWh\/s/ || $units =~ /m3\/s/  ) {
    
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
  
  my $NumberOfRows = scalar(@{$data{$headers[0]}});

  stream_out("done (parsed $NumberOfRows rows)\n"); 

  # Recover electrical, natural gas, oil, propane, wood, or pellet consumption data 
  my @Electrical_Use = @{ $data{" total fuel use:electricity:all end uses:quantity (kWh/s)"} };
  my @NaturalGas_Use = @{ $data{" total fuel use:natural gas:all end uses:quantity (m3/s)"}  };
  my @Oil_Use        = @{ $data{" total fuel use:oil:all end uses:quantity (l/s)"}  };
  my @Propane_Use    = @{ $data{" total fuel use:propane:all end uses:quantity (m3/s)"}  };
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
  #my $WoodConsumptionCost  = 0; 
  #my $PelletsConsumptionCost  = 0; 

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
    
    $OilConsumptionCost += $CurrentOilConsumption * ( $OilSupplyCharge ); 
    
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
    
    #my $CurrentWoodConsumption = $Wood_Use[$row] * $TSLength; # l
    
    #$WoodConsumptionCost += $CurrentWoodConsumption * ( $WoodSupplyCharge ); 

		
	#### Pellets
    
    #my $CurrentPelletsConsumption = $Pellets_Use[$row] * $TSLength; # l
    
    #$PelletsConsumptionCost += $CurrentPelletsConsumption * ( $PelletsSupplyCharge ); 
  }



  my $TotalElecBill = $Elec_BaseCharge{$Locale}* 12. + $ElecConsumptionCost ; 
  my $TotalGasBill  = $GasConsumptionCost < 0.01 ? 0 : $NG_BaseCharge{$Locale} * 12. + $GasConsumptionCost  ; 
  
  my $TotalOilBill  = $OilFixedCharge * 12. + $OilConsumptionCost  ; 
  
  my $TotalPropaneBill  = $PropaneFixedCharge * 12. + $PropaneConsumptionCost  ; 
  
  #my $TotalWoodBill  = $WoodFixedCharge * 12. + $WoodConsumptionCost  ; 
	
  #my $TotalPelletsBill  = $PelletsFixedCharge * 12. + $PelletsConsumptionCost  ; 
  
  # Add data from externally computed SDHW (presently not accounting for pump energy...)
  my $sizeSDHW = $gChoices{"Opt-SolarDHW"}; 
  $gSimResults{"SDHW production::AnnualTotal"} = -1.0 * $gOptions{"Opt-SolarDHW"}{"options"}{$sizeSDHW}{"ext-result"}{"production-DHW"};
  
    
  # Adjust solar DHW energy credit to reflect actual consumption. Assume 
  # SDHW credit cannot be more than 60% of total water load. 
  
  $gSimResults{"SDHW production::AnnualTotal"} = min( $gSimResults{"SDHW production::AnnualTotal"}*-1.,
                                         0.6 * $gSimResults{"total_fuel_use/test/all_fuels/water_heating/energy_content::AnnualTotal"} 
                                       ) * (-1.) ; 
  
  
  
  

  # Add data from externally computed PVs. 
  
  
  my $PVsize = $gChoices{"Opt-StandoffPV"}; 
  my $PVArrayCost;
  my $PVArraySized; 
  if ( $PVsize !~ /SizedPV/ ){
    
    # Use spec'd PV sizes 
    $gSimResults{"PV production::AnnualTotal"}=-1.0*$gExtOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"ext-result"}{"production-elec-perKW"}; 
  
  }else{
    # Size pv to max, or to size required to reach Net-Zero. 
    my $prePVEnergy = 0;

    # gSimResults contains all sorts of data. Filter by annual energy consumption (rows containing AnnualTotal).
    foreach my $token ( sort keys %gSimResults ){
      if ( $token =~ /AnnualTotal/ ){ 
        my $value = $gSimResults{$token};
        $prePVEnergy += $value; 
      }    
    }

    if ( $prePVEnergy > 0 ){
    
      # This should always be the case!
      
	  my $PVUnitOutput = $gOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"ext-result"}{"production-elec-perKW"};
	  my $PVUnitCost   = $gOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"cost"};
	 
     debug_out (" >>> UNOT OUT: $PVsize | $PVUnitOutput | $PVUnitCost\n"); 
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
    print ">$PVsize ...\n"; 
    
  }  
  
  $gChoices{"Opt-StandoffPV"}=$PVsize;
  $gOptions{"Opt-StandoffPV"}{"options"}{$PVsize}{"cost"} = $PVArrayCost;

  stream_out("\n\n Energy Consumption: \n\n") ; 

  my $gTotalEnergy = 0;

  foreach my $token ( sort keys %gSimResults ){

    if ( $token =~ /AnnualTotal/ ){
        my $value = $gSimResults{$token};
        $gTotalEnergy += $value; 
        stream_out ( "  + $value ( $token, GJ ) \n");
    }
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

  $gEnergyElec  =  defined($gSimResults{"total_fuel_use/electricity/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/electricity/all_end_uses/quantity::Total_Average"} : 0 ;  
  
  $gEnergyGas   = defined($gSimResults{"total_fuel_use/natural_gas/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/natural_gas/all_end_uses/quantity::Total_Average"} : 0 ;  
  
  $gEnergyOil   = defined($gSimResults{"total_fuel_use/oil/all_end_uses/quantity::Total_Average"} ) ? 
                         $gSimResults{"total_fuel_use/oil/all_end_uses/quantity::Total_Average"} : 0 ;  
  
  
  
  stream_out("\n\n Energy Cost (not including credit for PV, direction $gRotationAngle ): \n\n") ; 
  
  stream_out("  + \$ ".round($TotalElecBill)." (Electricity)\n");
  stream_out("  + \$ ".round($TotalGasBill)." (Natural Gas)\n");
  stream_out("  + \$ ".round($TotalOilBill)." (Oil)\n");
  stream_out("  + \$ ".round($TotalPropaneBill)." (Propane)\n");

  stream_out ( " --------------------------------------------------------\n");
  stream_out ( "    \$ ".round($TotalElecBill+$TotalGasBill+$TotalOilBill+$TotalPropaneBill) ." (All utilities).\n"); 



  
  # Update global params for use in summary 
  $gAvgCost_NatGas    += $TotalGasBill  * $ScaleData; 
  $gAvgCost_Electr    += $TotalElecBill * $ScaleData;  
  $gAvgCost_Propane   += $TotalPropaneBill * $ScaleData; 
  $gAvgCost_Oil       += $TotalOilBill * $ScaleData; 
  $gAvgEnergy_Total   += $gTotalEnergy  * $ScaleData; 
  $gAvgNGasCons_m3    += $gEnergyGas * 8760. * 60. * 60.  * $ScaleData ; 
  $gAvgOilCons_l      += $gEnergyOil * 8760. * 60. * 60.  * $ScaleData ; 
  $gAvgElecCons_KWh   += $gEnergyElec * 8760. * 60. * 60. * $ScaleData ; 
  
  stream_out("\n\n Energy Use (not including credit for PV, direction $gRotationAngle ): \n\n") ; 
  
  stream_out("  - ".round($gEnergyElec* 8760. * 60. * 60.)." (Electricity, kWh)\n");
  stream_out("  - ".round($gEnergyGas* 8760. * 60. * 60.)." (Natural Gas, m3)\n");
  stream_out("  - ".round($gEnergyOil* 8760. * 60. * 60.)." (Oil, l)\n");
  
  stream_out ("> SCALE $ScaleData \n"); 
  
  
  # Estimate total cost of upgrades

  $gTotalCost = 0;         
  my $RegionalCostAdj = $RegionalCostFactors{$Locale}; 
  stream_out ("\n\n Estimated costs in $Locale (x$RegionalCostAdj Ottawa costs) : \n\n");

  foreach my  $attribute ( sort keys %gChoices ){
    
    my $choice = $gChoices{$attribute}; 
    my $cost; 
    $cost  = $gOptions{$attribute}{"options"}{$choice}{"cost"} * $RegionalCostAdj;
    $gTotalCost += $cost ;

    stream_out( " +  ".round($cost)." ( $attribute : $choice ) \n");
    
  }
  stream_out ( " - ".round($gIncBaseCosts * $RegionalCostAdj)." (Base costs for windows)  \n"); 
  stream_out ( " --------------------------------------------------------\n");
  stream_out ( " =   ".round($gTotalCost-$gIncBaseCosts* $RegionalCostAdj )." ( Total incremental cost ) \n");

  chdir($gMasterPath);
  my $fileexists; 

  
  
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
