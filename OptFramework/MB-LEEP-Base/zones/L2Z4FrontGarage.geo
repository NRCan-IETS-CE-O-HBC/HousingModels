# geometry of L2Z4FrontGarage defined in: user/MB-LEEP/zones/L2Z4FrontGarage.geo
GEN  L2Z4FrontGarage  HOT3000 generated zone  # type, name, descr
      16        8 0.000    # vertices, surfaces, rotation angle
#   X co-ord, Y co-ord, Z co-ord
    0.00000  7.60000  100.66000   # vert 1  
    0.00000  0.00000  100.66000   # vert 2  
    0.00000  0.00000  103.11000   # vert 3  
    0.00000  7.60000  103.11000   # vert 4  
    6.70000  7.60000  100.66000   # vert 5  
    6.70000  7.60000  103.11000   # vert 6  
    6.70000  0.00000  100.66000   # vert 7  
    6.70000  0.00000  103.11000   # vert 8  
    6.70000  1.50000  101.66000   # vert 9  
    6.70000  1.50000  102.16000   # vert 10 
    6.70000  2.52000  102.16000   # vert 11 
    6.70000  2.52000  101.66000   # vert 12 
    0.30000  0.00000  100.66000   # vert 13 
    0.30000  0.00000  102.75999   # vert 14 
    6.40000  0.00000  102.75999   # vert 15 
    6.40000  0.00000  100.66000   # vert 16 
# no of vertices followed by list of associated vert
   4,   1,   2,   3,   4,
   4,   5,   1,   4,   6,
  11,   7,   5,   6,   8,   7,   9,  10,  11,  12,   9,   7,
   8,   2,  13,  14,  15,  16,   7,   8,   3,
   4,   2,   1,   5,   7,
   4,   3,   8,   6,   4,
   4,   9,  12,  11,  10,
   4,  13,  16,  15,  14,
# unused index
 0   0   0   0   0   0   0   0  
# surfaces indentation (m)
0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
    3    0    0    0  # default insolation distribution
# surface attributes follow: 
# id surface       geom  loc/   mlc db      environment
# no name          type  posn   name        other side
  1, wa01F0204     OPAQ  VERT  ex_brk     EXTERIOR       
  2, wa02F0204     OPAQ  VERT  <Opt-MainWall-Dry>R  L2Z2CoreMain   
  3, wa03F0204     OPAQ  VERT  ex_brk     EXTERIOR       
  4, wa04F0204     OPAQ  VERT  ex_brk     EXTERIOR       
  5, fl01F0204     OPAQ  FLOR  grg_slab   BASESIMP       
  6, ce01F0204     OPAQ  CEIL  <Opt-ExposedFloor-r>     L2Z3CoreAttic  
  7, wi01F0204     TRAN  VERT  <OptBW-Construction>       EXTERIOR       
  8, do02F0204     OPAQ  VERT  ex_brk     EXTERIOR       
# base
5   0   0   0   0   0   50.92    
