*Geometry 1.1,GEN,basement # tag version, format, zone name
*date Mon Dec  7 13:11:26 2009  # latest file modification 
basement describes the basement not including the area below the
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00000  #   1
*vertex,0.00000,-12.00000,0.00000  #   2
*vertex,6.79000,-12.00000,0.00000  #   3
*vertex,6.79000,-4.97000,0.00000  #   4
*vertex,12.20000,-4.97000,0.00000  #   5
*vertex,12.20000,0.00000,0.00000  #   6
*vertex,0.00000,0.00000,2.60000  #   7
*vertex,0.00000,-12.00000,2.60000  #   8
*vertex,6.79000,-12.00000,2.60000  #   9
*vertex,6.79000,-4.97000,2.60000  #  10
*vertex,12.20000,-4.97000,2.60000  #  11
*vertex,12.20000,0.00000,2.60000  #  12
*vertex,0.00000,-4.83000,2.60000  #  13
*vertex,2.27000,-4.83000,0.00000  #  14
*vertex,2.27000,-4.83000,2.60000  #  15
*vertex,2.27000,-7.25000,2.60000  #  16
*vertex,0.00000,-7.25000,2.60000  #  17
*vertex,0.00000,-4.83000,0.00000  #  18
*vertex,0.00000,-7.25000,0.00000  #  19
*vertex,2.27000,-7.25000,0.00000  #  20
# 
# tag, number of vertices followed by list of associated vert
*edges,4,3,4,10,9  #  1
*edges,4,4,5,11,10  #  2
*edges,4,5,6,12,11  #  3
*edges,10,7,13,15,16,17,8,9,10,11,12  #  4
*edges,10,1,6,5,4,3,2,19,20,14,18  #  5
*edges,4,13,18,14,15  #  6
*edges,4,16,15,14,20  #  7
*edges,4,17,16,20,19  #  8
*edges,4,19,2,8,17  #  9
*edges,4,1,18,13,7  # 10
*edges,4,2,3,9,8  # 11
*edges,4,6,1,7,12  # 12
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,found_lft2,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   1 ||< BASESIMP config type   1
*surf,found_frnt2,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   2 ||< BASESIMP config type   1
*surf,found_lft1,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   3 ||< BASESIMP config type   1
*surf,bsment_ceiln,CEIL,-,-,-,floors_r,OPAQUE,ANOTHER,03,19  #   4 ||< main_floor:mainfloor
*surf,bsment_floor,FLOR,-,-,-,slab_floor,OPAQUE,BASESIMP,01,30  #   5 ||< BASESIMP config type   1
*surf,stair_north,VERT,-,-,-,int_partitn,OPAQUE,ANOTHER,05,04  #   6 ||< bsm_north:stairwell
*surf,stair_east,VERT,-,-,-,fictitious,SC_fictit,ANOTHER,05,03  #   7 ||< bsm_east:stairwell
*surf,stair_south,VERT,-,-,-,int_partitn,OPAQUE,ANOTHER,05,02  #   8 ||< bsm_south:stairwell
*surf,found_rgt2,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #   9 ||< BASESIMP config type   1
*surf,found_rgt1,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #  10 ||< BASESIMP config type   1
*surf,found_frnt1,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #  11 ||< BASESIMP config type   1
*surf,found_back,VERT,-,-,-,foundation_,OPAQUE,BASESIMP,01,10  #  12 ||< BASESIMP config type   1
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,1,5,   102.87 0  # zone base list
