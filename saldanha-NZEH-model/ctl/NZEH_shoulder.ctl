no overall control description supplied
* Building
no zone control description supplied
  7  # No. of functions
* Control function    1
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in first_fl.
    3    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   2941.176 0.000 0.000 0.000 21.000 100.000 0.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   2941.176 0.000 2941.176 0.000 18.000 26.000 0.000 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 2941.176 0.000 -20.000 25.000 0.000
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   2941.176 0.000 2941.176 0.000 18.000 26.000 0.000  
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   2941.176 0.000 0.000 0.000 21.000 100.000 0.000
* Control function    2
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in bsmt.
    1    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2941.176 0.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2941.176 2941.176 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 2941.176 
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2941.176 2941.176
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2941.176 0.000      
* Control function    3
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in master.
    4    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 806.452 0.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 806.452 806.452 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 806.452
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 806.452 806.452
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 806.452 0.000
* Control function    4
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in ensuite.
    5    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 294.118 0.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 294.118 294.118
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 294.118
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 294.118 294.118
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 294.118 0.000
* Control function    5
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in bedroom.
    6    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 735.294 0.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 735.294 735.294
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 735.294
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 735.294 735.294
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 735.294 0.000
* Control function    6
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in top_fl.
    7    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2352.94 0.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2352.94 2352.94
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 2352.94
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2352.94 2352.94
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2352.94 0.000
* Control function    7
# senses dry bulb temperature in first_flr.
    0    0    0    0  # sensor data
# actuates the air point in main_flr.
    0    0    0       # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: weekdays    
    0   26   0.000  # ctl type, law (undefined control), start @
      6.  # No. of data items
   22.0   # Lower setpoint 
   26.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25    # Delay between action 
   0.3    # Control gain modifier 
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
        6.  # No. of data items
   19.0   # Lower setpoint 
   24.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25    # Delay between action 
   0.4    # Control gain modifier 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
        6.  # No. of data items
   18.0   # Lower setpoint 
   22.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25    # Delay between action 
   0.5    # Control gain modifier 
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
        6.  # No. of data items
   19.0   # Lower setpoint 
   24.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25    # Delay between action 
   0.4    # Control gain modifier 
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
        6.  # No. of data items
   22.0   # Lower setpoint 
   26.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25    # Delay between action 
   0.3    # Control gain modifier     
# Function:Zone links
 2,0,1,3,4,5,6,0,0
