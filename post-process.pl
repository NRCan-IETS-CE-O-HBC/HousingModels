#!/usr/bin/perl


# Parse the output file 
use warnings;
use strict;
#use File::Compare;
use Cwd;
use Cwd 'chdir';
use library; 

my $TSLength            = 3600. ;  # Seconds
my $gBaseModelFolder    = "NZEH-base";
my $gWorkingModelFolder = "NZEH-work"; 
my $gWorkingCfgPath     = "$gWorkingModelFolder/cfg";
my $gModelCfgFile       = "NZEH.cfg";

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
my %data; 
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




stream_out("\n\n Energy Consumption: \n\n") ; 

my $gTotalEnergy = 0;

foreach my $token ( sort keys %gSimResults ){

  my $value = $gSimResults{$token};
  $gTotalEnergy += $value; 
  
  stream_out ( "  + $value ( $token, GJ ) \n");

}

stream_out ( " --------------------------------------------------------\n");
stream_out ( "    $gTotalEnergy ( Total energy, GJ ) \n");


stream_out("\n\n Energy Cost: \n\n") ; 

stream_out("  + \$ ".round($TotalElecBill)." (Electricity)\n");
stream_out("  + \$ ".round($TotalGasBill)." (Natural Gas)\n");

stream_out ( " --------------------------------------------------------\n");
stream_out ( "    \$ ".round($TotalElecBill+$TotalGasBill) ." (All utilities).\n"); 
