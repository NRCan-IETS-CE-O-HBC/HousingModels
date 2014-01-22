no overall control description supplied
* Building
no zone control description supplied
   3  # No. of functions
* Control function    1
# senses the temperature of the current zone.
    0    0    0    0  # sensor data
# actuates air point of the current zone
    0    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0    2   0.000  # ctl type, law (free floating), start @
      0.  # No. of data items
* Control function    2
# senses the temperature of the current zone.
    0    0    0    0  # sensor data1
# actuates air point of the current zone
    0    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0    2   0.000  # ctl type, law (free floating), start @
      0.  # No. of data items
* Control function    3
# senses dry bulb temperature in control-zone.
    1    0    0    0  # sensor data
# actuates the air point in control-zone.
    5    0    0  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    0   25   0.000  # ctl type, law (undefined control), start @
      5.  # No. of data items
  19.000 23.000 1.000 3.000 2.000
# Function:Zone links
 1,1,1,1,3
* Mass Flow
no flow control description supplied
   2  # No. of controls
* Control mass    1
# senses dry bulb temperature in afn-zone.
    4    0    0    0  # sensor data
# actuates flow component:   1 window
   -4    1    2  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    1    0   0.000  # ctl type (dry bulb > flow), law (on/off setpoint -15.00 direct action ON fraction 1.000.), starting @
      3.  # No. of data items
  -15.00 1.00000 0.20000
afn-zone      south-node    window      
afn-zone      north-wall    window      
* Control mass    2
# senses dry bulb temperature in control-zone.
    5    0    0    0  # sensor data
# actuates flow component:   2 window5
   -4    2    2  # actuator data
    1 # No. day types
    1  365  # valid Mon-01-Jan - Mon-31-Dec
     1  # No. of periods in day: weekdays    
    1    0   0.000  # ctl type (dry bulb > flow), law (on/off setpoint -15.00 direct action ON fraction 1.000.), starting @
      3.  # No. of data items
  -15.00 1.00000 0.20000
ctl-zone      north-wall    window5     
ctl-zone      south-node    window5     
