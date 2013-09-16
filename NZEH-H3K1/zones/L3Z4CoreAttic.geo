# geometry of L3Z4CoreAttic defined in: user/NZEH-H3K1/zones/L3Z4CoreAttic.geo
GEN  L3Z4CoreAttic  HOT3000 generated zone  # type, name, descr
       6        5 0.000    # vertices, surfaces, rotation angle
#   X co-ord, Y co-ord, Z co-ord
    0.00000  10.00000  105.56000   # vert 1  
    0.00000  0.00000  105.56000   # vert 2  
    0.00000  5.00000  107.22649   # vert 3  
    20.00000  0.00000  105.56000   # vert 4  
    20.00000  10.00000  105.56000   # vert 5  
    20.00000  5.00000  107.22649   # vert 6  
# no of vertices followed by list of associated vert
   3,   1,   2,   3,
   3,   4,   5,   6,
   4,   5,   4,   2,   1,
   4,   5,   1,   3,   6,
   4,   2,   4,   6,   3,
# unused index
 0   0   0   0   0  
# surfaces indentation (m)
0.000 0.000 0.000 0.000 0.000 
    3    0    0    0  # default insolation distribution
# surface attributes follow: 
# id surface       geom  loc/   mlc db      environment
# no name          type  posn   name        other side
  1, wa01C0304     OPAQ  VERT  ext_wall     EXTERIOR       
  2, wa02C0304     OPAQ  VERT  ext_wall     EXTERIOR       
  3, fl01C0304     OPAQ  FLOR  floors       L3Z3CoreMain   
  4, ce01C0304     OPAQ  SLOP  asphalt      EXTERIOR       
  5, ce02C0304     OPAQ  SLOP  asphalt      EXTERIOR       
# base
3   0   0   0   0   0   200.00   
