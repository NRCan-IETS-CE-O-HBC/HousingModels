*Geometry 1.1,GEN,master # tag version, format, zone name
*date Thu Apr 14 11:40:34 2011  # latest file modification 
master describes the master bedroom
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,-0.00000,-4.50000,5.78100  #   1
*vertex,-0.00000,-10.63620,5.78100  #   2
*vertex,5.30000,-10.63620,5.78100  #   3
*vertex,5.30000,-7.00000,5.78100  #   4
*vertex,4.89610,-7.00000,5.78100  #   5
*vertex,4.89610,-4.50000,5.78100  #   6
*vertex,-0.00000,-4.50000,8.25100  #   7
*vertex,-0.00000,-10.63620,8.25100  #   8
*vertex,5.30000,-10.63620,8.25100  #   9
*vertex,5.30000,-7.00000,8.25100  #  10
*vertex,4.89610,-7.00000,8.25100  #  11
*vertex,4.89610,-4.50000,8.25100  #  12
*vertex,-0.00000,-6.52300,5.78100  #  13
*vertex,4.89610,-6.52300,5.78100  #  14
*vertex,2.66330,-10.63620,7.91100  #  15
*vertex,2.66330,-10.63620,6.48100  #  16
*vertex,1.23330,-10.63620,6.48100  #  17
*vertex,1.23330,-10.63620,7.91100  #  18
# 
# tag, number of vertices followed by list of associated vert
*edges,5,1,13,2,8,7  #  1
*edges,10,2,3,9,8,2,17,18,15,16,17  #  2
*edges,4,3,4,10,9  #  3
*edges,4,4,5,11,10  #  4
*edges,5,5,14,6,12,11  #  5
*edges,4,6,1,7,12  #  6
*edges,6,7,8,9,10,11,12  #  7
*edges,6,13,14,5,4,3,2  #  8
*edges,4,1,6,14,13  #  9
*edges,4,17,16,15,18  # 10
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,05,01  #   3 ||< Wall-1:ensuite
*surf,Wall-4,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,07,13  #   4 ||< Wall-13:top_fl
*surf,Wall-5,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,07,03  #   5 ||< Wall-3:top_fl
*surf,Wall-6,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,07,02  #   6 ||< Wall-2:top_fl
*surf,Top-7,CEIL,-,-,-,ceil_hv,OPAQUE,ANOTHER,08,09  #   7 ||< Top-7:roof
*surf,Base-8,FLOR,-,-,-,floor_hv,OPAQUE,ANOTHER,03,18  #   8 ||< Base-8:first_fl
*surf,Base-9,FLOR,-,-,-,gr_ceil_inv,OPAQUE,ANOTHER,02,09  #   9 ||< Top-9:garage
*surf,win,VERT,Wall-2,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  10 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable   3 # list of surfs
  1  2 10
# 
*insol_calc,all_applicable   1 # insolation sources
 10
# 
*base_list,0,31.51,0  # zone base
# 
# block entities:
#  *obs = obstructions
*block_start, 20 20 # geometric blocks
*obs3,-0.000,-10.632,8.251,0.457,5.300,0.100,-90.000,0.000,0.000,1.00,new_blk,NONE  # block   1
*obs,-0.457,-8.589,8.251,2.500,0.457,0.100,-90.000,1.00,new_blk2,NONE  # block   2
*end_block
