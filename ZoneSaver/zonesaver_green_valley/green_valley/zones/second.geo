# geometry of second defined in: ../zones/second.geo
GEN  second  HOT3000 generated zone  # type, name, descr
      26      10   0.000    # vertices, surfaces, rotation angle
#  X co-ord, Y co-ord, Z co-ord
      0.00000    13.05000     4.98000  # vert   1
      0.00000     6.70000     4.98000  # vert   2
      0.00000     3.35000     4.98000  # vert   3
      0.00000     3.35000     7.47000  # vert   4
      0.00000    13.05000     7.47000  # vert   5
      6.40000    13.05000     4.98000  # vert   6
      6.40000    13.05000     7.47000  # vert   7
      1.90000    13.05000     5.88000  # vert   8
      1.90000    13.05000     6.88000  # vert   9
      1.15000    13.05000     6.88000  # vert  10
      1.15000    13.05000     5.88000  # vert  11
      6.40000     3.35000     4.98000  # vert  12
      6.40000     3.35000     7.47000  # vert  13
      3.20000     3.35000     4.98000  # vert  14
      4.50000     3.35000     5.88000  # vert  15
      4.50000     3.35000     6.88000  # vert  16
      5.25000     3.35000     6.88000  # vert  17
      5.25000     3.35000     5.88000  # vert  18
      5.40000    13.05000     5.88000  # vert  19
      3.15000    13.05000     5.88000  # vert  20
      3.15000    13.05000     6.88000  # vert  21
      5.40000    13.05000     6.88000  # vert  22
      1.00000     3.35000     5.88000  # vert  23
      3.25000     3.35000     5.88000  # vert  24
      3.25000     3.35000     6.88000  # vert  25
      1.00000     3.35000     6.88000  # vert  26
# no of vertices followed by list of associated vert
   5,  1,  2,  3,  4,  5,
  17,  6,  1,  5,  7,  6, 19, 22, 21, 20, 19,  6,  8,  9, 10, 11,  8,  6,
   4, 12,  6,  7, 13,
  18,  3, 14, 12, 13,  4,  3, 23, 26, 25, 24, 23,  3, 15, 16, 17, 18, 15,  3,
   6,  3,  2,  1,  6, 12, 14,
   4,  4, 13,  7,  5,
   4, 19, 20, 21, 22,
   4,  8, 11, 10,  9,
   4, 23, 24, 25, 26,
   4, 15, 18, 17, 16,
# unused index
 0,0,0,0,0,0,0,0,0,0
# surfaces indentation (m)
 0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00
    3   0   0   0    # default insolation distribution
# surface attributes follow: 
# id  surface      geom  loc/  construction environment
# no  name         type  posn  name         other side
  1, wa01C0303     OPAQ  VERT  ext_wall     SIMILAR      
  2, wa02C0303     OPAQ  VERT  ext_wall     EXTERIOR       
  3, wa03C0303     OPAQ  VERT  ext_wall     SIMILAR      
  4, wa04C0303     OPAQ  VERT  ext_wall     EXTERIOR       
  5, fl01C0303     OPAQ  FLOR  floors       ANOTHER        
  6, ce01C0303     OPAQ  CEIL  asphalt      EXTERIOR       
  7, wi01C0303     TRAN  VERT  window       EXTERIOR       
  8, wi03C0303     TRAN  VERT  window       EXTERIOR       
  9, wi02C0303     TRAN  VERT  window       EXTERIOR       
 10, wi04C0303     TRAN  VERT  window       EXTERIOR       
# base
  5  0  0  0  0  0    62.08 0
