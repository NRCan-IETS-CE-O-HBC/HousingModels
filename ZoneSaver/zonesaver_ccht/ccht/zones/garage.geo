*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Mon Dec  7 13:11:26 2009  # latest file modification 
garage describes the garage with slab on grade floor, exterior s
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,6.79000,-4.97000,2.60000  #   1
*vertex,6.79000,-12.00000,2.60000  #   2
*vertex,12.20000,-12.00000,2.60000  #   3
*vertex,12.20000,-4.97000,2.60000  #   4
*vertex,6.79000,-4.97000,5.62000  #   5
*vertex,6.79000,-12.00000,5.62000  #   6
*vertex,12.20000,-12.00000,5.62000  #   7
*vertex,12.20000,-4.97000,5.62000  #   8
*vertex,7.07000,-12.00000,2.60000  #   9
*vertex,12.05000,-12.00000,2.60000  #  10
*vertex,12.05000,-12.00000,4.60000  #  11
*vertex,7.07000,-12.00000,4.60000  #  12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,6,5  #  1
*edges,8,2,9,12,11,10,3,7,6  #  2
*edges,4,3,4,8,7  #  3
*edges,4,4,1,5,8  #  4
*edges,4,5,6,7,8  #  5
*edges,6,1,4,3,10,9,2  #  6
*edges,4,9,10,11,12  #  7
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,main_share,VERT,-,-,-,ccht_wall_r,OPAQUE,ANOTHER,03,03  #   1 ||< garage_share:mainfloor
*surf,front_garage,VERT,-,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,side_wall,VERT,-,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,garage_back,VERT,-,-,-,ccht_wall_r,OPAQUE,ANOTHER,03,04  #   4 ||< garage_back:mainfloor
*surf,garage_ceiln,CEIL,-,-,-,exp_flr,OPAQUE,ANOTHER,04,17  #   5 ||< flr_abv_gar:secondfloor
*surf,slab-on-grad,FLOR,-,-,-,slab_floor,OPAQUE,BASESIMP,28,**  #   6 ||< BASESIMP config type  28
*surf,garage_door,VERT,-,-,-,ext_doors,OPAQUE,EXTERIOR,0,0  #   7 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,1,6,    38.03 0  # zone base list
