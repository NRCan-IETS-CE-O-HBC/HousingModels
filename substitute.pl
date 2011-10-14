#!/usr/bin/perl

# This script parses through the files

use warnings;
use strict;
#use File::Compare;
use Cwd;
use Cwd 'chdir';
use File::Find;
#use Math::Trig;



my %gTest_params;          # test parameters
my $gChoiceFile  = ""; 
my $gOptionFile  = "" ; 

my $gBPSpath            = "/home/aferguso/esp-r/bin/bps"; 
my $gPRJpath            = "/home/aferguso/esp-r/bin/prj"; 

my $gBaseModelFolder    = "NZEH-base";
my $gWorkingModelFolder = "NZEH-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "NZEH.cfg";
my $gISHcmd             = "./run.sh $gModelCfgFile";
my $gPRJcmd             = "$gPRJpath -mode text -file $gModelCfgFile -act update_con_files";
my $gBPScmd             = "$gBPSpath -file $gModelCfgFile -mode text -p optrun silent";

my $gSkipISH            = 0; 

my %gChoices; 
my %gOptions;

$gTest_params{"verbosity"} = "quiet"; 
$gTest_params{"logfile"}   = "log.txt"; 

#-------------------------------------------------------------------
# Optionally write text to buffer
#-------------------------------------------------------------------
sub stream_out($){
  my($txt) = @_;
  if ($gTest_params{"verbosity"} ne "quiet"){
    print $txt;
  }
}

#-------------------------------------------------------------------
# Display a fatal error and quit.
#-------------------------------------------------------------------

sub fatalerror($){
  my ($err_msg) = @_;

  if ( $gTest_params{"verbosity"} eq "very_verbose" ){
    #print echo_config();
  }
  print "\nsubstitute.pl -> Fatal error: \n";
  print " >>> $err_msg \n\n";
  die;
}


#--------------------------------------------------------------------
# Perform system commands with optional redirection
#--------------------------------------------------------------------
sub execute($){
  my($command) =@_;
  my $result;
  if ($gTest_params{"verbosity"} eq "very_verbose"){    
    print "\n > executing $command \n";
    print   " > from path ".getcwd()." \n";
    system ($command); 
    return; 
  }
  
  if ($gTest_params{"logfile"}){
    $result = system("$command >$gTest_params{\"logfile\"} 2>&1 ");
  }else{
    $result = system($command);
  }
  return $result;
}


# List of extentions that we should operate on

