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
    1  365  # valid Tue-01-Jan - Wed-31-Dec
     1  # No. of periods in day: weekdays    
    0    2   0.000  # ctl type, law (free floating), start @
      0.  # No. of data items
* Control function    2
# senses dry bulb temperature in main_flrs.
    4    0    0    0  # sensor data
# actuates the air point in main_flrs.
    4    0    0  # actuator data
    5 # No. day types
    1  120  # valid Tue-01-Jan - Wed-30-Apr
     3  # No. of periods in day: weekdays    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 0.000 0.000 21.000 50.000 0.000
    0    1   6.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 0.000 0.000 21.000 50.000 0.000
    0    1  22.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 0.000 0.000 21.000 50.000 0.000
  121  151  # valid Thu-01-May - Sat-31-May
     3  # No. of periods in day: saturday    
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 5272.000 0.000 16.000 23.000 0.000
    0    1   6.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 5272.000 0.000 16.000 23.000 0.000
    0    1  22.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 5272.000 0.000 16.000 23.000 0.000
  152  243  # valid Sun-01-Jun - Sun-31-Aug
     3  # No. of periods in day: sunday      
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 5272.000 0.000 5.000 21.500 0.000
    0    1   6.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 5272.000 0.000 5.000 21.500 0.000
    0    1  22.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  0.000 0.000 5272.000 0.000 5.000 21.500 0.000
  244  273  # valid Mon-01-Sep - Tue-30-Sep
     3  # No. of periods in day:             
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 5272.000 0.000 16.000 23.000 0.000
    0    1   6.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 5272.000 0.000 16.000 23.000 0.000
    0    1  22.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 5272.000 0.000 16.000 23.000 0.000
  274  365  # valid Wed-01-Oct - Wed-31-Dec
     3  # No. of periods in day:             
    0    1   0.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 0.000 0.000 21.000 50.000 0.000
    0    1   6.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 0.000 0.000 21.000 50.000 0.000
    0    1  22.000  # ctl type, law (basic control), start @
      7.  # No. of data items
  10511.000 0.000 0.000 0.000 21.000 50.000 0.000
* Control function    3
# senses dry bulb temperature in main_flrs.
    4    0    0    0  # sensor data
# actuates the air point in basement.
    1    0    0  # actuator data
    1 # No. day types
    1  365  # valid Tue-01-Jan - Wed-31-Dec
     1  # No. of periods in day: weekdays    
    0   21   0.000  # ctl type, law (slave capacity controller), start @
      3.  # No. of data items
  2.000 3003.000 1357.000
# Function:Zone links
 3,1,1,2
#* Mass Flow
#no flow control description supplied
#   2  # No. of controls
#* Control mass    1
## senses dry bulb temperature in main_flrs.
#    4    0    0    0  # sensor data
## actuates flow component:   1 Window-E
#   -4    1    1  # actuator data
#    1 # No. day types
#    1  365  # valid Tue-01-Jan - Wed-31-Dec
#     1  # No. of periods in day: weekdays    
#    1    0   0.000  # ctl type (dry bulb > flow), law (on/off setpoint 26.00 direct action ON fraction 1.000.), starting @
#      3.  # No. of data items
#  26.00000 1.00000 1.00000
#MainFlrs      Outside-e       Window-E    
#* Control mass    2
## senses dry bulb temperature in main_flrs.
#    4    0    0    0  # sensor data
## actuates flow component:   3 Win-s
#   -4    3    1  # actuator data
#    1 # No. day types
#    1  365  # valid Tue-01-Jan - Wed-31-Dec
#     1  # No. of periods in day: weekdays    
#    1    0   0.000  # ctl type (dry bulb > flow), law (on/off setpoint 26.00 direct action ON fraction 1.000.), starting @
#      3.  # No. of data items
#  26.00000 1.00000 1.00000
#MainFlrs      Outside-s       Win-s       
