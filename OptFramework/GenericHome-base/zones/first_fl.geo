*Geometry 1.1,GEN,first_fl # tag version, format, zone name
*date Fri Apr  8 16:41:55 2011  # latest file modification 
first_fl describes the first floor
*previous_rotate 0.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,<Opt-Bsm-Height>  #   1
*vertex,<Opt-Width>,0.0000,<Opt-Bsm-Height>  #   2
*vertex,<Opt-Width>,<Opt-Length>,<Opt-Bsm-Height>  #   3
*vertex,0.00000,<Opt-Length>,<Opt-Bsm-Height>  #   4
*vertex,0.00000,0.00000,<Opt-Main-Height>  #   5
*vertex,<Opt-Width>,0.0000,<Opt-Main-Height>  #   6
*vertex,<Opt-Width>,<Opt-Length>,<Opt-Main-Height>  #   7
*vertex,0.00000,<Opt-Length>,<Opt-Main-Height>  #   8
*vertex,1.00000,0.00000,3.20000  #   9
*vertex,2.50000,0.00000,3.20000  #  10
*vertex,2.50000,0.00000,4.70000  #  11
*vertex,1.00000,0.00000,4.70000  #  12
*vertex,6.60000,1.50430,3.62309  #  13
*vertex,6.60000,2.89570,3.62309  #  14
*vertex,6.60000,2.89570,4.47691  #  15
*vertex,6.60000,1.50430,4.47691  #  16
*vertex,4.57808,4.40000,3.52715  #  17
*vertex,2.02192,4.40000,3.52715  #  18
*vertex,2.02192,4.40000,4.57285  #  19
*vertex,4.57808,4.40000,4.57285  #  20
*vertex,0.00000,2.89570,3.62309  #  21
*vertex,0.00000,1.50430,3.62309  #  22
*vertex,0.00000,1.50430,4.47691  #  23
*vertex,0.00000,2.89570,4.47691  #  24
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9  #  1
*edges,10,2,3,7,6,2,13,16,15,14,13  #  2
*edges,10,3,4,8,7,3,17,20,19,18,17  #  3
*edges,10,4,1,5,8,4,21,24,23,22,21  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
*edges,4,17,18,19,20  #  9
*edges,4,21,22,23,24  # 10
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-4,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Top-5,CEIL,-,-,-,<Opt-Ceiling>,OPAQUE,ANOTHER,03,05       #   5 ||< Top-5:roof-base
*surf,Base-6,FLOR,-,-,-,<Opt-IntFloor>,OPAQUE,ANOTHER,01,05     #   6 ||< Base-6:Top_bsm
*surf,win-wall-1,VERT,Wall-1,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #   7 ||< not yet defined
*surf,win-wall-2,VERT,Wall-2,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #   8 ||< not yet defined
*surf,win-wall-3,VERT,Wall-3,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #   9 ||< not yet defined
*surf,win-wall-4,VERT,Wall-4,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #  10 ||< not yet defined
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none # insolation sources
# 
*base_list,0,<Opt-Area>,1  # zone base list
