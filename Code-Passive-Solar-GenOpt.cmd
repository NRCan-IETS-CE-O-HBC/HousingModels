/*

 GenOpt command file ANZEH Passive solar

*/
Vary{

   // Orientation: for parametric study 
   
   Parameter{   // 
     Name    =  GOtag:GOconfig_rotate;
     Ini     =  1;
     //Values  =  "S, N, E, W";
     Values  =  "AVG";
   }  

   // Air tightness
   Parameter{   // 
     Name    =  GOtag:Opt-AirTightness;
     Ini     =  1;
     //Values  =  "TypicalGTA, R2000, PassiveHouse";
     Values  =  "TypicalGTA";
   }    
   
   // Mainwalls 
   Parameter{   // 
     Name    =  GOtag:Opt-MainWall;
     Ini     =  1;
     Values  =  "BaseR21"; 
     //Values  =  "BaseR21, SIPS-R29-Wall, ICFR22, SIPS-R29-Wall, SIPS-R38-Wall, SIPS-R44-Wall, Stud-R38-Wall, Stud-R50-Wall, DblStud-R44-Wall, Truss-R40-Wall";
   }    
  
  
   // Ceilings
   Parameter{   // 
     Name    =  GOtag:Opt-Ceilings;
     Ini     =  1;
     Values  =  "CeilingR50";
     // Values  =  "CeilingR50, CeilingR60, CeilingR70, CeilingR80, CeilingR90, CeilingR100, CeilingR110";
   }    
  
  
   // Insulation levels in exposed floor above garage
  
  Parameter{ //
     Name   = GOtag:Opt-ExposedFloor;
     Ini    = 1; 
     Values = "BaseExpFloor-R31";
     //Values = "BaseExpFloor-R31,ExpFloorFlash&Batt-R36,ExpFloorFoamed-R52";
  }
   
   
  // Insulation levels in foundation walls. 
  Parameter{ //
     Name    = GOtag:Opt-BasementWallInsulation;
     Ini     = 1; 
     Values  = "OBC-min-R12";
     //Values  = "OBC-min-R12, Rigid+Batt-R30, Rigid+Blown-R43, ICF-base-R22, ICF-base-R26, ICF-base-R32, ICF-base-R41, ICF-base-R51, ICF-base-R51r";
  }
   
  // Insulation levels in foundation floor 
  Parameter{ // 
     Name    = GOtag:Opt-BasementSlabInsulation;
     Ini     = 1;
     Values  = "NoInsulation";
     //Values  = "NoInsulation, R10UnderSlab, R10UnderSlab+edge, R12UnderSlab+edge, R24UnderSlab+edge";
  }
   
  
  
  // Windows 
  Parameter{   // 
     Name    =  GOtag:Opt-CasementWindows;
     Ini     =  1;
     Values  =  "DoubleLowEHardCoatAirFill, DoubleLowEHardCoatArgFill, DoubleLowESoftCoatArgFill, TripleLowEHardCoatKryFill, TripleLowESoftCoatKryFill";    
     //Values  =  "DoubleLowEHardCoatAirFill";
   }    
    
    
   // Thermal Mass features: Extra dry-wall 
  Parameter{   // 
     Name    =  GOtag:Ext-DryWall;
     Ini     =  1;
     Values  =  "OneSheet, TwoSheets";    
   }  

  // Thermal mass features: Floor surface
  Parameter{ //
     Name   = GOtag:Opt-FloorSurface;
     Ini    = 1; 
     Values = "wood, 1-in-concrete, 2-in-concrete";
  }
   
  // Extra windows in models: 
  Parameter{   // Top floor 
    Name    =  GOtag:Opt-ExtWinTopFl-1;
    Ini     =  1;
    Values  =  "No, Yes";
  } 
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinTopFl-2;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
  Parameter{   // 
     Name    =  GOtag:Opt-ExtWinTopFl-3;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
   Parameter{   // FristFloor
     Name    =  GOtag:Opt-ExtWinFirstFl-1;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-2;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
  Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-3;
     Ini     =  1;
     Values  =  "No,Yes";
   }    
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-4;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-5;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
  Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-6;
     Ini     =  1;
     Values  =  "No,Yes";
   }       
   
   
   Parameter{   // Bedroom
     Name    =  GOtag:Opt-ExtWinBedroom-1;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
   
  Parameter{   // Basement
     Name    =  GOtag:Opt-ExtWinBsmt-1;
     Ini     =  1;
     Values  =  "No,Yes";
   }            
   
   
  Parameter{   // Extra window in master
     Name    =  GOtag:Opt-ExtWinMaster-1;
     Ini     =  1;
     Values  =  "No,Yes";
   } 
  
   
}



OptimizationSettings{
  MaxIte = 10000;
  MaxEqualResults = 100;
  WriteStepNumber = true;
}


//Algorithm{
//  Main = Mesh;
//  StopAtError = true; 
//}

Algorithm{
  Main                      = PSOIW;
  NeighborhoodTopology      = vonNeumann;
  NeighborhoodSize          = 10; // Disregarded for vonNeumann topology
  NumberOfParticle          = 20;
  NumberOfGeneration        = 5;
  Seed                      = 56;
  CognitiveAcceleration     = 1; // 0 < CognitiveAcceleration
  SocialAcceleration        = 1; // 0 < SocialAcceleration
  MaxVelocityGainContinuous = 1;
  MaxVelocityDiscrete       = 1; // 0 < MaxVelocityDiscrete
  InitialInertiaWeight      = 1.2;    // 0 < InitialInertiaWeight
  FinalInertiaWeight        = 0;      // 0 < FinalInertiaWeight
}


