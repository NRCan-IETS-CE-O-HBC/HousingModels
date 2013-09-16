# geometry of L1Z1CoreBasement defined in: user/NZEH-H3K1/zones/L1Z1CoreBasement.geo
GEN  L1Z1CoreBasement  HOT3000 generated zone  # type, name, descr
      24       10 0.000    # vertices, surfaces, rotation angle
#   X co-ord, Y co-ord, Z co-ord
    20.00000  0.00000  98.38000   # vert 1  
    20.00000  10.00000  98.38000   # vert 2  
    20.00000  10.00000  100.66000   # vert 3  
    20.00000  0.00000  100.66000   # vert 4  
    20.00000  9.41500  99.28000   # vert 5  
    20.00000  9.41500  100.48000   # vert 6  
    20.00000  9.70000  100.48000   # vert 7  
    20.00000  9.70000  99.28000   # vert 8  
    0.00000  0.00000  98.38000   # vert 9  
    0.00000  0.00000  100.66000   # vert 10 
    14.57000  0.00000  99.28000   # vert 11 
    14.57000  0.00000  100.48000   # vert 12 
    19.70000  0.00000  100.48000   # vert 13 
    19.70000  0.00000  99.28000   # vert 14 
    0.00000  10.00000  98.38000   # vert 15 
    0.00000  10.00000  100.66000   # vert 16 
    0.00000  0.58500  99.28000   # vert 17 
    0.00000  0.58500  100.48000   # vert 18 
    0.00000  0.30000  100.48000   # vert 19 
    0.00000  0.30000  99.28000   # vert 20 
    5.43000  10.00000  99.28000   # vert 21 
    5.43000  10.00000  100.48000   # vert 22 
    0.30000  10.00000  100.48000   # vert 23 
    0.30000  10.00000  99.28000   # vert 24 
# no of vertices followed by list of associated vert
  11,   1,   2,   3,   4,   1,   5,   6,   7,   8,   5,   1,
  11,   9,   1,   4,  10,   9,  11,  12,  13,  14,  11,   9,
  11,  15,   9,  10,  16,  15,  17,  18,  19,  20,  17,  15,
  11,   2,  15,  16,   3,   2,  21,  22,  23,  24,  21,   2,
   4,   2,   1,   9,  15,
   4,   3,  16,  10,   4,
   4,   5,   8,   7,   6,
   4,  11,  14,  13,  12,
   4,  17,  20,  19,  18,
   4,  21,  24,  23,  22,
# unused index
 0   0   0   0   0   0   0   0   0   0  
# surfaces indentation (m)
0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
    3    0    0    0  # default insolation distribution
# surface attributes follow: 
# id surface       geom  loc/   mlc db      environment
# no name          type  posn   name        other side
  1, wa01C0101     OPAQ  VERT  foundation   BASESIMP       
  2, wa02C0101     OPAQ  VERT  foundation   BASESIMP       
  3, wa03C0101     OPAQ  VERT  foundation   BASESIMP       
  4, wa04C0101     OPAQ  VERT  foundation   BASESIMP       
  5, fl01C0101     OPAQ  FLOR  fnd_floor    BASESIMP       
  6, ce01C0101     OPAQ  CEIL  floors_r     L2Z2CoreMain   
  7, wi01C0101     TRAN  VERT  window       EXTERIOR       
  8, wi02C0101     TRAN  VERT  window       EXTERIOR       
  9, wi03C0101     TRAN  VERT  window       EXTERIOR       
 10, wi04C0101     TRAN  VERT  window       EXTERIOR       
# base
5   0   0   0   0   0   200.00   
