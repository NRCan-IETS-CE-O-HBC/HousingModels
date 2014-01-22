*Geometry 1.1,GEN,no-flow-zone # tag version, format, zone name
*date Mon Feb 28 13:48:23 2011  # latest file modification 
box1 describes a
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00000  #   1
*vertex,5.00000,0.00000,0.00000  #   2
*vertex,5.00000,5.00000,0.00000  #   3
*vertex,0.00000,5.00000,0.00000  #   4
*vertex,0.00000,0.00000,3.00000  #   5
*vertex,5.00000,0.00000,3.00000  #   6
*vertex,5.00000,5.00000,3.00000  #   7
*vertex,0.00000,5.00000,3.00000  #   8
*vertex,1.38197,0.00000,0.82918  #   9
*vertex,3.61803,0.00000,0.82918  #  10
*vertex,3.61803,0.00000,2.17082  #  11
*vertex,1.38197,0.00000,2.17082  #  12
*vertex,5.00000,1.53175,0.91905  #  13
*vertex,5.00000,3.46825,0.91905  #  14
*vertex,5.00000,3.46825,2.08095  #  15
*vertex,5.00000,1.53175,2.08095  #  16
*vertex,3.46825,5.00000,0.91905  #  17
*vertex,1.53175,5.00000,0.91905  #  18
*vertex,1.53175,5.00000,2.08095  #  19
*vertex,3.46825,5.00000,2.08095  #  20
*vertex,0.00000,3.46825,0.91905  #  21
*vertex,0.00000,1.53175,0.91905  #  22
*vertex,0.00000,1.53175,2.08095  #  23
*vertex,0.00000,3.46825,2.08095  #  24
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9  #  1
*edges,10,2,3,7,6,2,13,16,15,14,13  #  2
*edges,10,3,4,8,7,3,17,20,19,18,17  #  3
*edges,10,4,1,5,8,4,21,24,23,22,21  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
*edges,4,17,18,19,20  #  9
*edges,4,21,22,23,24  # 10
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,extern_wall,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,extern_wall,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,extern_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-4,VERT,-,-,-,extern_wall,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Top-5,CEIL,-,-,-,extern_wall,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,Base-6,FLOR,-,-,-,extern_wall,OPAQUE,EXTERIOR,0,0  #   6 ||< external
*surf,win-south,VERT,Wall-1,WINDOW,OPEN,dbl_glz,DCF7671_06nb,EXTERIOR,0,0  #   7 ||< external
*surf,win-east,VERT,Wall-2,WINDOW,OPEN,dbl_glz,DCF7671_06nb,EXTERIOR,0,0  #   8 ||< external
*surf,win-north,VERT,Wall-3,WINDOW,OPEN,dbl_glz,DCF7671_06nb,EXTERIOR,0,0  #   9 ||< external
*surf,win-west,VERT,Wall-4,WINDOW,OPEN,dbl_glz,DCF7671_06nb,EXTERIOR,0,0  #  10 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,25.00,0  # zone base
