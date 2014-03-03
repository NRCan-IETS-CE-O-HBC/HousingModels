# geometry of L1Z1CoreBasement defined in: user/MB-LEEP/zones/L1Z1CoreBasement.geo
GEN  L1Z1CoreBasement  HOT3000 generated zone  # type, name, descr
      27       11 0.000    # vertices, surfaces, rotation angle
#   X co-ord, Y co-ord, Z co-ord
    0.00000  7.60000  98.46000   # vert 1  
    12.10000  7.60000  98.46000   # vert 2  
    12.10000  7.60000  100.90000   # vert 3  
    6.70000  7.60000  100.90000   # vert 4  
    0.00000  7.60000  100.90000   # vert 5  
    0.00000  18.40000  98.46000   # vert 6  
    0.00000  18.40000  100.90000   # vert 7  
    0.00000  16.40000  100.01000   # vert 8  
    0.00000  16.40000  100.61000   # vert 9  
    0.00000  14.90000  100.61000   # vert 10 
    0.00000  14.90000  100.01000   # vert 11 
    7.60000  18.40000  98.46000   # vert 12 
    7.60000  18.40000  100.90000   # vert 13 
    7.60000  20.90000  98.46000   # vert 14 
    7.60000  20.90000  100.90000   # vert 15 
    12.10000  20.90000  98.46000   # vert 16 
    12.10000  20.90000  100.90000   # vert 17 
    12.10000  18.40000  98.46000   # vert 18 
    12.10000  18.40000  100.90000   # vert 19 
    12.10000  14.90000  100.01000   # vert 20 
    12.10000  14.90000  100.61000   # vert 21 
    12.10000  16.40000  100.61000   # vert 22 
    12.10000  16.40000  100.01000   # vert 23 
    12.10000  10.59995  100.01000   # vert 24 
    12.10000  12.09995  100.01000   # vert 25 
    12.10000  12.09995  100.61000   # vert 26 
    12.10000  10.59995  100.61000   # vert 27 
# no of vertices followed by list of associated vert
   5,   1,   2,   3,   4,   5,
  11,   6,   1,   5,   7,   6,   8,   9,  10,  11,   8,   6,
   4,  12,   6,   7,  13,
   4,  14,  12,  13,  15,
   4,  16,  14,  15,  17,
  13,   2,  18,  16,  17,  19,   3,   2,  20,  21,  22,  23,  20,   2,
   7,   2,   1,   6,  12,  14,  16,  18,
   8,   5,   4,   3,  19,  17,  15,  13,   7,
   4,   8,  11,  10,   9,
   4,  24,  25,  26,  27,
   4,  20,  23,  22,  21,
# unused index
 0   0   0   0   0   0   0   0   0   0   0  
# surfaces indentation (m)
0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
    3    0    0    0  # default insolation distribution
# surface attributes follow: 
# id surface       geom  loc/   mlc db      environment
# no name          type  posn   name        other side
  1, wa01C0101     OPAQ  VERT  <OPT-BsmWall>   BASESIMP       
  2, wa02C0101     OPAQ  VERT  <OPT-BsmWall>   BASESIMP       
  3, wa03C0101     OPAQ  VERT  <OPT-BsmWall>   BASESIMP       
  4, wa04C0101     OPAQ  VERT  <OPT-BsmWall>   BASESIMP       
  5, wa05C0101     OPAQ  VERT  <OPT-BsmWall>   BASESIMP       
  6, wa06C0101     OPAQ  VERT  <OPT-BsmWall>   BASESIMP       
  7, fl01C0101     OPAQ  FLOR  <OPT-BsmFloor>    BASESIMP       
  8, ce01C0101     OPAQ  CEIL  <Opt-IntFloorInv>     L2Z2CoreMain   
  9, wi02C0101     TRAN  VERT  <OptBW-Construction>       EXTERIOR       
 10, wi06C0101     TRAN  VERT  <OptBW-Construction>       EXTERIOR       
 11, wi03C0101     TRAN  VERT  <OptBW-Construction>       EXTERIOR       
# base
7   0   0   0   0   0   141.93   
