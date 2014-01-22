control for NZEH-H3K1  # overall descr 
* Building
building cntl fn model  # bld descr
   4  # No. of functions
* Control Function # 1[L2Z2CoreMain] 
# senses dry bulb temperature in L2Z2CoreMain
    1    0    0    0    0  # sensor data
# actuates air point of the current zone
    0    0    0    0  # actuator data
    5 # No. day types
# ++++++ Day Type: 1 +++++
    1  91  # valid   1 Jan -   1 Apr
     1  # No. of periods in day
#    >>>>Day Type: 1 - Period: 1<<<<
    0    29  0.000  # ctl type, law (basic heating with free cooling), start @
7  # No. of data items
6175.763 0.000 0.000 0.000 22.000 122.000 3.000   # MaxHCap/MinHCap/NoCCap/NoCCap/HStPt/CStPt/FreeCoolDeltaT
# ++++++ Day Type: 2 +++++
    92  154  # valid   2 Apr -   3 Jun
     1  # No. of periods in day
#    >>>>Day Type: 2 - Period: 1<<<<
    0     2  0.000  # ctl type, law (free floating), start @
0  # No. of data items
# ++++++ Day Type: 3 +++++
    155  259  # valid   4 Jun -  16 Sep
     5  # No. of periods in day
#    >>>>Day Type: 3 - Period: 1<<<<
    0     1  0.000  # ctl type, law (basic control), start @
7  # No. of data items
0.000 0.000 0.000 0.000 10.000 27.000 0.000   # MaxHCap/MinHCap/MaxCCap/MinCCap/HStPt/CStPt/ClTRng
#    >>>>Day Type: 3 - Period: 2<<<<
    0     1  6.000  # ctl type, law (basic control), start @
7  # No. of data items
0.000 0.000 0.000 0.000 10.000 24.000 0.000   # MaxHCap/MinHCap/MaxCCap/MinCCap/HStPt/CStPt/ClTRng
#    >>>>Day Type: 3 - Period: 3<<<<
    0     1  9.000  # ctl type, law (basic control), start @
7  # No. of data items
0.000 0.000 0.000 0.000 10.000 27.000 0.000   # MaxHCap/MinHCap/MaxCCap/MinCCap/HStPt/CStPt/ClTRng
#    >>>>Day Type: 3 - Period: 4<<<<
    0     1  16.000  # ctl type, law (basic control), start @
7  # No. of data items
0.000 0.000 0.000 0.000 10.000 24.000 0.000   # MaxHCap/MinHCap/MaxCCap/MinCCap/HStPt/CStPt/ClTRng
#    >>>>Day Type: 3 - Period: 5<<<<
    0     1  22.000  # ctl type, law (basic control), start @
7  # No. of data items
0.000 0.000 0.000 0.000 10.000 27.000 0.000   # MaxHCap/MinHCap/MaxCCap/MinCCap/HStPt/CStPt/ClTRng
# ++++++ Day Type: 4 +++++
    260  280  # valid  17 Sep -   7 Oct
     1  # No. of periods in day
#    >>>>Day Type: 4 - Period: 1<<<<
    0     2  0.000  # ctl type, law (free floating), start @
0  # No. of data items
# ++++++ Day Type: 5 +++++
    281  365  # valid   8 Oct -  31 Dec
     1  # No. of periods in day
#    >>>>Day Type: 5 - Period: 1<<<<
    0    29  0.000  # ctl type, law (basic heating with free cooling), start @
7  # No. of data items
6175.763 0.000 0.000 0.000 22.000 122.000 3.000   # MaxHCap/MinHCap/NoCCap/NoCCap/HStPt/CStPt/FreeCoolDeltaT
# END  Control Function   # 1
* Control Function # 2[L1Z1CoreBasement] 
# senses dry bulb temperature in L2Z2CoreMain
    1    0    0    0    0  # sensor data
# actuates air point of the current zone
    0    0    0    0  # actuator data
    1 # No. day types
# ++++++ Day Type: 1 +++++
    1  365  # valid   1 Jan -  31 Dec
     1  # No. of periods in day
#    >>>>Day Type: 1 - Period: 1<<<<
    0    21  0.000  # ctl type, law (slave law), start @
3  # No. of data items
1.000 8495.841 0.000   # MasterCtlFnc/MaxHCap/MaxCCap
# END  Control Function   # 2
* Control Function # 3[L3Z3CoreMain] 
# senses dry bulb temperature in L2Z2CoreMain
    1    0    0    0    0  # sensor data
# actuates air point of the current zone
    0    0    0    0  # actuator data
    1 # No. day types
# ++++++ Day Type: 1 +++++
    1  365  # valid   1 Jan -  31 Dec
     1  # No. of periods in day
#    >>>>Day Type: 1 - Period: 1<<<<
    0    21  0.000  # ctl type, law (slave law), start @
3  # No. of data items
1.000 10328.396 0.000   # MasterCtlFnc/MaxHCap/MaxCCap
# END  Control Function   # 3
* Control Function # 4[L3Z4CoreAttic] 
# senses the temperature of the current zone.
    0    0    0    0    0  # sensor data
# actuates air point of the current zone
    0    0    0    0  # actuator data
    1 # No. day types
# ++++++ Day Type: 1 +++++
    1  365  # valid   1 Jan -  31 Dec
     1  # No. of periods in day
#    >>>>Day Type: 1 - Period: 1<<<<
    0     2  0.000  # ctl type, law (free floating), start @
0  # No. of data items
# END  Control Function   # 4
# Function:Zone links
1 2 3 4 
