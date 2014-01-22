*Geometry 1.1,GEN,top_fl # tag version, format, zone name
*date Mon Apr 11 15:51:19 2011  # latest file modification 
top_fl describes the top floor
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,5.78100  #   1
*vertex,-0.00000,-4.50000,5.78100  #   2
*vertex,4.89600,-4.50000,5.78100  #   3
*vertex,4.89600,-7.00000,5.78100  #   4
*vertex,7.30000,-7.00000,5.78100  #   5
*vertex,7.30000,-5.63600,5.78100  #   6
*vertex,12.43300,-5.63600,5.78100  #   7
*vertex,12.43300,1.21920,5.78100  #   8
*vertex,8.66800,1.21920,5.78100  #   9
*vertex,8.66800,-0.00000,5.78100  #  10
*vertex,0.00000,0.00000,8.25100  #  11
*vertex,-0.00000,-4.50000,8.25100  #  12
*vertex,4.89600,-4.50000,8.25100  #  13
*vertex,4.89600,-7.00000,8.25100  #  14
*vertex,7.30000,-7.00000,8.25100  #  15
*vertex,7.30000,-5.63600,8.25100  #  16
*vertex,12.43300,-5.63600,8.25100  #  17
*vertex,12.43300,1.21920,8.25100  #  18
*vertex,8.66800,1.21920,8.25100  #  19
*vertex,8.66800,-0.00000,8.25100  #  20
*vertex,5.30000,-7.00000,5.78100  #  21
*vertex,5.30000,-7.00000,8.25100  #  22
*vertex,4.89600,-0.00000,5.78100  #  23
*vertex,10.48503,1.21920,6.48100  #  24
*vertex,9.77000,1.21920,6.48100  #  25
*vertex,10.48503,1.21920,7.91100  #  26
*vertex,9.77000,1.21920,7.91100  #  27
*vertex,3.68846,-0.00000,6.48100  #  28
*vertex,2.00000,-0.00000,6.48100  #  29
*vertex,3.68846,-0.00000,7.91100  #  30
*vertex,2.00000,-0.00000,7.91100  #  31
*vertex,12.43300,-5.00000,6.89600  #  32
*vertex,12.43300,-5.00000,7.91100  #  33
*vertex,12.43300,-4.17700,6.89600  #  34
*vertex,12.43300,-4.17700,7.91100  #  35
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,12,11  #  1
*edges,4,2,3,13,12  #  2
*edges,4,3,4,14,13  #  3
*edges,4,21,5,15,22  #  4
*edges,4,5,6,16,15  #  5
*edges,4,6,7,17,16  #  6
*edges,10,7,8,18,17,7,32,33,35,34,32  #  7
*edges,10,8,9,19,18,8,24,26,27,25,24  #  8
*edges,4,9,10,20,19  #  9
*edges,11,10,23,1,11,20,10,28,30,31,29,28  # 10
*edges,11,11,12,13,14,22,15,16,17,18,19,20  # 11
*edges,10,23,10,9,8,7,6,5,21,4,3  # 12
*edges,4,4,21,22,14  # 13
*edges,4,1,23,3,2  # 14
*edges,4,24,25,27,26  # 15
*edges,4,28,29,31,30  # 16
*edges,4,32,34,35,33  # 17
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,int_NS_inv,OPAQUE,ANOTHER,04,06  #   2 ||< Wall-6:master
*surf,Wall-3,VERT,-,-,-,int_NS_inv,OPAQUE,ANOTHER,04,05  #   3 ||< Wall-5:master
*surf,Wall-4,VERT,-,-,-,int_NS_inv,OPAQUE,ANOTHER,05,04  #   4 ||< Wall-4:ensuite
*surf,Wall-5,VERT,-,-,-,int_NS_inv,OPAQUE,ANOTHER,06,07  #   5 ||< Wall-7:bedroom
*surf,Wall-6,VERT,-,-,-,int_NS_inv,OPAQUE,ANOTHER,06,04  #   6 ||< Wall-4:bedroom
*surf,Wall-7,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,Wall-8,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   8 ||< external
*surf,Wall-9,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   9 ||< external
*surf,Wall-10,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #  10 ||< external
*surf,Top-11,CEIL,-,-,-,ceil,OPAQUE,ANOTHER,08,08  #  11 ||< Top-11:roof
*surf,Base-12,FLOR,-,-,-,floor,OPAQUE,ANOTHER,03,19  #  12 ||< Base-12:first_fl
*surf,Wall-13,VERT,-,-,-,int_NS_inv,OPAQUE,ANOTHER,04,04  #  13 ||< Wall-4:master
*surf,Base-14,FLOR,-,-,-,gr_ceil_inv,OPAQUE,ANOTHER,02,05  #  14 ||< Top-5:garage
*surf,win1,VERT,Wall-8,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  15 ||< external
*surf,win2,VERT,Wall-10,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  16 ||< external
*surf,win3,VERT,Wall-7,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  17 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable   8 # list of surfs
  1  7  8  9 10 15 16 17
# 
*insol_calc,all_applicable   3 # insolation sources
 15 16 17
# 
*base_list,0,72.38,0  # zone base
# 
# block entities:
#  *obs = obstructions
*block_start, 20 20 # geometric blocks
*obs,8.668,1.673,8.251,0.457,1.000,0.100,-90.000,1.00,new_blk,NONE  # block   1
*obs,0.000,0.454,8.251,0.457,8.668,0.100,-90.000,1.00,new_blk1,NONE  # block   2
*obs,11.433,1.673,8.251,0.457,1.000,0.100,-90.000,1.00,new_blk2,NONE  # block   3
*obs,8.211,1.673,8.251,1.216,0.457,0.100,-90.000,1.00,new_blk3,NONE  # block   4
*obs,12.433,1.673,8.251,2.500,0.457,0.100,-90.000,1.00,new_blk4,NONE  # block   5
*obs,-0.457,0.457,8.251,2.500,0.457,0.100,-90.000,1.00,new_blk5,NONE  # block   6
*end_block
