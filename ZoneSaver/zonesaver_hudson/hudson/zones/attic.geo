*Geometry 1.1,GEN,attic # tag version, format, zone name
*date Fri Apr 15 10:11:45 2011  # latest file modification 
attic describes a
*previous_rotate -45.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,-0.70711,-0.70711,8.60000  #   1
*vertex,4.68105,-6.09526,8.60000  #   2
*vertex,11.75211,0.97581,8.60000  #   3
*vertex,6.36396,6.36396,8.60000  #   4
*vertex,4.24264,1.41421,10.50000  #   5
*vertex,6.80237,-1.14551,10.50000  #   6
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,4,3,2  #  1
*edges,4,1,2,6,5  #  2
*edges,3,2,3,6  #  3
*edges,4,3,4,5,6  #  4
*edges,3,1,5,4  #  5
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Base-6,FLOR,-,-,-,R40_ceiling,OPAQUE,ANOTHER,03,04  #   1 ||< Top-5:second
*surf,Surf-2,SLOP,-,-,-,asphalt,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Surf-3,SLOP,-,-,-,asphalt,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Surf-4,SLOP,-,-,-,asphalt,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Surf-5,SLOP,-,-,-,asphalt,OPAQUE,EXTERIOR,0,0  #   5 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,76.20,0  # zone base
