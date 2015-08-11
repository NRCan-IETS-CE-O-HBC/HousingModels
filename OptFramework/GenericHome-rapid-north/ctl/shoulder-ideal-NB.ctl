no overall control description supplied
* Building
no zone control description supplied
  1  # No. of functions
* Control function    1
# senses dry bulb temperature in first_fl.
    0    0    0    0  # sensor data
# actuates the air point in first_fl.
    0    0    0  # actuator data
    3 # No. day types
    1  152  # valid Tue-01-Jan - June 1st Heating
     1  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.000 0.000 18.000 100.000 1.000
  153  266  # valid June 2nd to Sept 23rd
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 5000. 0.000 10.0 18.0 1.000
  267  365  # valid Sept 24th to December 31st Heating
     1  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.00 0.000 18.000 100.000 1.000  
# Function:Zone links
1