*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Wed Oct  6 11:26:12 2010  # latest file modification 
garage describes the uncontrolled garage
*previous_rotate 270.00,   6.000,   6.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,6.79000,0.00000,0.00000  #   1
*vertex,12.20000,0.00000,0.00000  #   2
*vertex,12.20000,6.81501,0.00000  #   3
*vertex,6.79000,6.81500,0.00000  #   4
*vertex,6.79000,0.00000,2.77000  #   5
*vertex,12.20000,0.00000,2.77000  #   6
*vertex,12.20000,6.81501,2.77000  #   7
*vertex,6.79000,6.81500,2.77000  #   8
*vertex,8.74000,0.00000,2.77000  #   9
*vertex,12.20000,3.67000,2.77000  #  10
*vertex,8.74000,3.67000,2.77000  #  11
*vertex,9.49500,0.00000,2.77000  #  12
*vertex,6.79000,5.81500,2.77000  #  13
*vertex,6.79000,0.10000,2.77000  #  14
# 
# tag, number of vertices followed by list of associated vert
*edges,6,1,2,6,12,9,5  #  1
*edges,5,2,3,7,10,6  #  2
*edges,4,3,4,8,7  #  3
*edges,6,4,1,5,14,13,8  #  4
*edges,4,1,4,3,2  #  5
*edges,8,5,9,11,10,7,8,13,14  #  6
*edges,5,11,9,12,6,10  #  7
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,ext_wall_gar,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,ext_wall_gar,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,ext_wall_inv,OPAQUE,ANOTHER,04,06  #   3 ||< Wall-3:main_flrs
*surf,Wall-4,VERT,-,-,-,ext_wall_inv,OPAQUE,ANOTHER,04,07  #   4 ||< Wall-20:main_flrs
*surf,Base-6,FLOR,-,-,-,bsmt_floor,OPAQUE,BASESIMP,02,**  #   5 ||< BASESIMP config type   2
*surf,Top-13,CEIL,-,-,-,gar-ceiling,OPAQUE,ANOTHER,04,11  #   6 ||< Top-13:main_flrs
*surf,Base-13,CEIL,-,-,-,main_ceiling,OPAQUE,ANOTHER,03,12  #   7 ||< Base-13:attic
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,2,6,5,    61.04 0  # zone base list
