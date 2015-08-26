*Geometry 1.1,GEN,first_fl # tag version, format, zone name
*date Fri Apr  8 16:41:55 2011  # latest file modification 
first_fl describes the first floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00  #   1
*vertex,<Opt-Width>,0.0000,0.00  #   2
*vertex,<Opt-Width>,<Opt-Length>,0.00  #   3
*vertex,0.00000,<Opt-Length>,0.00  #   4
*vertex,0.00000,0.00000,2.84  #   5
*vertex,<Opt-Width>,0.0000,2.84  #   6
*vertex,<Opt-Width>,<Opt-Length>,2.84  #   7
*vertex,0.00000,<Opt-Length>,2.84  #   8
*vertex,<win-wall-1-right>,0.00000,0.5  #   9
*vertex,<win-wall-1-left>,0.00000,0.5  #  10
*vertex,<win-wall-1-left>,0.00000,1.92  #  11
*vertex,<win-wall-1-right>,0.00000,1.92  #  12
*vertex,<Opt-Width>,<win-wall-2-right>,0.5  #  13
*vertex,<Opt-Width>,<win-wall-2-left>,0.5  #  14
*vertex,<Opt-Width>,<win-wall-2-left>,1.92  #  15
*vertex,<Opt-Width>,<win-wall-2-right>,1.92  #  16
*vertex,<win-wall-3-right>,<Opt-Length>,0.5  #  17
*vertex,<win-wall-3-left>,<Opt-Length>,0.5  #  18
*vertex,<win-wall-3-left>,<Opt-Length>,1.92  #  19
*vertex,<win-wall-3-right>,<Opt-Length>,1.92  #  20
*vertex,0.00000,<win-wall-4-right>,0.5  #  21
*vertex,0.00000,<win-wall-4-left>,0.5  #  22
*vertex,0.00000,<win-wall-4-left>,1.92  #  23
*vertex,0.00000,<win-wall-4-right>,1.92  #  24
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9    #  1
*edges,10,2,3,7,6,2,13,16,15,14,13  #  2
*edges,10,3,4,8,7,3,17,20,19,18,17  #  3
*edges,10,4,1,5,8,4,21,24,23,22,21  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12   #  7
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
*surf,Top-5,CEIL,-,-,-,<Opt-Ceiling>,OPAQUE,EXTERIOR,0,0        #   5 ||< Top-5:roof-base
*surf,Base-6,FLOR,-,-,-,<Opt-ExposedFloor>,OPAQUE,EXTERIOR,0,0  #   6 ||< Base-6:Top_bsm
*surf,win-wall-1,VERT,Wall-1,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,win-wall-2,VERT,Wall-2,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   8 ||< external
*surf,win-wall-3,VERT,Wall-3,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   9 ||< external
*surf,win-wall-4,VERT,Wall-4,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #  10 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none # insolation sources
# 
*base_list,0,<Opt-Area>, 0  # zone base list