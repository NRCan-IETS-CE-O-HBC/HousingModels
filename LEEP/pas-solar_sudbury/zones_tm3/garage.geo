*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Wed Jan 19 14:49:02 2011  # latest file modification 
garage describes a car hall
*previous_rotate  90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,2.26480  #   1
*vertex,6.40000,0.00000,2.26480  #   2
*vertex,6.40000,6.70000,2.26480  #   3
*vertex,-0.00000,6.70000,2.26480  #   4
*vertex,0.00000,0.00000,4.72480  #   5
*vertex,6.40000,0.00000,4.72480  #   6
*vertex,6.40000,6.70000,4.72480  #   7
*vertex,-0.00000,6.70000,4.72480  #   8
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
*surf,grg_s,VERT,-,-,-,Sdb_grg_C_IN,OPAQUE,ANOTHER,01,33  #   1 ||< grg_connect:main_flr
*surf,grg_e,VERT,-,-,-,Sdb_grg_ext,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,grg_n,VERT,-,-,-,Sdb_grg_ext,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,grg_w,VERT,-,-,-,Sdb_grg_ext,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,grg_cl,CEIL,-,-,-,Sdb_grg_ceil,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,grg_fl,FLOR,-,-,-,bsmt_floor,OPAQUE,BASESIMP,**,29  #   6 ||< BASESIMP config type  29
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable   4 # list of surfs
  2  3  4  5
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,42.88,0  # zone base
# 
# block entities:
#  *obs = obstructions
*block_start, 20 20 # geometric blocks
*obs,-0.000,6.700,4.725,6.700,6.400,0.100,270.000,1.00,garage_shd,NONE  # block   1
*end_block
