=========================================================================
NRCan Residential optimization platform. For use on Cygwin/linux systems. 
=========================================================================

SET UP THE ENIVIRONMENT 
-----------------------

1. Checkout and install (or update to) Alex_Ferguson @ r9510 

   From your home directory: 
     
	 USING SUBVERSION: 
      cd ~/ 
      svn co https://espr.svn.cvsdude.com/esp-r/branches/Alex_Ferguson@r9508
      cd Alex_Ferguson/src
      ./Install -d ~/ --xml --no_training --silent --force --debug --noX bps ish prj
      cd ~/    

	  USING GIT:
	  cd ~/
	  git clone https://github.com/ESP-rCommunity/ESP-rSource.git ESP-rSource
	  cd ESP-rSource/src  
      git checkout Alex_Ferguson
      ./Install -d ~/ --xml --no_training --silent --force --debug --noX bps ish prj
      cd ~/    

    Previous versions of the platform required you to copy the climate database 
    directories (climate_linux or climate_cygwin). These operations are now 
    automated by substitute.pl. 

    Replace --debug with --extra-debug to rebuild all libraries:
	
	  ./Install -d ~/ --xml --no_training --silent --force --extra-debug --noX -v bps ish prj
	
	Note: Cygwin needs these installation packages for successful compile/link and use:
			libxslt
			libxml2
			libsqlite
			subversion
			fortran (gfortran just installs libs so don't get gfortran executable!)
			g++ (needed for g++ executable - should be installed by "fortran" above)
			Git

		- I also added the "make" package but it may be that "fortran" or "g++" includes that.
      
	Checkout HousingModels/OptFramework (from home directory)
	---------------------------------------------------------
	Using Git:
	git clone https://github.com/NRCan-IETS-CE-O-HBC/HousingModels.git


RUN A SIMULATION FOR A SINGLE DESIGN
------------------------------------      

2. To run a single case, execute substitute.pl while specifying a) a 
   design-choices file, and an options file:

   From your OptFramework directory:
   
      ./substitute.pl -o <OPTIONS FILE> -c </modelfolder/choices/Choices FILE> -vv
      
   Example: 
   
      ./substitute.pl -o OPTIONS-General.options -c NZEH-base/choices/Arch2-OBC2012.choices  -vv
  
   
3. To run a simulation with a different design, edit the design file 
   (eg. design-choices.choices). Make sure your specified choices 
   are defined in the options file (eg. OPTIONS-General.options).
   
Note: If you get the error message "Can't locate File/Copy/Recursive.pm ...", then you need 
to install the File::copy::recursive module with CSPAN as follows:

	CPAN install File::Copy::Recursive

         
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
   
        java -classpath genopt.jar genopt.GenOpt [\modelfolder\choices\Genopt-ini-file] 
        
   Example: 

        java -classpath genopt.jar genopt.GenOpt NZEH-base\choices\Genopt-BASE-ini.GO-ini
		
		Alternate:
        rm nohup.out; nohup java -classpath genopt.jar genopt.GenOpt GenericHome-2st-garage\choices\Genopt-OTT-MATTAMY-INI.GO-ini &
		


Notepad++ Settings for accessing remote Ubuntu files
----------------------------------------------------
Plugins menu:
 - NppFTP --> Show NppFTP Window
		
In NppFTP window Click on gear icon for Settings:
 - Add a new profile and label it something appropriate (like "AWS")
 - Profile Settings on the Connections tab 
   --> Set the "Hostname" field to the IP address shown in the AWS Connect window(e.g., 52.1.247.204)
   --> Username = "ubuntu"
   --> No password required
 - Closing this window saves the changes
 - To display folders click on the blue connect icon and select the named profile

Post-Processing GenOpt results data (interim or final)
------------------------------------------------------
GenOpt data can be downloaded to a local directory on your Windows machine by using a PERL script 
called "recover-results.pl" in Cygwin at any time while GenOpt is still running or when GenOpt is 
completed (or manually stopped).

The recover-results.pl script resides in the "Opt-Results" folder below "HousingModels" (Note: Your 
"HousingModels" folder may have a different name depending on how you checked out the Git repository).
We have been using this folder to contain temporary local downloaded optimization files. If you want 
others to share this data please don't add new folders to Git because they're large. We've been using 
Google Docs for this purpose. Please ask Alex if you need to create a new Google Docs folder for more
data.

To run the script:
~/HousingModels/Opt-Results$ ./recover-results.pl <remote computer address>

(e.g. recover-results.pl ubuntu@ec2-23-23-47-71.compute-1.amazonaws.com )

The first time that this PERL script is run it will download the file OutputListingAll.txt from 
the remote computer (i.e., AWS instance) and create a file called CloudResultsAllData.csv. You will also 
notice two other files: TempResultsBatch1.txt and RecoveredFromCloud.txt. Rename RecoveredFromCloud.txt
to CloudresultsBatch1.txt and all subsequent downloads you want to keep to CloudresultsBatchN.txt.

The PERL script will re-create CloudResultsAllData.csv each time it is run by appending any existing 
CloudresultsBatchN.txt files that may exist to newly downloaded RecoveredFromCloud.txt.

 
RUN AN OPTIMIZATION USING DAKOTA
--------------------------------
Dakota uses a single file for all inputs. The file for BC-LEEP is named Generic-BC.dakota-in. The command
used to run Dakota is:

> dakota -i Generic-BC.dakota-in -o Generic-BC.dakota-out -e Generic-BC.dakota-err

-i: Input file name
-o: Output file name (this is NOT the results data file)
-e: Error output file

Actually, I don't believe that either the -o or the -e is required as there are default names set in the 
input file.

Dakota will stop after 100 iterations but can be killed at any time.

Before the Dakota results file can be used (named dakota_tabular.dat) it must be combined with an ASCII 
version of the Dakota rst file (dakota.rst) that contains much of the results data. The file dakota_tabular.dat
contains all of the input parameters in integer form and needs to be converted to the correct ASCII attribute
strings. Substitute.pl contains a command line option to do this and, optionally, re-order the data columns to 
match GenOpt output.

To post-process the Dakota output without re-ordering the data run substitute.pl as follows:

./substitute.pl -z -vv -o OPTIONS-generic.options -c dakota-choices.in

The -z option implies -d (--dakota) do there is no need for both of these options to be specified.
The dakota-choices.in file can be any valid choice file (i.e., any combination of input elements). Valid means
that it must contain the correct number and type of elements used in the last Dakota run. As of February 26, 2015 
there are 33 elements (or variables) in a valid choice file. The most recently added new variable is 
Opt-GenericWall_1Layer_definitions.

To post-process the Dakota output AND re-ordering the data to match GenOpt run substitute.pl as follows:

./substitute.pl -r -vv -o OPTIONS-generic.options -c dakota-choices.in

The -r implies both -d and -z.

The output file from the above substitute.pl run is OutputListingAll-D.txt. This file must be renamed to
OutputListingAll.txt for recover-results.pl to access this data.

