# geometry of basement defined in: ../zones/basement.geo
GEN  basement  HOT3000 generated zone  # type, name, descr
      24      11   0.000    # vertices, surfaces, rotation angle
#  X co-ord, Y co-ord, Z co-ord
      3.20000     3.35000     0.00000  # vert   1
      4.50000     3.35000     0.00000  # vert   2
      4.50000     3.35000     2.10000  # vert   3
      5.40000     3.35000     2.10000  # vert   4
      5.40000     3.35000     0.00000  # vert   5
      6.40000     3.35000     0.00000  # vert   6
      6.40000     3.35000     2.49000  # vert   7
      3.20000     3.35000     2.49000  # vert   8
      3.20000     9.90000     0.00000  # vert   9
      3.20000     9.90000     2.49000  # vert  10
      0.00000     9.90000     0.00000  # vert  11
      0.00000     9.90000     2.49000  # vert  12
      0.00000    13.05000     0.00000  # vert  13
      0.00000    13.05000     2.49000  # vert  14
      6.40000    13.05000     0.00000  # vert  15
      6.40000    13.05000     2.49000  # vert  16
      2.40000    13.05000     0.10000  # vert  17
      2.40000    13.05000     2.20000  # vert  18
      0.80000    13.05000     2.20000  # vert  19
      0.80000    13.05000     0.10000  # vert  20
      5.40000    13.05000     0.90000  # vert  21
      3.15000    13.05000     0.90000  # vert  22
      3.15000    13.05000     1.90000  # vert  23
      5.40000    13.05000     1.90000  # vert  24
# no of vertices followed by list of associated vert
   8,  1,  2,  3,  4,  5,  6,  7,  8,
   4,  9,  1,  8, 10,
   4, 11,  9, 10, 12,
   4, 13, 11, 12, 14,
  17, 15, 13, 14, 16, 15, 21, 24, 23, 22, 21, 15, 17, 18, 19, 20, 17, 15,
   4,  6, 15, 16,  7,
   6,  6,  1,  9, 11, 13, 15,
   6,  8,  7, 16, 14, 12, 10,
   4,  2,  5,  4,  3,
   4, 21, 22, 23, 24,
   4, 17, 20, 19, 18,
# unused index
 0,0,0,0,0,0,0,0,0,0,0
# surfaces indentation (m)
 0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00
    3   0   0   0    # default insolation distribution
# surface attributes follow: 
# id  surface      geom  loc/  construction environment
# no  name         type  posn  name         other side
  1, wa01C0101     OPAQ  VERT  ext_wall     EXTERIOR       
  2, wa02C0101     OPAQ  VERT  intern_wall  ANOTHER        
  3, wa03C0101     OPAQ  VERT  intern_wall  ANOTHER        
  4, wa04C0101     OPAQ  VERT  ext_wall     SIMILAR        
  5, wa05C0101     OPAQ  VERT  ext_wall     EXTERIOR       
  6, wa06C0101     OPAQ  VERT  ext_wall     SIMILAR        
  7, fl01C0101     OPAQ  FLOR  slab_floor   BASESIMP       
  8, ce01C0101     OPAQ  CEIL  floors_r     ANOTHER        
  9, do01C0101     OPAQ  VERT  ext_door     EXTERIOR       
 10, wi02C0101     TRAN  VERT  window       EXTERIOR       
 11, wi03C0101     TRAN  VERT  window       EXTERIOR       
# base
  7  0  0  0  0  0    41.12 0
