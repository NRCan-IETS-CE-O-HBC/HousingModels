#!/usr/bin/perl

use warnings;
use strict;
#use File::Compare;
use Cwd;
use Cwd 'chdir';
use File::Find;
use Math::Trig;
use library; 


my $gBPSpath            = "/home/aferguso/esp-r/bin/bps"; 
my $gPRJpath            = "/home/aferguso/esp-r/bin/prj"; 

my $gBaseModelFolder    = "NZEH-base";
my $gWorkingModelFolder = "NZEH-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "NZEH.cfg";

my $gISHcmd             = "./run.sh $gModelCfgFile";
my $gPRJcmd             = "$gPRJpath -mode text -file $gModelCfgFile -act update_con_files";
my $gBPScmd             = "$gBPSpath -file $gModelCfgFile -mode text -p jan silent";

my $gSkipISH            = 0; 

my $gMasterPath = getcwd();


chdir $gWorkingCfgPath; 

execute("rm ../zones/*.con rm ../zones/*.tmc rm ../zones/*.shd rm ../zones/*.shda out*"); 

stream_out ("\n\n Moved to path:". getcwd()."\n"); 

# Run the simulation 
stream_out ("\n\n Invoking prj to update con files (\"$gPRJcmd\")...");
execute($gPRJcmd);
stream_out ("done. \n");  

 

if ( ! $gSkipISH ){
  stream_out("\n\n Invoking ish via run.sh...");
  execute($gISHcmd); 
  stream_out("done...\n")
}


stream_out ("\n\n Invoking ESP-r (\"$gBPScmd\")..." ); 
execute($gBPScmd); 
stream_out ("done. \n");         
        
        
# Save output files
if ( ! -d "$gMasterPath/sim-output" ) {

  execute("mkdir $gMasterPath/sim-output") or die ("Could not create $gMasterPath/sim-output!"); 
  
}

execute("cp $gMasterPath/$gWorkingCfgPath/out* $gMasterPath/sim-output/");
        
        
# Cleanup
stream_out("\n\n Deleting working folder...");
#system ("rm -fr $gWorkingModelFolder ");
stream_out("done.");

chdir $gMasterPath;