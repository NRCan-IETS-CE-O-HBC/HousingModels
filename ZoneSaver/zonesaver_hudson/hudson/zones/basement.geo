*Geometry 1.1,GEN,basement # tag version, format, zone name
*date Fri Apr 15 10:10:19 2011  # latest file modification 
basement describes a
*previous_rotate -45.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,2.58801,2.58801,0.00000  #   1
*vertex,6.25082,-1.07480,0.00000  #   2
*vertex,3.66281,-3.66281,0.00000  #   3
*vertex,5.38815,-5.38815,0.00000  #   4
*vertex,14.01486,3.23855,0.00000  #   5
*vertex,8.62670,8.62670,0.00000  #   6
*vertex,2.58801,2.58801,2.60000  #   7
*vertex,6.25082,-1.07480,2.60000  #   8
*vertex,3.66281,-3.66281,2.60000  #   9
*vertex,5.38815,-5.38815,2.60000  #  10
*vertex,14.01486,3.23855,2.60000  #  11
*vertex,8.62670,8.62670,2.60000  #  12
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
*surf,Wall-1,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   1 ||< BASESIMP config type   1
*surf,Wall-2,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   2 ||< BASESIMP config type   1
*surf,Wall-3,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   3 ||< BASESIMP config type   1
*surf,Wall-4,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,15  #   4 ||< BASESIMP config type   1
*surf,Wall-5,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   5 ||< BASESIMP config type   1
*surf,Wall-6,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,15  #   6 ||< BASESIMP config type   1
*surf,Top-7,CEIL,-,-,-,floors,OPAQUE,ANOTHER,02,06  #   7 ||< Base-8:main
*surf,Base-8,FLOR,-,-,-,slab_floor,OPAQUE,BASESIMP,01,30  #   8 ||< BASESIMP config type   1
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,74.01,0  # zone base
