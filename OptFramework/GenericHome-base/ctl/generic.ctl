no overall control description supplied
* Building
no zone control description supplied
  2  # No. of functions
* Control function    1
# senses dry bulb temperature in current.
    0    0    0    0  # sensor data
# actuates the air point in current zone.
    0    0    0  # actuator data
    3 # No. day types
    1  120   # valid Tue-01-Jan - April 30
     1  # No. of periods in day
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000 0.000 0.000 0.000 21.000 100.000 5.000
   121  243  # valid April 2nd to August 31st
     1  # No. of periods in day    
    0    2   0.000  # ctl type, law (free floating), start @
      0.  # No. of data items
  244  365  # valid September 1st - December 31st
     1  # No. of periods in day: weekdays    
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000 0.000 0.000 0.000 21.000 100.000 5.000
* Control function    2
# senses dry bulb temperature in main zone
    2    0    0    0  # sensor data
# actuates the air point in current zone.
    0    0    0  # actuator data
    3 # No. day types
    1  120   # valid Tue-01-Jan - April 30
     1  # No. of periods in day
    0    27   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000 0.000 0.000 0.000 21.000 100.000 5.000
   121  243  # valid April 2nd to August 31st
     1  # No. of periods in day    
    0    2   0.000  # ctl type, law (free floating), start @
      0.  # No. of data items
  244  365  # valid September 1st - December 31st
     1  # No. of periods in day: weekdays    
    0    27  0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
   15000 0.000 0.000 0.000 21.000 100.000 5.000
# Function:Zone links
 1,1,0 