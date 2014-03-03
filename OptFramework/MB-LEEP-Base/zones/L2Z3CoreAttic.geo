# geometry of L2Z3CoreAttic defined in: user/MB-LEEP/zones/L2Z3CoreAttic.geo
GEN  L2Z3CoreAttic  HOT3000 generated zone  # type, name, descr
      16      12  0.000    # vertices, surfaces, rotation angle
#   X co-ord, Y co-ord, Z co-ord
    12.10000  7.60000  103.67000   # vert 1  
    12.10000  18.40000  103.67000   # vert 2  
    12.10000  13.00000  105.46982   # vert 3  
    0.00000  18.40000  103.67000   # vert 4  
    0.00000  7.60000  103.67000   # vert 5  
    0.00000  13.00000  105.46982   # vert 6  
    0.00000  0.00000  103.67000   # vert 7  
    6.70000  0.00000  103.67000   # vert 8  
    3.35000  0.00000  104.78655   # vert 9  
    12.10000  20.90000  103.67000   # vert 10 
    7.60000  20.90000  103.67000   # vert 11 
    9.85000  20.90000  104.41992   # vert 12 
    6.70000  7.60000  103.67000   # vert 13 
    7.60000  18.40000  103.67000   # vert 14 
    3.35000  10.95000  104.78655   # vert 15 
    9.85000  16.15000  104.41992   # vert 16 
# no of vertices followed by list of associated vert
   3,   1,   2,   3,
   3,   4,   5,   6,
   3,   7,   8,   9,
   3,  10,  11,  12,
   4,   7,   5,  13,   8,
   8,   1,  13,   5,   4,  14,  11,  10,   2,
   6,   5,  15,  13,   1,   3,   6,
   6,   2,  16,  14,   4,   6,   3,
   4,   8,  13,  15,   9,
   4,   5,   7,   9,  15,
   4,   2,  10,  12,  16,   
   4,  11,  14,  16,  12,   
# unused index
 0   0   0   0   0   0   0   0   0   0   0   0   0  
# surfaces indentation (m)
0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
    3    0    0    0  # default insolation distribution
# surface attributes follow: 
# id surface       geom  loc/   mlc db      environment
# no name          type  posn   name        other side
  1, wa01C0203     OPAQ  VERT  roof     EXTERIOR       
  2, wa02C0203     OPAQ  VERT  roof     EXTERIOR       
  3, wa03C0203     OPAQ  VERT  roof     EXTERIOR       
  4, wa04C0203     OPAQ  VERT  roof     EXTERIOR       
  5, fl01C0203     OPAQ  FLOR  <Opt-Ceiling>R       L2Z4FrontGarage
  6, fl02C0203     OPAQ  FLOR  <Opt-Ceiling>R       L2Z2CoreMain   
  7, ce01C0203     OPAQ  SLOP  roof      EXTERIOR       
  8, ce02C0203     OPAQ  SLOP  roof      EXTERIOR       
  9, ce03C0203     OPAQ  SLOP  roof      EXTERIOR       
 10, ce04C0203     OPAQ  SLOP  roof      EXTERIOR
 11, ce06C0203     OPAQ  SLOP  roof      EXTERIOR       
 12, ce07C0203     OPAQ  SLOP  roof      EXTERIOR       
# base
5   6   0   0   0   0   192.85   
