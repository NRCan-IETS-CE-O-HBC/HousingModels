no overall control description supplied
* Building
no zone control description supplied
  2  # No. of functions
* Control function    1
# senses dry bulb temperature in first_fl.
    0    0    0    0  # sensor data
# actuates the air point in first_fl.
    0    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.000 0.000 21.000 26.000 5.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0    27  0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 5000. 0.000 18.000 26.000 5.000 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 5000. 0.000 -20.000 25.000 5.000
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 5000. 0.000 18.000 26.000 5.000  
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.000 0.000 21.000 26.000 5.000
* Control function    2
# senses dry bulb temperature in first_fl.
    0    0    0    0  # sensor data
# actuates the air point in first_fl.
    0    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.000 0.000 18.000 26.000 5.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0    27  0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 5000. 0.000 15.000 26.000 5.000 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 5000. 0.000 -20.000 25.000 5.000
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 5000. 0.000 15.000 26.000 5.000  
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000. 0.000 0.000 0.000 18.000 26.000 5.000
# Function:Zone links
2,1,0
