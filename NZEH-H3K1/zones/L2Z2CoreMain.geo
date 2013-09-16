# geometry of L2Z2CoreMain defined in: user/NZEH-H3K1/zones/L2Z2CoreMain.geo
GEN  L2Z2CoreMain  HOT3000 generated zone  # type, name, descr
      32       12 0.000    # vertices, surfaces, rotation angle
#   X co-ord, Y co-ord, Z co-ord
    20.00000  0.00000  100.66000   # vert 1  
    20.00000  10.00000  100.66000   # vert 2  
    20.00000  10.00000  103.11000   # vert 3  
    20.00000  0.00000  103.11000   # vert 4  
    20.00000  9.39375  101.56000   # vert 5  
    20.00000  9.39375  102.75999   # vert 6  
    20.00000  9.70000  102.75999   # vert 7  
    20.00000  9.70000  101.56000   # vert 8  
    0.00000  0.00000  100.66000   # vert 9  
    0.30000  0.00000  100.66000   # vert 10 
    0.30000  0.00000  102.75999   # vert 11 
    1.20000  0.00000  102.75999   # vert 12 
    1.20000  0.00000  100.66000   # vert 13 
    0.00000  0.00000  103.11000   # vert 14 
    14.18750  0.00000  101.56000   # vert 15 
    14.18750  0.00000  102.75999   # vert 16 
    19.70000  0.00000  102.75999   # vert 17 
    19.70000  0.00000  101.56000   # vert 18 
    0.00000  10.00000  100.66000   # vert 19 
    0.00000  10.00000  103.11000   # vert 20 
    0.00000  0.60625  101.56000   # vert 21 
    0.00000  0.60625  102.75999   # vert 22 
    0.00000  0.30000  102.75999   # vert 23 
    0.00000  0.30000  101.56000   # vert 24 
    19.70000  10.00000  100.66000   # vert 25 
    19.70000  10.00000  102.75999   # vert 26 
    18.80000  10.00000  102.75999   # vert 27 
    18.80000  10.00000  100.66000   # vert 28 
    5.81250  10.00000  101.56000   # vert 29 
    5.81250  10.00000  102.75999   # vert 30 
    0.30000  10.00000  102.75999   # vert 31 
    0.30000  10.00000  101.56000   # vert 32 
# no of vertices followed by list of associated vert
  11,   1,   2,   3,   4,   1,   5,   6,   7,   8,   5,   1,
  15,   9,  10,  11,  12,  13,   1,   4,  14,   9,  15,  16,  17,  18,  15,   9,
  11,  19,   9,  14,  20,  19,  21,  22,  23,  24,  21,  19,
  15,   2,  25,  26,  27,  28,  19,  20,   3,   2,  29,  30,  31,  32,  29,   2,
   4,   2,   1,   9,  19,
   4,   3,  20,  14,   4,
   4,   5,   8,   7,   6,
   4,  10,  13,  12,  11,
   4,  15,  18,  17,  16,
   4,  21,  24,  23,  22,
   4,  25,  28,  27,  26,
   4,  29,  32,  31,  30,
# unused index
 0   0   0   0   0   0   0   0   0   0   0   0  
# surfaces indentation (m)
0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
    3    0    0    0  # default insolation distribution
# surface attributes follow: 
# id surface       geom  loc/   mlc db      environment
# no name          type  posn   name        other side
  1, wa01C0202     OPAQ  VERT  ext_wall     EXTERIOR       
  2, wa02C0202     OPAQ  VERT  ext_wall     EXTERIOR       
  3, wa03C0202     OPAQ  VERT  ext_wall     EXTERIOR       
  4, wa04C0202     OPAQ  VERT  ext_wall     EXTERIOR       
  5, fl01C0202     OPAQ  FLOR  floors       L1Z1CoreBasement
  6, ce01C0202     OPAQ  CEIL  floors_r     L3Z3CoreMain   
  7, wi01C0202     TRAN  VERT  window       EXTERIOR       
  8, do01C0202     OPAQ  VERT  ext_door     EXTERIOR       
  9, wi02C0202     TRAN  VERT  window       EXTERIOR       
 10, wi03C0202     TRAN  VERT  window       EXTERIOR       
 11, do02C0202     OPAQ  VERT  ext_door     EXTERIOR       
 12, wi04C0202     TRAN  VERT  window       EXTERIOR       
# base
5   0   0   0   0   0   200.00   
