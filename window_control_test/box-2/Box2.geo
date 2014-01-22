*Geometry 1.1,GEN,Box2 # tag version, format, zone name
*date Wed Nov 17 12:02:32 2010  # latest file modification 
Box2 describes a
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,2.70000  #   1
*vertex,5.00000,0.00000,2.70000  #   2
*vertex,5.00000,3.00000,2.70000  #   3
*vertex,0.00000,3.00000,2.70000  #   4
*vertex,0.00000,0.00000,5.40000  #   5
*vertex,5.00000,0.00000,5.40000  #   6
*vertex,5.00000,3.00000,5.40000  #   7
*vertex,0.00000,3.00000,5.40000  #   8
*vertex,0.56351,0.00000,3.00429  #   9
*vertex,4.43649,0.00000,3.00429  #  10
*vertex,4.43649,0.00000,5.09571  #  11
*vertex,0.56351,0.00000,5.09571  #  12
*vertex,0.00000,1.97434,3.62309  #  13
*vertex,0.00000,1.02566,3.62309  #  14
*vertex,0.00000,1.02566,4.47691  #  15
*vertex,0.00000,1.97434,4.47691  #  16
*vertex,5.00000,0.91905,3.52715  #  17
*vertex,5.00000,2.08095,3.52715  #  18
*vertex,5.00000,2.08095,4.57285  #  19
*vertex,5.00000,0.91905,4.57285  #  20
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9  #  1
*edges,10,2,3,7,6,2,17,20,19,18,17  #  2
*edges,4,3,4,8,7  #  3
*edges,10,4,1,5,8,4,13,16,15,14,13  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
*edges,4,17,18,19,20  #  9
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
*surf,Top-5,CEIL,-,FICT,OPEN,extern_wall,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,Base-6    ,FLOR,-     ,FICT  ,OPEN,fictitious   ,TRAN,ANOTHER,01,05  #   6 ||< Top-5:Box_1
*surf,Big-window,VERT,Wall-1,WINDOW,OPEN,d_glz,     DCF7671_06nb,EXTERIOR,0,0  #   7 ||< external
*surf,West_window,VERT,Wall-4,WINDOW,OPEN,d_glz,DCF7671_06nb,EXTERIOR,0,0  #   8 ||< external
*surf,East-window,VERT,Wall-2,WINDOW,OPEN,d_glz,DCF7671_06nb,EXTERIOR,0,0  #   9 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,15.00,0  # zone base
