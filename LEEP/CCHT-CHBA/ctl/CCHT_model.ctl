no overall control description supplied
* Building
no zone control description supplied
   3  # No. of functions
#=======================================================================
# Free-float controller for attic, garage.
#=======================================================================
* Control function    1
# senses the temperature of the current zone.
    0    0    0    0  # sensor data
# actuates air point of the current zone
    0    0    0       # actuator data
    1                 # No. day types
    1  365            # valid Tue-01-Jan - Wed-31-Dec
    1                 # No. of periods in day: weekdays    
    0    2   0.000    # ctl type, law (free floating), start @
    0.                # No. of data items
#=======================================================================
# Heating-cooling controller for basement 
#=======================================================================      
* Control function    2
# senses the temperature of the current zone.
    4    0    0    0  # sensor data
# actuates air point of the current zone
    4    0    0       # actuator data
    5                 # No. day types
# -------------------------
# Heating: Jan 1-> April 30
    1  120            # Valid days
    3                 # No. of periods in day.
#...First period: 0h-6h     
    0    1   0.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  0.000               # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  21.000              # Heating setpoint (oC) 
  50.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Second period: 6h-22h   
    0    1   6.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  0.000               # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  21.000              # Heating setpoint (oC) 
  50.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Third period: 22h-24h   
    0    1   22.00    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  0.000               # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  21.000              # Heating setpoint (oC) 
  50.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)  
# -------------------------
# Heating and cooling: May 1 -> May 31
    121  151          # Valid days
    3                 # No. of periods in day.
#...First period: 0h-6h     
    0    1   0.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  18.000              # Heating setpoint (oC) 
  24.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Second period: 6h-22h   
    0    1   6.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  18.000              # Heating setpoint (oC) 
  24.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Third period: 22h-24h   
    0    1   22.00    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  18.000              # Heating setpoint (oC) 
  24.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
# -------------------------
# Cooling: June 1 -> Aug 31
    152  243          # Valid days
    3                 # No. of periods in day.
#...First period: 0h-6h     
    0    1   0.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  0.000               # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
   5.000              # Heating setpoint (oC) 
  22.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Second period: 6h-22h   
    0    1   6.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  0.000               # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  5.000               # Heating setpoint (oC) 
  22.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Third period: 22h-24h   
    0    1   22.00    # ctl type, law (basic control), start @
    7.                # No. of data items
  0.000               # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  5.000               # Heating setpoint (oC) 
  22.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
# -------------------------
# Heating and cooling: Sept 1 -> Sep 30
    244  273          # Valid days
    3                 # No. of periods in day.
#...First period: 0h-6h     
    0    1   0.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  18.000              # Heating setpoint (oC) 
  24.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Second period: 6h-22h   
    0    1   6.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  18.000              # Heating setpoint (oC) 
  24.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Third period: 22h-24h   
    0    1   22.00    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  5272.0              # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  18.000              # Heating setpoint (oC) 
  24.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)  
# -------------------------
# Heating: Oct 1  -> Dec 31.
    274  365          # Valid days
    3                 # No. of periods in day.
#...First period: 0h-6h     
    0    1   0.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  0.000               # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  21.000              # Heating setpoint (oC) 
  50.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Second period: 6h-22h   
    0    1   6.000    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  0.000               # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  21.000              # Heating setpoint (oC) 
  50.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)
#...Third period: 22h-24h   
    0    1   22.00    # ctl type, law (basic control), start @
    7.                # No. of data items
  10511.000           # Max heating capacity (W) 
  0.000               # Min heating capacity (W)
  0.000               # Max cooling capacity (W) 
  0.000               # Min cooling capacity (W) 
  21.000              # Heating setpoint (oC) 
  50.000              # Cooling setpoint (oC)
  0.000               # Thermostat lag (not used)    
#=======================================================================
# Slave control for basement 
* Control function    3
# senses the temperature of the current zone.
    4    0    0    0  # sensor data
# actuates air point of the current zone
    1    0    0       # actuator data
    1 # No. day types
# ++++++ Day Type: 1 +++++
    1  365    # valid Thu  1 Jan - Thu 31 Dec
    1        # No. of periods in day
#    >>>>Day Type: 1 - Period: 1<<<<
    0    21  0.000  # ctl type, law (slave law), start @
    3  # No. of data items
    2.000    # Master control function 
    3503.0   # Max heating capacity (W) 
    1757.0   # Max cooling capacity (W)
# Function:Zone links
 3,1,1,2
