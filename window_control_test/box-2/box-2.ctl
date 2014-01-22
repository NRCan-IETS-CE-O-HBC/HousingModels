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
  20000.000 0.000 0.000 0.000 0.000 50.000 0.000
* Control function    2
# senses dry bulb temperature in Box_1.
    1    0    0    0  # sensor data
# actuates the air point in Box_1.
    1    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
      4.  # No. of data items
  23.000 18.000 3.000 3.000
# Function:Zone links
 1,0
* Mass Flow
no flow control description supplied
   1  # No. of controls
* Control mass    1
# senses dry bulb temperature in Box_1.
    1    0    0    0  # sensor data
# actuates flow connection:   2 Box_1 - South-bottom via win-bot-sout
   -3    2    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    1    0   0.000  # ctl type (dry bulb > flow), law (on/off setpoint 23.00 direct action ON fraction 1.000.), starting @
      3.  # No. of data items
  0.00000 1.00000 0.10000
