*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Thu Feb  5 14:17:37 2015  # latest file modification 
garage describes the inset garage
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,2.43840  #   1
*vertex,6.60000,0.00000,2.43840  #   2
*vertex,6.60000,6.60400,2.43840  #   3
*vertex,0.00000,6.60400,2.43840  #   4
*vertex,0.00000,0.00000,5.15840  #   5
*vertex,6.60000,0.00000,5.15840  #   6
*vertex,6.60000,6.60400,5.15840  #   7
*vertex,0.00000,6.60400,5.15840  #   8
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,6,5  #  1
*edges,4,2,3,7,6  #  2
*edges,4,3,4,8,7  #  3
*edges,4,4,1,5,8  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1-gar,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2-gar,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3-gar,VERT,-,-,-,BaseR20DryR,OPAQUE,ANOTHER,01,01  #   3 ||< Wall-1-1:first_fl
*surf,Wall-4-gar,VERT,-,-,-,ex_brk,OPAQUE,ADIABATIC,0,0  #   4 ||< adiabatic
*surf,top-gar,CEIL,-,-,-,ExpFlR31,OPAQUE,ANOTHER,02,11  #   5 ||< garage_ceil:second_fl
*surf,slab-gar,FLOR,-,-,-,grg_slab,OPAQUE,BASESIMP,29,100  #   6 ||< BASESIMP config type  28
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,39.23,0  # zone base
