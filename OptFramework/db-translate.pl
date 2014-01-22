#!/usr/bin/perl
use warnings;
use strict; 
use DBI ; 

# Prototypes
sub ExtraData($$$);
sub GetH3KMaterialType($);
sub GetH3kMaterialsInCatagory($);
sub round($$); 

# Path to Database: Currently hardcoded. 

my $DBPath="/cygdrive/c/HOT3000Beta_db/Stdlibs/standard2.mat"; 


# Open database for uses
print ("Reading: $DBPath \n"); 
my $DBHandle = DBI -> connect(
  "dbi:SQLite:dbname=$DBPath",
  "",
  "",
  { RaiseError=>1 },
) or die $DBI::errstr;

# Empty output 
my $output = ""; 
my $header = "*Materials 1.1
*date,Sat Feb 13 12:15:16 2010
# materials database defined from HOT3000 definitions
*doc,ESP-r Materials based on HOT3000.
"; 

my $numClasses = 0; 

# Get the master list of catagories. 


my $CatStatement = $DBHandle->prepare("SELECT * FROM  H3KMatCategories");
$CatStatement->execute();




print "-------- CATATGORIES ---------------\n"; 

my %catagories;

# Get the rows from the catagory table 
while (my $CatRow = $CatStatement->fetchrow_arrayref()) {
    
    $numClasses++; 
    
    # Recover row members
    my ( $H3KMatCat_id, $cat_name, $h3kLayerType, $h3Klsitmane) =  @$CatRow; 
    
    # Catagory names must be under 32 characterts. 
    $cat_name = substr($cat_name , 0, 30); 
    
    
    # Put into catagory hash. 
    $catagories{$H3KMatCat_id}{"MatCatagory"} = $cat_name; 

    # Get a list of the materials in this catagory by their ID (H3KMatType)
    my @MatInCatagory  = GetH3kMaterialsInCatagory($H3KMatCat_id);     
    
    # Recover number of materials in list
    my $MatTypeCount = @MatInCatagory; 
    
    
    
    $output .= "#------ START Catagory $cat_name -----------------------\n"; 
    $output .= "*class, $H3KMatCat_id, $MatTypeCount, $cat_name \n";
    $output .= "Generic description about $cat_name goes here\n";
    
    
    print " - $H3KMatCat_id : ".$catagories{$H3KMatCat_id}{"MatCatagory"}."\n"; 
    
     

     
    
    foreach my $H3KMatType_id (sort @MatInCatagory  ){
    
        my %MaterialType = GetH3KMaterialType($H3KMatType_id); 
                          
    #    %MatReturnProp = ( "H3KMatType"         => $MatID, 
    #                      "MatTypeName"     => $MatTypeName, 
    #                      "MatCatagory"     => $dummyMATCAT, 
    #                      "H3KListCode"     => $H3KListCide, 
    #                      "H3KThermID"      => $H3KThermID,
    #                      "H3KCostID"       => $H3KCostID,
    #                      "H3KCostOnly"     => $CostOnly ); 

    
        print "   +->$H3KMatType_id: ->".$MaterialType{"MatTypeName"}."<-+\n"; 
        
        # Each item is reported on two lines: General discription, 
        $output .= "*item, ".substr($MaterialType{"MatTypeName"},0,32).", "                   # Name 
                            .$MaterialType{"H3KMatType"}.", "                    # Index 
                            .$MaterialType{"MatCatagory"}.", ".                  # Pointer to catagory
                            "Desc:".$MaterialType{"MatTypeName"}."\n";           # Description 
 
        # And thermal propoerties 
        $output .= round($MaterialType{"ThermConductivity"},3).", ";
        $output .= round($MaterialType{"ThermDensity"},1).", ";
        $output .= round($MaterialType{"ThermSpecHeat"}*1000,3).", ";
        $output .= round($MaterialType{"EMM_out"},4).",";
        $output .= round($MaterialType{"EMM_in"},4).",";
        $output .= round($MaterialType{"ABS_out"},4)   .",";
        $output .= round($MaterialType{"ABS_in"},3)   .",";
        $output .= "5.00,";  # Diffusion resistance irrelevant for thermal simulation. 
        $output .= round($MaterialType{"ThermDefaultThickness"},1).",";
        $output .="\n"; 
 
 
    }
 
    
    #} #*item,Paviour brick,  1, 1,Paviour brick
    
}


