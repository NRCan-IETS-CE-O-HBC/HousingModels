#!/bin/bash

headtext="
        ESP-r climate data installation

 This script will install additional ESP-r weather
 files on your system. Run ./Install.sh --help for 
 more information, ./Install --list for a list of
 the contries available.
"
printf "$headtext"

Target="/usr/esru/esp-r/climate"

helptext="
 USAGE: Install.sh [options] COUNTRY

 This script will install additonal ESP-r weather 
 files on to your system. It supports the following
 options:

   -h, --help: Display this message

   -d, --directory <PATH>: Copy the converted binary
       weather files to <PATH>. By default, files are
       installed in $Target}

   -l, --list: List all countries for which weather
       data is available.

  Examples:

    - Install all weather files in $Target:

       ./Install.sh all

    - Install Canadian weather files in ~/esp-r/climate:

       ./Install.sh -d ~/esp-r/climate Canada

    - Print a list of all countries for which weather
      data is available

       ./Install --list

"


# Target directory
Target="/usr/esru/esp-r/climate"
# Pointer to clm
CLM=clm
# Collect list of countries for which data is available.
supported_countries=`ls -d *.a | grep -v "Install.*" | sed "s/clm-dat_//g"  `
list_for_output=$supported_countries
supported_countries=`echo $supported_countries | sed -e :a -e '$!N; s/\n/ /; ta'`
supported_countries=" $supported_countries "

# 
# linecount=`echo $supported_countries | wc -l`
# 
# while [ $linecount -gt 1 ]; do
#   supported_countries=`echo $supported_countries | sed 'N;s/\n/ /'`
#   linecount=`echo $supported_countries | wc -l`
# done



input=0
help=0
listcountries=0
install_these_countries=""
install_all_counties="no"

if [ $# -ne 0 ]; then
   for i do
      if [ "${input}" = "yes" ]; then
         input="no"
      else
        case "$i" in
          -h | --help ) help="yes"; shift;;
          -l | --list ) listcountries="yes"; shift;;
          -d | --directory ) shift; Target=$1; input="yes"; shift;;
          all ) install_all_counties="yes" ; shift;;
          * ) match="no"
              position=`expr match " $supported_countries " ".* ${i} .*"`
              if  [ "${position}" != 0 ]; then
                 install_these_countries="${install_these_countries} ${i}"
                 shift
              else
                 # Trap unsupported arguements.
                 echo " " 
                 echo " Error: arguement $i is not supported. "
                 echo " Run ./Install --help for more information."
                 echo " " 
                 exit
              fi
        esac
      fi
   done
fi

if [ "$install_all_counties" == "yes" ]; then
  install_these_countries="$supported_countries"
fi


#---------------------------------------------------------------------
# Begin conversion
#---------------------------------------------------------------------

  # Compile a list of climate files in that country's directory
  asciifiles=`ls -1 *.a`
  asciifiles="$asciifiles end_of_files"

  
  while [ "$asciifiles" != "end_of_files" ];
  do
    # Extract leading file from list
    ascii_src=`echo $asciifiles | sed 's/ .*$//g'`
    # Now remove this file from list
    asciifiles=`echo $asciifiles | sed 's/^[^ ]* //g'`

    #Extract city name
    climate_file_ascii=`echo $ascii_src | sed 's/^.*\///g' `
    climate_file_bin=`echo $climate_file_ascii | sed 's/\.a$//g'`
    city=`echo $climate_file_ascii | sed 's/^[A-Za-z]\{3\}_//g' | sed 's/\.[A-Za-z]\{4\}\.a//g'`
    printf "\r   - Converting climate files for $country: [$city]         "

    # Initaialize error flags 
    errmsg=""

    # Convert climate file
    output=`$CLM -mode text -file $climate_file_bin -act asci2bin silent $ascii_src 2>&1`
    errmsg="$errmsg\n$output"

    if [ -r $climate_file_bin ]; then
      output=`mv $climate_file_bin $Target 2>&1`
      errmsg="$errmsg\n$output"
    fi

    if [ ! -r $Target/$climate_file_bin ]; then
      printf "\nError converting $ascii_src for $country!\n"
      printf "conversion output follows:\n"
      printf "$output\n"
      printf "Install.sh: Fatal error!\n"
      rm $climate_file_bin >/dev/null 2>&1
      exit
    fi
  done
   printf "\r   - Converting climate files for $country: [$city] done              \n"

echo


