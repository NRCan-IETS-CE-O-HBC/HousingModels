=========================================================================
NRCan Residential optimization platform. For use on Cygwin/linux systems. 
=========================================================================


SET UP THE ENIVIRONMENT 
-----------------------

1. Checkout and install Alex_Ferguson @ r9421 

   From your home directory: 
      
      cd ~/ 
      svn co https://espr.svn.cvsdude.com/esp-r/branches/Alex_Ferguson@r9421 
      cd Alex_Ferguson/src
      ./Install -d ~/ --xml --no_training --no_dbs --silent --force --debug bps ish prj
      cd ~/    

    Previous versions of the platform required you to copy the climate database 
    directories (climate_linux or climate_cygwin). These operations are now 
    automated by substitute.pl. 
          
      
RUN A SIMULATION FOR A SINGLE DESIGN
------------------------------------      

2. To run a single case, execute substitute.pl while specifying a) a 
   design-choices file, and an options file:

   From your NZEH-optimization directory:
   
      ./substitute.pl -o <OPTIONS FILE> -c <DESIGN-Choices FILE> -vv
      
   Example: 
   
      ./substitute.pl -o OPTIONS-General.options -c DESIGN-Arch2-OBC2012.choices  -vv
  
   
3. To run a simulation with a different design, edit the design file 
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

5. Invoke Genopt: 
   
        java -classpath genopt.jar genopt.GenOpt [Genopt-ini-file] 
        
   Example: 

        java -classpath genopt.jar genopt.GenOpt Genopt-BASE-ini.GO-ini
    
