control for CCHT house
* Building
no descrip
   3  # No. of functions
* Control function
# senses dry bulb temperature in main.
    2    0    0    0  # sensor data
# actuates the air point in main.
    2    0    0  # actuator data
    1 # No. day types
    1  365  # valid Sat-01-Jan - Sat-31-Dec
     3  # No. of periods in day
    0   10   0.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 22.000 33.5 32.5
    0   10   5.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 22.000 23.5 22.5
    0   10   22.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 22.000 33.5 32.5
* Control function
# senses dry bulb temperature in second.
    3    0    0    0  # sensor data
# actuates the air point in second.
    3    0    0  # actuator data
    1 # No. day types
    1  365  # valid Sat-01-Jan - Sat-31-Dec
     3  # No. of periods in day
    0   10   0.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 22.000 23.5 22.5
    0   10  7.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 22.000 33.5 32.5
    0   10  18.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 22.000 23.5 22.5
* Control function
# senses dry bulb temperature in basement.
    1    0    0    0  # sensor data
# actuates the air point in basement.
    1    0    0  # actuator data
    1 # No. day types
    1  365  # valid Sat-01-Jan - Sat-31-Dec
     1  # No. of periods in day
    0   10   0.000  # ctl type, law (separate ON/OFF flux), start @
      6.  # No. of data items
  100000.000 100000.000 20.000 2.000 100.000 98.000
# Function:Zone links
 3,1,2,0,0
