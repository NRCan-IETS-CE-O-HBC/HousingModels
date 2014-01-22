#!/bin/bash

# This script searches fro csv files created by open office,
# and converts them into bcd-friendly .csv format

# get a list of csv files, and process files one-by-one
ls -1 *.csv | while read csv_file; do

  # drop .csv extention from file name 
  rootname=`echo $csv_file | sed "s/\.csv$//"`

  # Add .bcd extention
  bcd_file="${rootname}.bcd"

  # Tell user what's up
  echo "converting ${csv_file} > ${bcd_file}"

  # Nuke quotes, extra commas and trailing commas, and insert into bcd 
  # file 
  cat $csv_file | sed "s/\"//g" | sed "s/,,//g" | sed "s/, *$//g" > $bcd_file

done;
