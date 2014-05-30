 no overall control description supplied
* Building
 no zone control description supplied
  4  # No. of functions   
* Control function    1
# senses dry bulb temperature in first_fl.
    0    0    0    0  # sensor data
# actuates the air point in first_fl.
    0    0    0  # actuator data
    5 # No. day types ############### WINTER #################################
    1  105  # valid Tue-01-Jan - April 15 Heating
     3  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000
    0    27   7.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 21.000 26.000 5.000
    0    27   21.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000      ############### SHOULDER #################################
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0    27  0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 5000. 0.000 18.000 26.000 5.000   
  167  243  # valid June 16th to Aug 31st Cooling
       3  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 -20.000 40.000 5.000
    0    27   7.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 -20.000 25.000 5.000
    0    27   21.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 -20.000 40.000 5.000 
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 5000. 0.000 18.000 26.000 5.000  
  289  365  # valid October 16th to December 31st
     3  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000
    0    27   7.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 21.000 26.000 5.000
    0    27   21.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000  
* Control function    2 ##### SECOND FLOOR  FLOOR  
# senses dry bulb temperature in first_fl.
    0    0    0    0  # sensor data
# actuates the air point in first_fl.
    0    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating  ############### WINTER #################################
     3  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 21.000 26.000 5.000
    0    27   9.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000
    0    27   18.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 21.000 26.000 5.000   
  106  166  # valid April 16 - June 15th Shoulder  ### SHOULDER
     1  # No. of periods in day: sunday      
    0    27  0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 5000. 0.000 18.000 26.000 5.000 
  167  243  # valid June 16th to Aug 31st Cooling # SUMMER 
       3  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 -20.000 25.000 5.000
    0    27   9.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 -20.000 40.000 5.000
    0    27   18.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 -20.000 25.000 5.000 
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 5000. 0.000 18.000 26.000 5.000  
  289  365  # valid October 16th to December 31st
     3  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 21.000 26.000 5.000
    0    27   9.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000
    0    27   18.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 21.000 26.000 5.000      
* Control function    3
# senses dry bulb temperature in first_fl.
    0    0    0    0  # sensor data
# actuates the air point in first_fl.
    0    0    0  # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: sunday      
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000
  106  166  # valid April 16 - June 15th Shoulder
     1  # No. of periods in day: sunday      
    0    27  0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 3500. 0.000 18.000 26.000 5.000 
  167  243  # valid June 16th to Aug 31st Cooling
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 3500. 0.000 -20.000 40.000 5.000
  244  288  # valid Sept 1st to Oct 15th Shoulder
     1  # No. of periods in day: saturday    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 3500. 0.000 18.000 26.000 5.000  
  289  365  # valid October 16th to December 31st
     1  # No. of periods in day: weekdays    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   3500. 0.000 0.000 0.000 18.000 26.000 5.000
* Control function    4
# senses dry bulb temperature in first_flr.
    0    0    0    0  # sensor data
# actuates the air point in main_flr.
    0    0    0       # actuator data
    5 # No. day types
    1  105  # valid Tue-01-Jan - April 15 Heating
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
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
 3,1,2,2,0
