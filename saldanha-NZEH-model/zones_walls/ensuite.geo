*Geometry 1.1,GEN,ensuite # tag version, format, zone name
*date Mon Apr 11 15:50:29 2011  # latest file modification 
ensuite describes a the bathroom
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,5.30000,-7.00000,5.78100  #   1
*vertex,5.30000,-10.63620,5.78100  #   2
*vertex,7.30000,-10.63620,5.78100  #   3
*vertex,7.30000,-7.00000,5.78100  #   4
*vertex,5.30000,-7.00000,8.25100  #   5
*vertex,5.30000,-10.63620,8.25100  #   6
*vertex,7.30000,-10.63620,8.25100  #   7
*vertex,7.30000,-7.00000,8.25100  #   8
*vertex,6.32330,-10.63620,7.91100  #   9
*vertex,6.32330,-10.63620,6.48100  #  10
*vertex,5.50000,-10.63620,6.48100  #  11
*vertex,5.50000,-10.63620,7.91100  #  12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,6,5  #  1
*edges,10,2,3,7,6,2,11,12,9,10,11  #  2
*edges,4,3,4,8,7  #  3
*edges,4,4,1,5,8  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,11,10,9,12  #  7
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,int_wl_heavy,OPAQUE,ANOTHER,04,03  #   1 ||< Wall-3:master
*surf,Wall-2,VERT,-,-,-,ex_brk_heavy,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,int_wl_heavy,OPAQUE,ANOTHER,06,01  #   3 ||< Wall-1:bedroom
*surf,Wall-4,VERT,-,-,-,int_NS,OPAQUE,ANOTHER,07,04  #   4 ||< Wall-4:top_fl
*surf,Top-5,CEIL,-,-,-,ceil,OPAQUE,ANOTHER,08,10  #   5 ||< Top-5:roof
*surf,Base-6,FLOR,-,-,-,floor,OPAQUE,ANOTHER,03,17  #   6 ||< ensuit:first_fl
*surf,win,VERT,Wall-2,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #   7 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable   2 # list of surfs
  2  7
# 
*insol_calc,all_applicable   1 # insolation sources
  7
# 
*base_list,0,7.27,0  # zone base
# 
# block entities:
#  *obs = obstructions
*block_start, 20 20 # geometric blocks
*obs,5.300,-10.632,8.251,0.457,2.000,0.100,-90.000,1.00,new_blk,NONE  # block   1
*end_block
