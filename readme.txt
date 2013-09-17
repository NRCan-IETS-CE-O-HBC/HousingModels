=========================================================================
NRCan Residential optimzation platform. For use on Cygwin/linux systems. 
=========================================================================


SET UP THE ENIVIRONMENT 
-----------------------

1. Checkout and install Alex_Ferguson @ r9421 

   From your home directory: 
      
      cd ~/ 
      svn co https://espr.svn.cvsdude.com/esp-r/branches/Alex_Ferguson @ r9421 
      cd Alex_Ferguson/src
      ./Install ~/ --xml --no_training --no_dbs --silent --force --debug bps ish prj
      cd ~/    

2. Update the climate database depending on whether you are using cygwin or linux.

   From your NZEH-optimization directory:
      
      cp -fr ./climate_cygwin ./NZEH-base/climate 
      
               --- OR ---
      
      cp -fr ./climate_linux ./NZEH-base/climate 
      
      
RUN A SIMULATION FOR A SINGLE DESIGN
------------------------------------      

3. To run a single case, execute substiture.pl while specifying a) a 
   design-choices file, and an options file:

   From your NZEH-optimization directory:
   
      ./substitute.pl -o <OPTIONS FILE> -c <DESIGN-Choices FILE> -vv
      
   Example: 
   
      ./substitute.pl -o OPTIONS-General.options -c DESIGN-Arch2-OBC2012.choices  -vv
  
   
4. To run a simulation with a different design, edit the design file 
   (eg. design-choices.choices). Make sure your specified choices 
   are defined in the options file (eg. OPTIONS-General.options).
         
RUN AN OPTIMIZATION USING GENOPT
--------------------------------

5. Edit the CallParameter specification in the GenoptBase-INI.ini to 
   reflect windows or linux usage. Set the prefix parameter as follows:
   
   Windows (CYGWIN):
   
          CallParameter {
          
              // Windows only: 
              Prefix = "C:\\cygwin\\bin\\perl.exe ";

              Suffix = " -c GenOpt-picked-these-choices.GO-tmp -o OPTIONS-General.options "; 
     
          }
     
    Linux :
   
          CallParameter {
          
              // Linux only: 
              Prefix = "";

              Suffix = " -c GenOpt-picked-these-choices.GO-tmp -o OPTIONS-General.options "; 
     
          }  

6. Invoke Genopt: 
   
        java -classpath genopt.jar genopt.GenOpt [Genopt-ini-file] 
        
    Example: 

        java -classpath genopt.jar genopt.GenOpt Genopt-BASE-ini.GO-ini
    
