*Geometry 1.1,GEN,main_flrs # tag version, format, zone name
*date Wed Jun 23 08:52:14 2010  # latest file modification 
main_flrs describes the main two floors of CCHT house
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00000  #   1
*vertex,6.79000,0.00000,0.00000  #   2
*vertex,6.79000,6.81500,0.00000  #   3
*vertex,12.20000,6.81501,0.00000  #   4
*vertex,12.20000,12.09000,0.00000  #   5
*vertex,0.00000,12.09000,0.00000  #   6
*vertex,0.00000,0.00000,5.48500  #   7
*vertex,8.74000,0.00000,5.48500  #   8
*vertex,8.74000,3.67000,5.48500  #   9
*vertex,12.20000,3.67000,5.48500  #  10
*vertex,8.74000,12.09000,5.48500  #  11
*vertex,0.00000,12.09000,5.48500  #  12
*vertex,6.79000,6.81500,2.77000  #  13
*vertex,12.20000,6.81501,2.77000  #  14
*vertex,6.79000,0.00000,2.77000  #  15
*vertex,12.20000,12.09000,2.77000  #  16
*vertex,8.74000,0.00000,2.77000  #  17
*vertex,8.74000,3.67000,2.77000  #  18
*vertex,12.20000,3.67000,2.77000  #  19
*vertex,12.20000,8.42000,2.77000  #  20
*vertex,12.20000,8.42000,5.48500  #  21
*vertex,8.74000,8.42000,2.77000  #  22
*vertex,8.74000,8.42000,5.48500  #  23
*vertex,8.74000,12.09000,2.77000  #  24
*vertex,0.00001,9.09,2 # 25
*vertex,0.00001,8.09,2 # 26
*vertex,0.00001,8.09,3.562 # 27
*vertex,0.00001,9.09,3.562 # 28
*vertex,8.20000,12.09000,2.00000  #  29
*vertex,4.41300,12.09000,2.00000  #  30
*vertex,4.41300,12.09000,4.00000  #  31
*vertex,8.20000,12.09000,4.00000  #  32
*vertex,2,0,2.997 # 33
*vertex,6,0,2.997 # 34
*vertex,6,0,4.747 # 35
*vertex,2,0,4.747 # 36
*vertex,12.20000,7.81501,0.50000  #  37
*vertex,12.20000,8.81500,0.50000  #  38
*vertex,12.20000,8.81500,2.65300  #  39
*vertex,12.20000,7.81501,2.65300  #  40
*vertex,2.725,0,0.75 # 41
*vertex,5.275,0,0.75 # 42
*vertex,5.275,0,2.5 # 43
*vertex,2.725,0,2.5 # 44
# 
# tag, number of vertices followed by list of associated vert
*edges,18,1,2,15,17,8,7,1,41,44,43,42,41,1,33,36,35,34,33  #  1
*edges,11,4,5,16,20,14,4,37,40,39,38,37  #  2
*edges,12,5,6,12,11,24,16,5,29,32,31,30,29  #  3
*edges,10,6,1,7,12,6,25,28,27,26,25  #  4
*edges,8,7,8,9,10,21,23,11,12  #  5
*edges,4,3,4,14,13  #  6
*edges,4,2,3,13,15  #  7
*edges,4,17,18,9,8  #  8
*edges,4,18,19,10,9  #  9
*edges,4,20,22,23,21  # 10
*edges,6,17,15,13,14,19,18  # 11
*edges,5,19,14,20,21,10  # 12
*edges,4,22,24,11,23  # 13
*edges,4,16,24,22,20  # 14
*edges,6,2,1,6,5,4,3  # 15
*edges,4,25,26,27,28  # 16
*edges,4,29,30,31,32  # 17
*edges,4,33,34,35,36  # 18
*edges,4,37,38,39,40  # 19
*edges,4,41,42,43,44  # 20
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,win_s,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-4,VERT,-,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-5,VERT,-,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-6,VERT,Wall-1,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Top-7,CEIL,-,-,-,main_ceiling,OPAQUE,ANOTHER,03,08  #   5 ||< Top-7:attic
*surf,Wall-3,VERT,-,-,-,ext_wall,OPAQUE,ANOTHER,02,03  #   6 ||< Wall-3:garage
*surf,Wall-20,VERT,-,-,-,ext_wall,OPAQUE,ANOTHER,02,04  #   7 ||< Wall-4:garage
*surf,Wall-9,VERT,-,-,-,ext_wall,OPAQUE,ANOTHER,03,10  #   8 ||< Wall-11:attic
*surf,Wall-10,VERT,-,-,-,ext_wall,OPAQUE,ANOTHER,03,11  #   9 ||< Wall-12:attic
*surf,Wall-11,VERT,-,-,-,ext_wall,OPAQUE,ANOTHER,03,15  #  10 ||< Wall-16:attic
*surf,Top-13,FLOR,-,-,-,main_floor,OPAQUE,ANOTHER,02,06  #  11 ||< Top-13:garage
*surf,Wall-14,VERT,-,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #  12 ||< external
*surf,Surf-15,VERT,-,-,-,ext_wall,OPAQUE,ANOTHER,03,14  #  13 ||< Wall-15:attic
*surf,Top-16,CEIL,-,-,-,main_ceiling,OPAQUE,ANOTHER,03,16  #  14 ||< Base-17:attic
*surf,Base-8,FLOR,-,-,-,main_floor,OPAQUE,ANOTHER,01,07  #  15 ||< Top-7:basement
*surf,win_w,VERT,Wall-6,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  16 ||< external
*surf,win_n,VERT,Wall-5,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  17 ||< external
*surf,win_s,VERT,Wall-1,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  18 ||< external
*surf,win_e,VERT,Wall-4,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  19 ||< external
*surf,win_s_bot,VERT,Wall-1,-,-,DblArLowe,DBLLowE,EXTERIOR,0,0  #  20 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable  10 # list of surfs
  1  2  3  4 12 16 17 18 19 20
# 
*insol_calc,all_applicable   5 # insolation sources
 16 17 18 19 20
# 
*base_list,3,7,11,15,   153.68 0  # zone base list
# 
# block entities:
#  *obs = obstructions
*block_start,20 20 # geometric blocks
*obsp,8,6,south_bot,NONE  # block  1 coords follow:
1.975,-1.167,2.9375,6.025,-1.167,2.9375,6.025,0,2.9375,1.975,0,2.9375 # 1-4
1.975,-1.167,2.9575,6.025,-1.167,2.9575,6.025,0,2.9575,1.975,0,2.9575 # 5-8
*obsp,8,6,south_top,NONE  # block  2 coords follow:
1.25,-1.167,5.1845,6.75,-1.167,5.1845,6.75,0,5.1845,1.25,0,5.1845 # 1-4
1.25,-1.167,5.2045,6.75,-1.167,5.2045,6.75,0,5.2045,1.25,0,5.2045 # 5-8
*obsp,8,6,west,NONE  # block  3 coords follow:
-0.0432912701892219,9.59,3.9745,-0.0432912701892219,7.59,3.9745,0.00001,7.59,3.9995,0.00001,9.59,3.9995 # 1-4
-0.0432912701892219,9.59,3.9945,-0.0432912701892219,7.59,3.9945,0.00001,7.59,4.0195,0.00001,9.59,4.0195 # 5-8
*end_block
