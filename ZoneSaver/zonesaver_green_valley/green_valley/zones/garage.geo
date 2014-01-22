# geometry of garage defined in: ../zones/garage.geo
GEN  garage  HOT3000 generated zone  # type, name, descr
      15       9   0.000    # vertices, surfaces, rotation angle
#  X co-ord, Y co-ord, Z co-ord
      0.00000     9.90000     0.00000  # vert   1
      0.00000     3.20000     0.00000  # vert   2
      0.00000     3.20000     2.49000  # vert   3
      0.00000     3.35000     2.49000  # vert   4
      0.00000     9.90000     2.49000  # vert   5
      3.20000     9.90000     0.00000  # vert   6
      3.20000     9.90000     2.49000  # vert   7
      3.20000     3.20000     0.00000  # vert   8
      3.20000     3.35000     0.00000  # vert   9
      3.20000     3.35000     2.49000  # vert  10
      3.20000     3.20000     2.49000  # vert  11
      0.30000     3.20000     0.00000  # vert  12
      0.30000     3.20000     2.10000  # vert  13
      2.90000     3.20000     2.10000  # vert  14
      2.90000     3.20000     0.00000  # vert  15
# no of vertices followed by list of associated vert
   5,  1,  2,  3,  4,  5,
   4,  6,  1,  5,  7,
   4,  8,  9, 10, 11,
   8,  2, 12, 13, 14, 15,  8, 11,  3,
   4,  9,  6,  7, 10,
   5,  2,  1,  6,  9,  8,
   4,  4, 10,  7,  5,
   4,  3, 11, 10,  4,
   4, 12, 15, 14, 13,
# unused index
 0,0,0,0,0,0,0,0,0
# surfaces indentation (m)
 0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00
    3   0   0   0    # default insolation distribution
# surface attributes follow: 
# id  surface      geom  loc/  construction environment
# no  name         type  posn  name         other side
  1, wa01F0104     OPAQ  VERT  ext_wall     SIMILAR      
  2, wa02F0104     OPAQ  VERT  intern_wall  ANOTHER        
  3, wa03F0104     OPAQ  VERT  ext_wall     EXTERIOR       
  4, wa04F0104     OPAQ  VERT  ext_wall     EXTERIOR       
  5, wa05F0104     OPAQ  VERT  intern_wall  ANOTHER        
  6, fl01F0104     OPAQ  FLOR  slab_floor   BASESIMP       
  7, ce01F0104     OPAQ  CEIL  floors_r     ANOTHER        
  8, ce02F0104     OPAQ  SLOP  asphalt      EXTERIOR       
  9, do02F0104     OPAQ  VERT  ext_door     EXTERIOR       
# base
  6  0  0  0  0  0    21.44 0
