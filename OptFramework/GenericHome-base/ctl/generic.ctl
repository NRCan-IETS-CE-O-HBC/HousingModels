no overall control description supplied
* Building
no zone control description supplied
  2  # No. of functions
* Control function    1
# senses dry bulb temperature in first_fl.
    2    0    0    7  # sensor data
# actuates the air point in first_fl.
    2    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   <OPT-heat-cool-cap> 0.000 0.000 0.000 20.000 100.000 0.000
   92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 <OPT-heat-cool-cap> 0.000 -20.000 26.000 0.000
  274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   <OPT-heat-cool-cap> 0.000 0.000 0.000 20.000 100.000 0.000
* Control function    2
# senses dry bulb temperature in first_fl.
    2    0    0    7  # sensor data
# actuates the air point in bsmt.
    1    0    0  # actuator data
    3 # No. day types
    1  91   # valid Tue-01-Jan - April 1st
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 <OPT-heat-cool-cap> 0.000
    92  273  # valid April 2nd to September 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 0.000 <OPT-heat-cool-cap>  
    274  365  # valid October 1st - December 30th
     1  # No. of periods in day: weekdays
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  1.000 <OPT-heat-cool-cap> 0.000        
# Function:Zone links
 2,1,0
