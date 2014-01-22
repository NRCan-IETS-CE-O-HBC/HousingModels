control for green_valley house
* Building
no zone control description supplied
   2  # No. of functions
* Control function    1
# senses dry bulb temperature in main.
    3    0    0    0  # sensor data
# actuates the air point in main.
    3    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  1000.000 0.000 100000.000 0.000 20.000 23.000 0.000
* Control function    2
# senses dry bulb temperature in second.
    4    0    0    0  # sensor data
# actuates the air point in secondfloor.
    4    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  1000.000 0.000 100000.000 0.000 20.000 23.000 0.000
# Function:Zone links
 0,0,1,2,0,0