# Materials have the following attributes:
#  conductivity (W/(m-K), density (kg/m**3) specific heat (J/(kg-K)
#  emissivity out (-) emissivity in (-)#   absorptivity out (-) absorptivity in (-)
#  diffusion rest (?) default thickness (mm)
#  flag [-] legacy [o] opaque [t] transparent
#       [g] gas data+T cor [h] gas data at 4T
#  
# Transparent material attributes:
#  longwave tran (-) solar direct tran (-) solar reflec out (-) solar refled in (-)
#  visable tran (-) visable reflec out (-) visable reflec in (-) colour rendering (-)
#  
# Gas material attributes:
#  (first 9 items the same) [g] or [h]
#  air gap resistance for vert horiz other
#  [g] 2 conduction, 2 viscosity, 2 density
#      2 prandtl, 2 specific heat
#  [h] 4 conduction, 4 viscosity, 4 density
#      prandtl, specific heat
#  

$header .= "$numClasses  # number of classifications\n"; 

print "\n=============== OUTPUT ====================\n";

print $header; 
print $output; 


$DBHandle->disconnect(); 


open (MatDbOut, ">NZEH-work/dbs/H3kMaterials.db.a") or fatalerror("Could not open ".getcwd()."/MatOut.db!");
print MatDbOut $header; 
print MatDbOut $output; 
close (MatDbOut); 


die ("done!"); 


sub GetH3KMaterialType($){
    my ($id) = @_; 
    
    my %MatReturnProp = () ; 
    
    my $MatStatement = $DBHandle->prepare("SELECT * FROM H3KMatTypes where H3KMatType=$id ");
    $MatStatement->execute(); 
       
    
    my $MatRow = $MatStatement->fetchrow_arrayref();
    my ($MatID, $MatTypeName, $MATCAT, $H3KListCide, $H3KThermID,$H3KCostID,$CostOnly) = @$MatRow;
    $MatStatement->finish; 
    # H3K uses commas in names, Make sure we strip them out. 
    $MatTypeName =~ s/,//g; 
 

    #print "Q.....  $id |   $MatID |     $MatTypeName - ".$MatReturnProp{"MatTypeName"}."\n";                    
    
    my $ThermStatement = $DBHandle->prepare("SELECT * FROM H3KTherm_prop where ThermID=$H3KThermID ");
    $ThermStatement->execute(); 
    my $ThermRow = $ThermStatement->fetchrow_arrayref();
    $ThermStatement->finish; 
    my ($Dummy,
        $ThermMatDesc,
        $ThemDefThickness, 
        $ThermResistivity, 
        $ThermConductivity,
        $ThermDensity,
        $ThermSpecHeat,
        $ThermFixedThickness ) = @$ThermRow; 
    
    %MatReturnProp = (    "H3KMatType"            => $MatID, 
                          "MatTypeName"           => $MatTypeName, 
                          "MatCatagory"           => $MATCAT, 
                          "H3KListCode"           => $H3KListCide, 
                          "H3KThermID"            => $H3KThermID,
                          "H3KCostID"             => $H3KCostID,
                          "H3KCostOnly"           => $CostOnly,
                          "ThermDefaultThickness" => $ThemDefThickness,                           
                          "ThermResistivity"      => $ThermResistivity,                           
                          "ThermConductivity"     => $ThermConductivity,                          
                          "ThermDensity"          => $ThermDensity,                          
                          "ThermSpecHeat"         => $ThermSpecHeat,                          
                          "ThermFixedThickness"   => $ThermFixedThickness,
                          "ABS_out"               => ExtraData($MATCAT,"ABS","AVG"),
                          "ABS_in"                => ExtraData($MATCAT,"ABS","AVG"),
                          "EMM_out"               => ExtraData($MATCAT,"EMM","AVG"),
                          "EMM_in"                => ExtraData($MATCAT,"EMMs","AVG")
                          
                          ); 

    
    
    
    return %MatReturnProp;                           
 
}

sub GetH3kMaterialsInCatagory($){

  my ($id) = @_;

  my @materialids=(); 
  my $MatStatement = $DBHandle->prepare("SELECT * FROM H3KMatTypes where H3KMatCat=$id ");
  $MatStatement->execute(); 
  while (my $MatRow = $MatStatement->fetchrow_arrayref() ){
    my ($MatID, $MatTypeName, $dummyMATCAT, $H3KListCide, $H3KThermID,$H3KCostID,$CostOnly) = @$MatRow;
    push @materialids, $MatID; 
  }
  $MatStatement->finish; 
  return @materialids; 
  
}

sub round($$){
  my ($var,$places) = @_; 
   
  my $tmpRounded = int( abs($var*(10**$places)) + 0.5);
  my $finalRounded = $var >= 0 ? 0 + $tmpRounded : 0 - $tmpRounded;
  return $finalRounded/10**$places;
}


