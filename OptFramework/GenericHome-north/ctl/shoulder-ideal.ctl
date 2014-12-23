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
    1  166  # valid Tue-01-Jan - June 15th Heating
     1  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.000 0.000 21.000 100.000 5.000
  167  243  # valid June 16th to Aug 31st free float
    1  # No. of periods in day    
    0    2   0.000  # ctl type, law (free floating), start @
      0.  # No. of data items
  244  365  # valid Sept 1st to December 31st Heating
     1  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.00 0.000 21.000 100.000 5.000  
# Function:Zone links
0,1,0
