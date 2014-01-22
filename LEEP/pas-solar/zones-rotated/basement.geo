*Geometry 1.1,GEN,basement # tag version, format, zone name
*date Tue Oct  5 15:13:41 2010  # latest file modification 
basement describes the CCHT basement
*previous_rotate 180.00,   6.000,   6.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,12.00000,12.00000,-2.35000  #   1
*vertex,5.21000,12.00000,-2.35000  #   2
*vertex,5.21000,5.18500,-2.35000  #   3
*vertex,-0.20000,5.18499,-2.35000  #   4
*vertex,-0.20000,-0.09000,-2.35000  #   5
*vertex,12.00000,-0.09000,-2.35000  #   6
*vertex,12.00000,12.00000,0.00000  #   7
*vertex,5.21000,12.00000,0.00000  #   8
*vertex,5.21000,5.18500,0.00000  #   9
*vertex,-0.20000,5.18499,0.00000  #  10
*vertex,-0.20000,-0.09000,0.00000  #  11
*vertex,12.00000,-0.09000,0.00000  #  12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,8,7  #  1
*edges,4,2,3,9,8  #  2
*edges,4,3,4,10,9  #  3
*edges,4,4,5,11,10  #  4
*edges,4,5,6,12,11  #  5
*edges,4,6,1,7,12  #  6
*edges,6,7,8,9,10,11,12  #  7
*edges,6,1,6,5,4,3,2  #  8
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,bsmt_walls,OPAQUE,BASESIMP,01,06  #   1 ||< BASESIMP config type   1
*surf,Wall-2,VERT,-,-,-,bsmt_walls,OPAQUE,BASESIMP,01,06  #   2 ||< BASESIMP config type   1
*surf,Wall-3,VERT,-,-,-,bsmt_walls,OPAQUE,BASESIMP,01,06  #   3 ||< BASESIMP config type   1
*surf,Wall-4,VERT,-,-,-,bsmt_walls,OPAQUE,BASESIMP,01,06  #   4 ||< BASESIMP config type   1
*surf,Wall-5,VERT,-,-,-,bsmt_walls,OPAQUE,BASESIMP,01,12  #   5 ||< BASESIMP config type   1
*surf,Wall-6,VERT,-,-,-,bsmt_walls,OPAQUE,BASESIMP,01,13  #   6 ||< BASESIMP config type   1
*surf,Top-7,CEIL,-,-,-,bsmt_ceiling,OPAQUE,ANOTHER,04,15  #   7 ||< Base-8:main_flrs
*surf,Base-8,FLOR,-,-,-,bsmt_floor,OPAQUE,BASESIMP,01,50  #   8 ||< BASESIMP config type   1
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,1,8,   110.63 0  # zone base list