my @search_these_exts=( "cfg",
                        "aim",
                        "hvac",
                        "con",
                        "vnt",
                        "geo",
                        "constrdb"
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
                  -v(v) (--skipISH);
                       
";
# dump help text, if no arguement given
if (!@ARGV){
  print $Help_msg;
  die;
}
                       
                       
my $master_path = getcwd();                       

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
    
    if ( $arg =~ /^--verbose/ ){
      # stream out progess messages
      $gTest_params{"verbosity"} = "verbose";
      
      last SWITCH;
    }
    if ( $arg =~ /^--very_verbose/ ){
      # steam out all messages
      $gTest_params{"verbosity"} = "very_verbose";
      $gTest_params{"logfile"}="";

      last SWITCH;
    }    
    if ( $arg =~ /^--skipISH/ ){
      # stream out progess messages
      $gSkipISH = 1;
      
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


stream_out (" > substitute.pl path: $master_path \n");
stream_out (" >               ChoiceFile: $gChoiceFile \n");
stream_out (" >               OptionFile: $gOptionFile \n");

# Parse option file 
open ( OPTIONS, "$gOptionFile") or fatalerror("Could not read $gOptionFile!");
stream_out("\n\nReading $gOptionFile... \n");
my $linecount = 0;


## Optimization substututions 
#
#
#*attribute:start    
#*attribute:name = Opt:AirTightness
#*attribute:tag  = <Opt:AirTightness>
#
#*option:Air-Tightness-0:value =   base.aim  
#*option:Air-Tightness-0:cost  =   0
#
#*option:Air-Tightness-1:value =   R2000.aim
#*option:Air-Tightness-1:cost  =   500
#
#*option:Air-Tightness-2:value =   PassiveHouse.aim
#*option:Air-Tightness-2:cost  =   1200
#
#*attribute:end

my $currentAttributeName ="";
my $AttributeOpen = 0;

my %currentOptions; 
my %currentTags; 

while ( my $line = <OPTIONS> ){
  
  $line =~ s/#.+$//g; 
  $line =~ s/\s*//g;
  $linecount++;

    
  
  stream_out ("  Line: $linecount >$line<\n");
  
  if ( $line ) {
  
    my ( $token, $value ) = split /=/, $line ;

    # Open up a new attribute    
    if ( $token =~ /^\*attribute:start/ ){
    
      $AttributeOpen = 1; 
    
    }
   
    # Parse attribute contents Name/Tag/Option(s)
    if ( $AttributeOpen ) {
    
      if ( $token =~ /^\*attribute:name/ ){
    
        $currentAttributeName = $value ;
        
      }
      
      if ( $token =~ /^\*attribute:tag/ ){
    
        my($rubbish,$junk,$TagIndex) = split /:/, $token;
    
        $currentTags{$TagIndex} = $value;
    
      }
      
      if ( $token =~ /^\*option:.+:value:[0-9]+$/){
      
        my( $rubbish, $OptionName, $junk, $ValueIndex ) = split /:/, $token;
        
        $currentOptions{$OptionName}{"values"}{$ValueIndex} = $value; 
      
      }
      
      if ( $token =~ /^\*option:.+:cost$/){
      
        my( $rubbish, $OptionName, $junk ) = split /:/, $token;
        
        $currentOptions{$OptionName}{"cost"} = $value; 
      
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
      
                                    
        $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"cost"}
                                    = $currentOptions{$optionIndex}{"cost"}; 
        
        # Strip ($) from cost, if present.          
        $gOptions{$currentAttributeName}{"options"}{$optionIndex}{"cost"}=~s/\$//g;

      }
     
      for ( keys %currentOptions ){ delete $currentOptions{$_} ;}
      for ( keys %currentTags )   { delete $currentTags{$_} ;}   
      
    }
    
    

  
  }
  
}
close (OPTIONS);



# Parse configuration (choice file ) 


open ( CHOICES, "$gChoiceFile" ) or fatalerror("Could not read $gChoiceFile!");

stream_out("\n\nReading $gChoiceFile... \n");

$linecount = 0;

while ( my $line = <CHOICES> ){
  
  $line =~ s/#.+$//g; 
  $line =~ s/\s*//g;
  $linecount++;
  stream_out ("  Line: $linecount >$line<\n");
  
  if ( $line ) {
  my ($attribute, $value) = split /:/, $line;
  
  $gChoices{"$attribute"}=$value 
  
  }

}

close( CHOICES );
stream_out ("...done.\n") ; 






# Report 
my $allok = 1;
while ( my ( $attribute, $choice) = each %gChoices ){
  
  
  
  # is attribute defined in options 
  if ( ! defined( $gOptions{$attribute} ) ){
    stream_out ( "\nERROR: Attributre $attribute appears in choice file ($gChoiceFile), \n");
    stream_out (   "       but can't be found in options file ($gOptionFile)\n");
    $allok = 0;
  }
  if (   defined( $gOptions{$attribute} ) &&
       ! defined( $gOptions{$attribute}{"options"}{$choice} )    ){
    stream_out ( "\nERROR: Choice $choice (for attribute $attribute, defined \n");
    stream_out (   "       in choice file $gChoiceFile), is not defined \n");
    stream_out (   "       in options file ($gOptionFile)\n");
    $allok = 0;
  }    
  
  
  if ($allok){
    my $cost  = $gOptions{$attribute}{"options"}{$choice}{"cost"};
    
    stream_out ( "\n\nMAPPING for $attribute = $choice (@ \$$cost inc. cost): \n"); 
    
    my $TagHash = $gOptions{$attribute}{"tags"}; 
    my $ValHash = $gOptions{$attribute}{"options"}{$choice}{"values"};
    
    
    for my $tagIndex ( sort keys (%$TagHash) ){
      my $tag   = ${$TagHash}{$tagIndex};
      my $value = ${$ValHash}{$tagIndex};
      
      #stream_out ("          looking for : \$gOptions{ $attribute }{\"options\"}{ $choice }{\"values\"}\n");
      stream_out ("          $tag -> $value \n");
      
      
    
    }
  }
}

if ( ! $allok ) { 
    fatalerror(" Choices in $gChoiceFile do not match options in $gOptionFile!");
}



# Now create a copy of our base ESP-r file for manipulation. 
stream_out("\n\n Creating a working folder for optimization work...");
system ("rm -fr $gWorkingModelFolder ");
system ("cp -fr $gBaseModelFolder $gWorkingModelFolder ");
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


# Run the simulation 
chdir $gWorkingCfgPath; 
stream_out ("\n\n Moved to path:". getcwd()."\n"); 

if ( ! $gSkipISH ){
  stream_out("\n\n Invoking ish via run.sh...");
  execute($gISHcmd); 
  stream_out("done...\n")
}

stream_out ("\n\n Invoking prj to update con files (\"$gPRJcmd\")...");
execute($gPRJcmd);
stream_out ("done. \n");  
stream_out ("\n\n Invoking ESP-r (\"$gBPScmd\")..." ); 
execute($gBPScmd); 
stream_out ("done. \n");         
        
# Compile results from simulation 

# Estimate total cost of upgrades

my $gTotalCost = 0;         

stream_out ("\n\n Estimated costs: \n\n");

foreach my  $attribute ( sort keys %gChoices ){
  
  my $choice = $gChoices{$attribute}; 
  
  my $cost  = $gOptions{$attribute}{"options"}{$choice}{"cost"};
  
  $gTotalCost += $cost;

  stream_out( " +  $cost ( $attribute : $choice ) \n");
  
}
stream_out ( " --------------------------------------------------------\n");
stream_out ( " =   $gTotalCost ( Total incremental cost ) \n");

# Parse the output file 

open (SIMRESULTS, "out.summary") or fatalerror("Could not open ".getcwd()."/out.summary!");


my %gSimResults; 

while ( my $line = <SIMRESULTS> ){

  my ( $token, $value, $units ) = split / /, $line; 
  
  if ( $units =~ /GJ/ ) {
  
    $gSimResults{$token} = $value; 
  
  }
  
}


close(SIMRESULTS);

stream_out("\n\n Energy Consumption: \n\n") ; 

my $gTotalEnergy = 0;

foreach my $token ( sort keys %gSimResults ){

  my $value = $gSimResults{$token};
  $gTotalEnergy += $value; 
  
  stream_out ( "  + $value ( $token, GJ ) \n");

}

stream_out ( " --------------------------------------------------------\n");
stream_out ( "    $gTotalEnergy ( Total energy, GJ ) \n");


# Save output files
if ( ! -d "$gMasterPath/sim-output" ) {

  execute("mkdir $gMasterPath/sim-output") or die ("Could not create $gMasterPath/sim-output!"); 
  
}

execute("cp $gMasterPath/$gWorkingCfgPath/out* $gMasterPath/sim-output/");
        
        
# Cleanup
stream_out("\n\n Deleting working folder...");
#system ("rm -fr $gWorkingModelFolder ");
stream_out("done.");

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
  
    
    while ( my ( $attribute, $choice) = each %gChoices ){
    
    
      my $tagHash = $gOptions{$attribute}{"tags"};
      my $valHash = $gOptions{$attribute}{"options"}{$choice}{"values"};
    
      for my $tagIndex ( keys ( %{$tagHash} ) ){
        
        my $tag   = ${$tagHash}{$tagIndex};
        my $value = ${$valHash}{$tagIndex};
      
     
        $line =~ s/$tag/$value/g; 
        
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
