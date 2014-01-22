no overall control description supplied
* Building
no zone control description supplied
  7  # No. of functions
* Control function    1
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in first_fl.
    3    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   2941.176 0.000 0.000 0.000 20.000 100.000 0.000
   92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 2941.176 0.000 -20.000 26.000 0.000
  274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   2941.176 0.000 0.000 0.000 20.000 100.000 0.000
* Control function    2
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in bsmt.
    1    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2941.176 0.000
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 2941.176  
    274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2941.176 0.000        
* Control function    3
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in master.
    4    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 806.452 0.000
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 806.452  
    274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 806.452 0.000  
* Control function    4
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in ensuite.
    5    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 294.118 0.000
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 294.118  
    274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 294.118 0.000 
* Control function    5
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in bedroom.
    6    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 735.294 0.000
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 735.294  
    274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 735.294 0.000
* Control function    6
# senses dry bulb temperature in first_fl.
    3    0    0    7  # sensor data
# actuates the air point in top_fl.
    7    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2352.94 0.000
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 2352.94  
    274  365 # valid October 1st - December 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 2352.94 0.000 
* Control function    7
# senses dry bulb temperature in first_flr.
    0    0    0    0  # sensor data
# actuates the air point in main_flr.
    0    0    0       # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays    
    0   26   0.000  # ctl type, law (undefined control), start @
      6.  # No. of data items
   22.0   # Lower setpoint 
   26.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25    # Delay between action 
   0.5    # Control gain modifier 
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
      6.  # No. of data items
   20.0   # Lower setpoint 
   24.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25   # Delay between action 
   0.4    # Control gain modifier
    274  365 # valid October 1st - December 30th
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
      6.  # No. of data items
   22.0   # Lower setpoint 
   26.0   # Upper setpoint
   3.0    # Action when windows closed
   3.0    # Action when windows open
   0.25  # Delay between action 
   0.5    # Control gain modifier    
# Function:Zone links
 2,0,1,3,4,5,6,0,0
