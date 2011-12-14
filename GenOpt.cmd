/*

 GenOpt command file ANZEH Passive solar

*/
Vary{

   // Orientation: for parametric study 
   
   Parameter{   // 
     Name    =  GOtag:GOconfig_rotate;
     Ini     =  1;
     Values  =  "S, N, E, W";
   }  

   // Air tightness
   Parameter{   // 
     Name    =  GOtag:Opt-AirTightness;
     Ini     =  1;
     Values  =  "TypicalGTA, R2000, PassiveHouse";
     //Values  =  "TypicalGTA";
   }    
   
   // Mainwalls 
   Parameter{   // 
     Name    =  GOtag:Opt-MainWall;
     Ini     =  1;
     Values  =  "BaseR21, SIPS-R29-Wall"; 
     //Values  =  "BaseR21, SIPS-R29-Wall, ICFR22, SIPS-R29-Wall, SIPS-R38-Wall, SIPS-R44-Wall, Stud-R38-Wall, Stud-R50-Wall, DblStud-R44-Wall, Truss-R40-Wall";
   }    
  
  
   // Ceilings
   Parameter{   // 
     Name    =  GOtag:Opt-Ceilings;
     Ini     =  1;
     Values  =  "CeilingR50,  CeilingR70";
     // Values  =  "CeilingR50, CeilingR60, CeilingR70, CeilingR80, CeilingR90, CeilingR100, CeilingR110";
   }    
  
  // Windows 
  Parameter{   // 
     Name    =  GOtag:Opt-CasementWindows;
     Ini     =  1;
     Values  =  "DoubleLowEHardCoatAirFill, DoubleLowEHardCoatArgFill, DoubleLowESoftCoatArgFill, TripleLowEHardCoatKryFill, TripleLowESoftCoatKryFill";    
     //Values  =  "DoubleLowEHardCoatAirFill";
   }    
    
    
   
   // Extra windows in models: 
   Parameter{   // Top floor 
     Name    =  GOtag:Opt-ExtWinTopFl-1;
     Ini     =  1;
     Values  =  "No";
   } 
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinTopFl-2;
     Ini     =  1;
     Values  =  "No";
   } 
   
  Parameter{   // 
     Name    =  GOtag:Opt-ExtWinTopFl-3;
     Ini     =  1;
     Values  =  "No";
   } 
   
   Parameter{   // FristFloor
     Name    =  GOtag:Opt-ExtWinFirstFl-1;
     Ini     =  1;
     Values  =  "No";
   } 
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-2;
     Ini     =  1;
     Values  =  "No";
   } 
   
  Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-3;
     Ini     =  1;
     Values  =  "No";
   }    
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-4;
     Ini     =  1;
     Values  =  "No";
   } 
   
   Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-5;
     Ini     =  1;
     Values  =  "No";
   } 
   
  Parameter{   // 
     Name    =  GOtag:Opt-ExtWinFirstFl-6;
     Ini     =  1;
     Values  =  "No";
   }       
   
   
   Parameter{   // Bedroom
     Name    =  GOtag:Opt-ExtWinBedroom-1;
     Ini     =  1;
     Values  =  "No";
   } 
   
  Parameter{   // Basement
     Name    =  GOtag:Opt-ExtWinBsmt-1;
     Ini     =  1;
     Values  =  "No";
   }            
   
   
  Parameter{   // Extra window in master
     Name    =  GOtag:Opt-ExtWinMaster-1;
     Ini     =  1;
     Values  =  "No";
   } 
  
   
}



OptimizationSettings{
  MaxIte = 10000;
  MaxEqualResults = 100;
  WriteStepNumber = true;
}


Algorithm{
  Main = Mesh;
  StopAtError = true; 
}
