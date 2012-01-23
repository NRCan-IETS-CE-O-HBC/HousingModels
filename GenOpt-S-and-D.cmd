/*

 GenOpt command file ANZEH Passive solar

*/
Vary{

   // Air tightness: TypicalGTA, R2000, Cdn1ACH, PassiveHouse
   Parameter{   // 
     Name    =  GOtag:Opt-AirTightness;
     Ini     =  3;
     Values  =  "R2000, Cdn1ACH, PassiveHouse";
     
   }    
   
   // Mainwalls. BaseR21
   //            SIPS-R22-Wall    
   //            SIPS-R28-Wall
   //            Stud-R35-Wall
   //            Stud-R40-Wall
   //            DblStud-R37-Wall
   //            DblStud-R52-Wall
   //            Truss-R40-Wall
   //            Truss-R52-Wall
   Parameter{   // 
     Name    =  GOtag:Opt-MainWall;
     Ini     =  3;
     Values  =  "BaseR21, SIPS-R28-Wall, Stud-R35-Wall, Truss-R40-Wall, Truss-R52-Wall"; 
   }    
  
   // Foundation walls: OBC-min-R12
   //                   Rigid+Batt-R20
   //                   Rigid+Batt-R30               
   //                   Rigid+Batt-R37
   //                   Rigid+Blown-R43
   //                   ICF-base-R22
   //                   ICF-base-R26
   //                   ICF-base-R32
   //                   ICF-base-R41
   //                   ICF-base-R51
   //                   ICF-base-R51r
   
   Parameter{   // 
     Name    =  GOtag:Opt-BasementWallInsulation;
     Ini     =  4;
     Values  =  "OBC-min-R12, Rigid+Batt-R30, Rigid+Batt-R37,Rigid+Blown-R43, ICF-base-R32, ICF-base-R41, ICF-base-R51 "; 
   } 

   // Basement Slab: NoInsulation
   //                R10UnderSlab
   //                R10UnderSlab+edge
   //                R12UnderSlab+edge
   //                R24UnderSlab+edge
   //                R12EdgeP6
   //                R12EdgeP10
   
   Parameter{   // 
     Name    =  GOtag:Opt-BasementSlabInsulation;
     Ini     =  3;
     Values  =  "NoInsulation, R12EdgeP6, R12EdgeP10, R12UnderSlab+edge, R24UnderSlab+edge"; 
   } 

   // Exposed floor: BaseExpFloor-R31
   //                ExpFloorFlash&Batt-R36
   //                ExpFloorFoamed-R52
   Parameter{   // 
     Name    =  GOtag:Opt-ExposedFloor;
     Ini     =  2;
     Values  =  "BaseExpFloor-R31,ExpFloorFlash&Batt-R36,ExpFloorFoamed-R52";
   }    
   
   
   // Ceilings: CeilingR50, 
   //           CeilingR60, 
   //           CeilingR70, 
   //           CeilingR80, 
   //           CeilingR90, 
   //           CeilingR100
   Parameter{   // 
     Name    =  GOtag:Opt-Ceilings;
     Ini     =  4;
     Values  =  "CeilingR50,CeilingR80,CeilingR90,CeilingR100";
   }    
  
  // Windows:  DoubleLowEHardCoatAirFill 
  //           DoubleLowEHardCoatArgFill
  //           DoubleLowESoftCoatArgFill 
  //           TripleLowEHardCoatKryFill
  //           TripleLowESoftCoatKryFill
  
  Parameter{   // 
     Name    =  GOtag:Opt-CasementWindows;
     Ini     =  1;
     // Values: "DoubleLowEHardCoatArgFill,DoubleLowESoftCoatArgFill,TripleLowEHardCoatKryFill,TripleLowESoftCoatKryFill"
     Values  = "DoubleLowEHardCoatArgFill,DoubleLowESoftCoatArgFill,TripleLowEHardCoatKryFill" ;    
     
   }    
   
  // Extra drywall:  OneSheet
  //                 TwoSheets
  
  Parameter{   // 
     Name    =  GOtag:Ext-DryWall;
     Ini     =  1;
     Values  =  "OneSheet, TwoSheets";    
     
   }    
   
   
  // Floor surface:  wood 
  //                 1-in-concrete
  //                 2-in-concrete
  Parameter{   // 
     Name    =  GOtag:Opt-FloorSurface;
     Ini     =  1;
     Values  =  "wood, 1-in-concrete, 2-in-concrete ";    
   }       
 
   
   
  
  
  // SolarDHW: none, 
  //           DHWR, 
  //           1-flat-plate, 
  //           1-flat-plate+DWHR, 
  //           2-flat-plate, 
  //           2-flat-plate+DWHR
  
  Parameter{   // 
     Name    = GOtag:Opt-SolarDHW; 
     Ini     = 2; 
     Values  = "none, DWHR, 1-flat-plate, 1-flat-plate+DWHR, 2-flat-plate, 2-flat-plate+DWHR"; 
  } 
  
  // Conventional DHW:  BaseDHW, 
  //                    ElecInstantaneous, 
  //                    ElectricStorage, 
  //                    GasInstantaneous, 
  //                    ElectricHP
  //           
  Parameter{ //
     Name    = GOtag:Opt-DHWSystem;
     Ini     = 1; 
     Values  = "ElectricStorage" ; 
  }

  
  // Heating/cooling: basefurnace, 
  //                  elec-baseboard, 
  //                  CCASHP
  
  Parameter {// 
      Name   = GOtag:Opt-HVACSystem; 
      Ini    = 1; 
      Values = "elec-baseboard"; 
  }
  
  // PV: Set to autosize to ensure each run actually achieves NZEH.  
  Parameter{   // 
     Name    =  GOtag:Opt-StandoffPV;
     Ini     =  1;
     Values  = "autosize";
  } 
  
  
   //===================================================================
   // PASSIVE SOLAR: Include or exclude extra windows    
   //===================================================================
    
   Parameter{  // Front windows 
     Name    = GOtag:Opt-FrontWindows; 
     Ini     = 1; 
     Values  = "NoExtraWin"; 
     // Can be : "NoExtraWin, OneExtraWin, TwoExtraWin, ThreeExtraWin"
   }
   
   Parameter{  // Back windows 
     Name    = GOtag:Opt-BackWindows; 
     Ini     = 1; 
     Values  = "NoExtraWin, OneExtraWin, TwoExtraWin, ThreeExtraWin, FourExtraWin, FiveExtraWin, 6ExtraWin"; 
   }
   
   Parameter{   // First Floor -- left side (as viewed from front  
     Name    =  GOtag:Opt-ExtLeftSideWindow;
     Ini     =  1;
     Values  =  "No";
   } 
   
   
  Parameter{   // Basement -- back 
     Name    =  GOtag:Opt-ExtBasementWindow;
     Ini     =  1;
     Values  =  "No";
   }            
   
   

  
  
  
  // ===================================================================
  // The following sections define assumptions about how a NZEH home 
  // is operated, and are not intended to be optimized. A single value 
  // should be provided in each case. 
  // ===================================================================
  Parameter { // 
      Name   = GOtag:ElecLoadScale; 
      Ini    = 1;
      // Value may be one of  NoReduction, BasicReduction, EfficientLiving      
      Values = "EfficientLiving"; 
  }
  Parameter { // 
      Name   = GOtag:DHWLoadScale; 
      Ini    = 1;
      // Value may be one of  NoReduction, BasicReduction, EfficientLiving      
      Values = "EfficientLiving"; 
  }
  
  Parameter { // 
      Name   = GOtag:HRVcontrol; 
      Ini    = 1;
      // Value may be one of Continuious, ERSp3ACH, EightHRpDay       
      Values = "ERSp3ACH"; 
  }  
  
    
   // Orientation: for parametric study. Set to one of 
   // "S, N, E, W, or avg", "AVG" causes substitute.pl 
   // to run four simulations (in four different orientations) 
   // for each set of parameters and average the results. 
   
   Parameter{   // 
     Name    =  GOtag:GOconfig_rotate;
     Ini     =  1;
     Values  =  "S";
   }      
    
     
   
}



OptimizationSettings{
  MaxIte = 10000;
  MaxEqualResults = 100;
  WriteStepNumber = true;
}


Algorithm{
 Main                      = PSOIW;
  NeighborhoodTopology      = vonNeumann;
  NeighborhoodSize          = 10; // Disregarded for vonNeumann topology
  NumberOfParticle          = 25;
  NumberOfGeneration        = 100;
  Seed                      = 32;
  CognitiveAcceleration     = 1.5; // 0 < CognitiveAcceleration
  SocialAcceleration        = 1.1; // 0 < SocialAcceleration
  MaxVelocityGainContinuous = 1.2;
  MaxVelocityDiscrete       = 1; // 0 < MaxVelocityDiscrete
  InitialInertiaWeight      = 1.2;    // 0 < InitialInertiaWeight
  FinalInertiaWeight        = 0;      // 0 < FinalInertiaWeight
}



//Algorithm{
//  Main = Mesh;
//  StopAtError = true; 
//}
