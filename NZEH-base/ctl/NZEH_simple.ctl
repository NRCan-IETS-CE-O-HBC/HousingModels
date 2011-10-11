no overall control description supplied
* Building
no zone control description supplied
  6  # No. of functions
* Control function    1
# senses dry bulb temperature in first_fl.
    3    0    0    0  # sensor data
# actuates the air point in first_fl.
    3    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   4090 0.000 4090 0.000 21.000 26.000 5.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   4090 0.000 4090 0.000 19.000 26.000 5.000 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  4090. 0.00 4090 0.000 15.000 25.600 5.000
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   4090 0.000 4090 0.000 19.000 26.000 5.000  
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   4090 0.000 4090 0.000 21.000 100.000 5.000
* Control function    2
# senses dry bulb temperature in first_fl.
    3    0    0    0  # sensor data
# actuates the air point in bsmt.
    1    0    0  # actuator data
    1 # No. day types
    1  365  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 4090 4090  
* Control function    3
# senses dry bulb temperature in first_fl.
    3    0    0    0  # sensor data
# actuates the air point in master.
    4    0    0  # actuator data
    1 # No. day types
    1  365  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 1120. 1120.
* Control function    4
# senses dry bulb temperature in first_fl.
    3    0    0    0  # sensor data
# actuates the air point in ensuite.
    5    0    0  # actuator data
    1 # No. day types
    1  365  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 408. 408.
* Control function    5
# senses dry bulb temperature in first_fl.
    3    0    0    0  # sensor data
# actuates the air point in bedroom.
    6    0    0  # actuator data
    1 # No. day types
    1  365  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 1021. 1021. 
* Control function    6
# senses dry bulb temperature in first_fl.
    3    0    0    0  # sensor data
# actuates the air point in top_fl.
    7    0    0  # actuator data
    1 # No. day types
    1  365  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 3270. 3270.
# Function:Zone links
 2,0,1,3,4,5,6,0,0