sub ExtraData($$$){

 my ($Catagory,$Property,$Value) = @_; 

 my %Data; 
 
$Data{"ABS"}{"0"}{"MAX"}=	0.06   ;
$Data{"ABS"}{"1"}{"MAX"}=	0.9    ;
$Data{"ABS"}{"2"}{"MAX"}=	0.93   ;
$Data{"ABS"}{"3"}{"MAX"}=	0.99   ;
$Data{"ABS"}{"4"}{"MAX"}=	0.9    ;
$Data{"ABS"}{"5"}{"MAX"}=	0.65   ;
$Data{"ABS"}{"6"}{"MAX"}=	0.7    ;
$Data{"ABS"}{"7"}{"MAX"}=	0.6    ;
$Data{"ABS"}{"8"}{"MAX"}=	0.7    ;
$Data{"ABS"}{"9"}{"MAX"}=	0.5    ;
$Data{"ABS"}{"10"}{"MAX"}=	0.7    ;
$Data{"ABS"}{"11"}{"MAX"}=	0.2    ;

$Data{"ABS"}{"0"}{"MIN"}=  0.05     ;
$Data{"ABS"}{"1"}{"MIN"}=  0.26     ;
$Data{"ABS"}{"2"}{"MIN"}=  0.48     ;
$Data{"ABS"}{"3"}{"MIN"}=  0.9      ;
$Data{"ABS"}{"4"}{"MIN"}=  0.9      ;
$Data{"ABS"}{"5"}{"MIN"}=  0.65     ;
$Data{"ABS"}{"6"}{"MIN"}=  0.3      ;
$Data{"ABS"}{"7"}{"MIN"}=  0.5      ;
$Data{"ABS"}{"8"}{"MIN"}=  0.3      ;
$Data{"ABS"}{"9"}{"MIN"}=  0.3      ;
$Data{"ABS"}{"10"}{"MIN"}=  0.65    ;
$Data{"ABS"}{"11"}{"MIN"}=  0.2     ;

$Data{"ABS"}{"0"}{"AVG"}=   0.0571   ;
$Data{"ABS"}{"1"}{"AVG"}=   0.6467   ;
$Data{"ABS"}{"2"}{"AVG"}=   0.6505   ;
$Data{"ABS"}{"3"}{"AVG"}=   0.975    ;
$Data{"ABS"}{"4"}{"AVG"}=   0.9      ;
$Data{"ABS"}{"5"}{"AVG"}=   0.65     ;
$Data{"ABS"}{"6"}{"AVG"}=   0.6333   ;
$Data{"ABS"}{"7"}{"AVG"}=   0.5333   ;
$Data{"ABS"}{"8"}{"AVG"}=   0.55     ;
$Data{"ABS"}{"9"}{"AVG"}=   0.3667   ;
$Data{"ABS"}{"10"}{"AVG"}=   0.66    ;
$Data{"ABS"}{"11"}{"AVG"}=   0.2     ;

$Data{"EMM"}{"0"}{"MAX"}=	0.06      ;
$Data{"EMM"}{"1"}{"MAX"}=	0.9       ;
$Data{"EMM"}{"2"}{"MAX"}=	0.93      ;
$Data{"EMM"}{"3"}{"MAX"}=	0.99      ;
$Data{"EMM"}{"4"}{"MAX"}=	0.9       ;
$Data{"EMM"}{"5"}{"MAX"}=	0.65      ;
$Data{"EMM"}{"6"}{"MAX"}=	0.7       ;
$Data{"EMM"}{"7"}{"MAX"}=	0.6       ;
$Data{"EMM"}{"8"}{"MAX"}=	0.7       ;
$Data{"EMM"}{"9"}{"MAX"}=	0.5       ;
$Data{"EMM"}{"10"}{"MAX"}=	0.7       ;
$Data{"EMM"}{"11"}{"MAX"}=	0.2       ;
   
$Data{"EMM"}{"0"}{"MIN"}=	0.05    ;
$Data{"EMM"}{"1"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"2"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"3"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"4"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"5"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"6"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"7"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"8"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"9"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"10"}{"MIN"}=	0.9     ;
$Data{"EMM"}{"11"}{"MIN"}=	0.12    ;
   
$Data{"EMM"}{"0"}{"AVG"}=	0.4671    ;
$Data{"EMM"}{"1"}{"AVG"}=	0.9047    ;
$Data{"EMM"}{"2"}{"AVG"}=	0.9071    ;
$Data{"EMM"}{"3"}{"AVG"}=	0.975     ;
$Data{"EMM"}{"4"}{"AVG"}=	0.9       ;
$Data{"EMM"}{"5"}{"AVG"}=	0.9       ;
$Data{"EMM"}{"6"}{"AVG"}=	0.9       ;
$Data{"EMM"}{"7"}{"AVG"}=	0.9       ;
$Data{"EMM"}{"8"}{"AVG"}=	0.9       ;
$Data{"EMM"}{"9"}{"AVG"}=	0.9       ;
$Data{"EMM"}{"10"}{"AVG"}=   0.9       ;
$Data{"EMM"}{"11"}{"AVG"}=   0.1533    ;

return $Data{$Property}{$Catagory}{$Value}; 

}






