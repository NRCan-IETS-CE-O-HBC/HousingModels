*Geometry 1.1,GEN,bedroom # tag version, format, zone name
*date Mon Mar  7 16:18:13 2011  # latest file modification 
bedroom describes the bedroom
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,7.30000,-5.63600,5.78100  #   1
*vertex,7.30000,-10.63620,5.78100  #   2
*vertex,12.43330,-10.63620,5.78100  #   3
*vertex,12.43330,-5.63600,5.78100  #   4
*vertex,7.30000,-5.63600,8.25100  #   5
*vertex,7.30000,-10.63620,8.25100  #   6
*vertex,12.43330,-10.63620,8.25100  #   7
*vertex,12.43330,-5.63600,8.25100  #   8
*vertex,7.30000,-7.00000,5.78100  #   9
*vertex,7.30000,-7.00000,8.25100  #  10
*vertex,11.80000,-10.63620,7.91100  #  11
*vertex,11.80000,-10.63620,6.48100  #  12
*vertex,10.23000,-10.63620,6.48100  #  13
*vertex,10.23000,-10.63620,7.91100  #  14
*vertex,8.65900,-10.63620,6.48100  #  15
*vertex,8.65900,-10.63620,7.91100  #  16
# 
# tag, number of vertices followed by list of associated vert
*edges,4,9,2,6,10  #  1
*edges,12,2,15,16,14,11,12,13,15,2,3,7,6  #  2
*edges,4,3,4,8,7  #  3
*edges,4,4,1,5,8  #  4
*edges,5,5,10,6,7,8  #  5
*edges,5,1,4,3,2,9  #  6
*edges,4,1,9,10,5  #  7
*edges,4,13,12,11,14  #  8
*edges,4,15,13,14,16 #  9
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,05,03  #   1 ||< Wall-3:ensuite
*surf,Wall-2,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-4,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,07,06  #   4 ||< Wall-6:top_fl
*surf,Top-5,CEIL,-,-,-,<Opt-Ceiling>,OPAQUE,ANOTHER,08,11  #   5 ||< Top-6:roof
*surf,Base-6,FLOR,-,-,-,floor,OPAQUE,ANOTHER,03,16  #   6 ||< bedrom:first_fl
*surf,Wall-7,VERT,-,-,-,int_wl,OPAQUE,ANOTHER,07,05  #   7 ||< Wall-5:top_fl
*surf,win1,VERT,Wall-2,-,-,<OptBedroomExWin1Con>,<OptBedroomExWin1Opt>,EXTERIOR,0,0  #   8 ||< external
*surf,win2,VERT,Wall-2,-,-,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #   9 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable   4 # list of surfs
  2  3  8  9
# 
*insol_calc,all_applicable   2 # insolation sources
  8 9
# 
*base_list,0,25.67,0  # zone base
# 
# block entities:
#  *obs = obstructions
*block_start, 20 20 # geometric blocks
*obs,7.300,-10.636,8.251,0.457,5.133,0.100,-90.000,1.00,new_blk,NONE  # block   1
*obs,12.433,-8.593,8.251,2.500,0.457,0.100,-90.000,1.00,new_blk1,NONE  # block   2
*end_block
