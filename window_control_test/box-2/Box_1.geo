*Geometry 1.1,GEN,Box_1 # tag version, format, zone name
*date Wed Nov 17 11:31:33 2010  # latest file modification 
Box_1 describes a base zone
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00000  #   1
*vertex,5.00000,0.00000,0.00000  #   2
*vertex,5.00000,3.00000,0.00000  #   3
*vertex,0.00000,3.00000,0.00000  #   4
*vertex,0.00000,0.00000,2.70000  #   5
*vertex,5.00000,0.00000,2.70000  #   6
*vertex,5.00000,3.00000,2.70000  #   7
*vertex,0.00000,3.00000,2.70000  #   8
*vertex,0.56351,0.00000,0.30429  #   9
*vertex,4.43649,0.00000,0.30429  #  10
*vertex,4.43649,0.00000,2.39571  #  11
*vertex,0.56351,0.00000,2.39571  #  12
*vertex,0.00000,1.97434,0.92309  #  13
*vertex,0.00000,1.02566,0.92309  #  14
*vertex,0.00000,1.02566,1.77691  #  15
*vertex,0.00000,1.97434,1.77691  #  16
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9  #  1
*edges,4,2,3,7,6  #  2
*edges,4,3,4,8,7  #  3
*edges,10,4,1,5,8,4,13,16,15,14,13  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
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
*surf,Top-5,CEIL,-,FICT,OPEN,fictitious,SC_fictit,ANOTHER,02,06  #   5 ||< Base-6:Box2
*surf,Base-6,FLOR,-,-,-,extern_wall,OPAQUE,ANOTHER,01,05  #   6 ||< external
*surf,Big-window,VERT,Wall-1,WINDOW,OPEN,d_glz,DCF7671_06nb,EXTERIOR,0,0  #   7 ||< external
*surf,West_window,VERT,Wall-4,WINDOW,OPEN,d_glz,DCF7671_06nb,EXTERIOR,0,0  #   8 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,15.00,0  # zone base
