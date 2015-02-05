*Geometry 1.1,GEN,first_fl # tag version, format, zone name
*date Thu Feb  5 14:17:37 2015  # latest file modification 
first_fl describes the first floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,6.60000,6.60400,2.43840  #   1
*vertex,6.60000,9.35000,2.43840  #   2
*vertex,0.00000,9.35000,2.43840  #   3
*vertex,0.00000,6.60400,2.43840  #   4
*vertex,6.60000,6.60400,5.15240  #   5
*vertex,6.60000,9.35000,5.15240  #   6
*vertex,0.00000,9.35000,5.15240  #   7
*vertex,0.00000,6.60400,5.15240  #   8
*vertex,6.10400,9.35000,2.93840  #   9
*vertex,3.06600,9.35000,2.93840  #  10
*vertex,3.06600,9.35000,4.46240  #  11
*vertex,6.10400,9.35000,4.46240  #  12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,4,1,5,8  #  1
*edges,4,1,2,6,5  #  2
*edges,10,2,3,7,6,2,9,12,11,10,9  #  3
*edges,4,3,4,8,7  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12  #  7
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1-1,VERT,-,-,-,BaseR20Dry,OPAQUE,ANOTHER,05,03  #   1 ||< Wall-3-gar:garage
*surf,Wall-1-2,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-1-3,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-1-4,VERT,-,-,-,int_wl,OPAQUE,ADIABATIC,0,0  #   4 ||< adiabatic
*surf,Top-1st,CEIL,-,-,-,floor_inv,OPAQUE,ANOTHER,02,06  #   5 ||< Base-2nd:second_fl
*surf,Base-1st,FLOR,-,-,-,BsmFlrR0,OPAQUE,BASESIMP,28,100  #   6 ||< BASESIMP config type   1
*surf,win-wall-1-3,VERT,Wall-1-3,-,-,DblClr,DblClr,EXTERIOR,0,0  #   7 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,61.76,0  # zone base
