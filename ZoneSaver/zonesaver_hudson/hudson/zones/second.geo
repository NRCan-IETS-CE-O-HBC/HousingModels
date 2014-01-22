*Geometry 1.1,GEN,second # tag version, format, zone name
*date Fri Apr 15 10:12:13 2011  # latest file modification 
second describes a
*previous_rotate -45.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,-0.70711,-0.70711,5.60000  #   1
*vertex,4.68105,-6.09526,5.60000  #   2
*vertex,11.75211,0.97581,5.60000  #   3
*vertex,6.36396,6.36396,5.60000  #   4
*vertex,-0.70711,-0.70711,8.60000  #   5
*vertex,4.68105,-6.09526,8.60000  #   6
*vertex,11.75211,0.97581,8.60000  #   7
*vertex,6.36396,6.36396,8.60000  #   8
*vertex,9.05804,3.66988,8.60000  #   9
*vertex,3.66281,-3.66281,5.60000  #  10
*vertex,2.95571,-4.36992,5.60000  #  11
*vertex,2.58801,2.58801,5.60000  #  12
*vertex,5.38815,-5.38815,5.60000  #  13
*vertex,6.25082,-1.07480,5.60000  #  14
*vertex,0.70711,-2.12132,6.60000  #  15
*vertex,3.07591,-4.49013,6.60000  #  16
*vertex,3.07591,-4.49013,7.60000  #  17
*vertex,0.70711,-2.12132,7.60000  #  18
*vertex,11.66726,1.06066,6.75000  #  19
*vertex,10.81873,1.90919,6.75000  #  20
*vertex,10.81873,1.90919,7.75000  #  21
*vertex,11.66726,1.06066,7.75000  #  22
*vertex,7.31855,5.40937,6.75000  #  23
*vertex,6.47003,6.25789,6.75000  #  24
*vertex,6.47003,6.25789,7.75000  #  25
*vertex,7.31855,5.40937,7.75000  #  26
# 
# tag, number of vertices followed by list of associated vert
*edges,11,1,11,2,6,5,1,15,18,17,16,15  #  1
*edges,5,2,13,3,7,6  #  2
*edges,5,4,12,1,5,8  #  3
*edges,5,5,6,7,9,8  #  4
*edges,3,3,4,9  #  5
*edges,9,8,9,4,8,23,26,25,24,23  #  6
*edges,9,3,9,7,3,19,22,21,20,19  #  7
*edges,4,11,10,13,2  #  8
*edges,5,1,12,14,10,11  #  9
*edges,6,12,4,3,13,10,14  # 10
*edges,4,15,16,17,18  # 11
*edges,4,19,20,21,22  # 12
*edges,4,23,24,25,26  # 13
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-4,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Top-5,CEIL,-,-,-,R40_ceiling,OPAQUE,ANOTHER,05,01  #   4 ||< Base-6:attic
*surf,Wall-6,VERT,Wall-8,-,-,int_partitn,OPAQUE,ANOTHER,02,11  #   5 ||< Wall-9:main
*surf,Wall-7,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   6 ||< external
*surf,Wall-8,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,Base-10,FLOR,-,-,-,R40_ceiling,OPAQUE,EXTERIOR,0,0  #   8 ||< external
*surf,Base-9,FLOR,-,-,-,R40_ceiling,OPAQUE,ANOTHER,04,06  #   9 ||< Top-7:garage
*surf,Base-8,FLOR,-,-,-,floors_r,OPAQUE,ANOTHER,02,07  #  10 ||< Top-7:main
*surf,Window1,VERT,Wall-1,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  11 ||< external
*surf,Window2,VERT,Wall-8,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  12 ||< external
*surf,Window3,VERT,Wall-7,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  13 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable   9 # list of surfs
  1  2  3  6  7  8 11 12 13
# 
*insol_calc,all_applicable   3 # insolation sources
 11 12 13
# 
*base_list,0,76.20,0  # zone base
# 
# block entities:
#  *obs = obstructions
*block_start,20 20 # geometric blocks
*obsp,8,6,one,ccht_wall  # block  1 coords follow:
-1.273,-0.707,8.600,4.681,-6.661,8.600,4.964,-6.378,8.600,-0.990,-0.424,8.600  # 1-4 
-1.273,-0.707,8.700,4.681,-6.661,8.700,4.964,-6.378,8.700,-0.990,-0.424,8.700  # 5-8 
*obsp,8,6,two,ccht_wall  # block  2 coords follow:
-0.990,-0.424,8.600,-0.707,-0.707,8.600,6.364,6.364,8.600,6.081,6.647,8.600  # 1-4 
-0.990,-0.424,8.700,-0.707,-0.707,8.700,6.364,6.364,8.700,6.081,6.647,8.700  # 5-8 
*obsp,8,6,three,ccht_wall  # block  3 coords follow:
4.681,-6.095,8.600,4.964,-6.378,8.600,12.035,0.693,8.600,11.752,0.976,8.600  # 1-4 
4.681,-6.095,8.700,4.964,-6.378,8.700,12.035,0.693,8.700,11.752,0.976,8.700  # 5-8 
*obsp,8,6,four,ccht_wall  # block  4 coords follow:
6.081,6.647,8.600,12.035,0.693,8.600,12.318,0.976,8.600,6.364,6.930,8.600  # 1-4 
6.081,6.647,8.700,12.035,0.693,8.700,12.318,0.976,8.700,6.364,6.930,8.700  # 5-8 
*end_block
