=========================================================================
NRCan Residential optimzation platform. For use on Cygwin/linux systems. 
=========================================================================


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
      

3. To run a single case, execute substiture.pl while specifying a) a 
   design-choices file, and an options file:

   From your NZEH-optimization directory:
   
      ./substitute.pl -o <OPTIONS FILE> -c <DESIGN-Choices FILE> -vv
      
   Example: 
   
      ./substitute.pl -o OPTIONS-General.options -c DESIGN-Arch2-OBC2012.choices  -vv
      

===== Update this below === 

2. invoke optimization: 
   
   java -classpath genopt.jar genopt.GenOpt <GENOPT INI FILE
