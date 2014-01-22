no overall control description supplied
* Building
no zone control description supplied
   2  # No. of functions
* Control function    1
# senses the temperature of the current zone.
    0    0    0    2  # sensor data
# actuates air point of the current zone
    0    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10500.000 0.000 0.000 0.000 21.000 50.000 0.000
* Control function    2
# senses dry bulb temperature in main_flr.
    1    0    0    0  # sensor data
# actuates the air point in main_flr.
    1    0    0       # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
      4.  # No. of data items
  24.000 18.000 1.000 1.000
# Function:Zone links
 1,0,0,0
