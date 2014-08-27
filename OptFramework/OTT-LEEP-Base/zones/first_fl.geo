*Geometry 1.1,GEN,first_fl # tag version, format, zone name
*date Fri Apr  8 16:41:55 2011  # latest file modification 
first_fl describes the first floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,2.4384  #   1
*vertex,<Opt-Width>,0.0000,2.4384  #   2
*vertex,<Opt-Width>,<Opt-Length>,2.4384  #   3
*vertex,0.00000,<Opt-Length>,2.4384  #   4
*vertex,0.00000,0.00000,5.4864  #   5
*vertex,<Opt-Width>,0.0000,5.4864  #   6
*vertex,<Opt-Width>,<Opt-Length>,5.4864  #   7
*vertex,0.00000,<Opt-Length>,5.4864  #   8
*vertex,<win-wall-1-right>,0.00000,2.9384  #   9
*vertex,<win-wall-1-left>,0.00000,2.9384  #  10
*vertex,<win-wall-1-left>,0.00000,4.4624  #  11
*vertex,<win-wall-1-right>,0.00000,4.4624  #  12
*vertex,<Opt-Width>,<win-wall-2-right>,2.9384  #  13
*vertex,<Opt-Width>,<win-wall-2-left>,2.9384  #  14
*vertex,<Opt-Width>,<win-wall-2-left>,4.4624  #  15
*vertex,<Opt-Width>,<win-wall-2-right>,4.4624  #  16
*vertex,<win-wall-3-right>,<Opt-Length>,2.9384  #  17
*vertex,<win-wall-3-left>,<Opt-Length>,2.9384  #  18
*vertex,<win-wall-3-left>,<Opt-Length>,4.4624  #  19
*vertex,<win-wall-3-right>,<Opt-Length>,4.4624  #  20
*vertex,0.00000,<win-wall-4-right>,2.9384  #  21
*vertex,0.00000,<win-wall-4-left>,2.9384  #  22
*vertex,0.00000,<win-wall-4-left>,4.4624  #  23
*vertex,0.00000,<win-wall-4-right>,4.4624  #  24
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
*surf,Wall-1-1,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-1-2,VERT,-,-,-,<OptAtt-Wall2Con>,<OptAtt-Wall2Opt>,<OptAtt-Wall2BC>,0,0  #   2 ||< external
*surf,Wall-1-3,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-1-4,VERT,-,-,-,<OptAtt-Wall4Con>,<OptAtt-Wall4Opt>,<OptAtt-Wall4BC>,0,0  #   4 ||< external
*surf,Top-1st,CEIL,-,-,-,<Opt-IntFloorInv>,OPAQUE,ANOTHER,03,06       #   5 ||< Top-1st:Base-2nd
*surf,Base-1st,FLOR,-,-,-,<Opt-IntFloor>,OPAQUE,ANOTHER,01,05     #   6 ||< Base-1st:Top_bsm
*surf,win-wall-1-1,VERT,Wall-1-1,-,-,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #   7 ||< external
*surf,win-wall-1-2,VERT,Wall-1-2,-,-,<OptAtt-Win2Con>,<OptAtt-Win2Opt>,<OptAtt-Win2BC>,0,0  #   8 ||< external
*surf,win-wall-1-3,VERT,Wall-1-3,-,-,<OptBW-Construction>,<OptBW-Optics>,EXTERIOR,0,0  #   9 ||< external
*surf,win-wall-1-4,VERT,Wall-1-4,-,-,<OptAtt-Win4Con>,<OptAtt-Win4Opt>,<OptAtt-Win4BC>,0,0  #  10 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,all_applicable 4   # insolation sources
7, 8, 9, 10
# 
*base_list,0,<Opt-Area>, 0  # zone base list
