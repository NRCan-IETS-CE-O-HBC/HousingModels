


#-------------------------------------------------------------------
# Optionally write text to buffer
#-------------------------------------------------------------------
sub stream_out($){
  my($txt) = @_;
  if ($gTest_params{"verbosity"} ne "quiet"){
    print $txt;
  }
}

sub round($){
  my ($var) = @_; 
  my $tmpRounded = int( abs($var) + 0.5);
  my $finalRounded = $var >= 0 ? 0 + $tmpRounded : 0 - $tmpRounded;
  return $finalRounded;
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

my $gBaseModelFolder    = "NZEH-base";
my $gWorkingModelFolder = "NZEH-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "NZEH.cfg";


1; 