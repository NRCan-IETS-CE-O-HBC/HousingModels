# geometry of main defined in: ../zones/main.geo
GEN  main  HOT3000 generated zone  # type, name, descr
      29      11   0.000    # vertices, surfaces, rotation angle
#  X co-ord, Y co-ord, Z co-ord
      0.00000     3.35000     2.49000  # vert   1
      3.20000     3.35000     2.49000  # vert   2
      6.40000     3.35000     2.49000  # vert   3
      6.40000     3.35000     4.98000  # vert   4
      3.20000     3.35000     4.98000  # vert   5
      0.00000     3.35000     4.98000  # vert   6
      4.50000     3.35000     3.38999  # vert   7
      4.50000     3.35000     4.38999  # vert   8
      5.25000     3.35000     4.38999  # vert   9
      5.25000     3.35000     3.38999  # vert  10
      0.00000    13.05000     2.49000  # vert  11
      0.00000     9.90000     2.49000  # vert  12
      0.00000     6.70000     4.98000  # vert  13
      0.00000    13.05000     4.98000  # vert  14
      6.40000    13.05000     2.49000  # vert  15
      6.40000    13.05000     4.98000  # vert  16
      1.90000    13.05000     3.38999  # vert  17
      1.90000    13.05000     4.38999  # vert  18
      1.15000    13.05000     4.38999  # vert  19
      1.15000    13.05000     3.38999  # vert  20
      3.20000     9.90000     2.49000  # vert  21
      1.00000     3.35000     3.39000  # vert  22
      3.25000     3.35000     3.39000  # vert  23
      3.25000     3.35000     4.39000  # vert  24
      1.00000     3.35000     4.39000  # vert  25
      5.40000    13.05000     3.39000  # vert  26
      3.15000    13.05000     3.39000  # vert  27
      3.15000    13.05000     4.39000  # vert  28
      5.40000    13.05000     4.39000  # vert  29
# no of vertices followed by list of associated vert
  19,  1,  2,  3,  4,  5,  6,  1, 22, 25, 24, 23, 22,  1,  7,  8,  9, 10,  7,  1,
   6, 11, 12,  1,  6, 13, 14,
  17, 15, 11, 14, 16, 15, 26, 29, 28, 27, 26, 15, 17, 18, 19, 20, 17, 15,
   4,  3, 15, 16,  4,
   4,  2,  1, 12, 21,
   6,  3,  2, 21, 12, 11, 15,
   6,  6,  5,  4, 16, 14, 13,
   4, 22, 23, 24, 25,
   4,  7, 10,  9,  8,
   4, 26, 27, 28, 29,
   4, 17, 20, 19, 18,
# unused index
 0,0,0,0,0,0,0,0,0,0,0
# surfaces indentation (m)
 0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00
    3   0   0   0    # default insolation distribution
# surface attributes follow: 
# id  surface      geom  loc/  construction environment
# no  name         type  posn  name         other side
  1, wa01C0202     OPAQ  VERT  ext_wall     EXTERIOR       
  2, wa02C0202     OPAQ  VERT  ext_wall     SIMILAR      
  3, wa03C0202     OPAQ  VERT  ext_wall     EXTERIOR       
  4, wa04C0202     OPAQ  VERT  ext_wall     SIMILAR      
  5, fl01C0202     OPAQ  FLOR  floors       ANOTHER        
  6, fl02C0202     OPAQ  FLOR  floors       ANOTHER        
  7, ce01C0202     OPAQ  CEIL  floors_r     ANOTHER        
  8, wi01C0202     TRAN  VERT  window       EXTERIOR       
  9, wi03C0202     TRAN  VERT  window       EXTERIOR       
 10, wi02C0202     TRAN  VERT  window       EXTERIOR       
 11, wi04C0202     TRAN  VERT  window       EXTERIOR       
# base
  5  6  0  0  0  0    62.08 0
