*Geometry 1.1,GEN,first_fl # tag version, format, zone name
*date Fri Apr  8 16:41:55 2011  # latest file modification 
first_fl describes the first floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,1.07  #   1
*vertex,<Opt-Width>,0.0000,1.07  #   2
*vertex,<Opt-Width>,<Opt-Length>,1.07  #   3
*vertex,0.00000,<Opt-Length>,1.07  #   4
*vertex,0.00000,0.00000,3.57  #   5
*vertex,<Opt-Width>,0.0000,3.57  #   6
*vertex,<Opt-Width>,<Opt-Length>,3.57  #   7
*vertex,0.00000,<Opt-Length>,3.57  #   8
*vertex,<win-wall-1-right>,0.00000,1.57  #   9
*vertex,<win-wall-1-left>,0.00000,1.57  #  10
*vertex,<win-wall-1-left>,0.00000,2.82  #  11
*vertex,<win-wall-1-right>,0.00000,2.82  #  12
*vertex,<Opt-Width>,<win-wall-2-right>,1.57  #  13
*vertex,<Opt-Width>,<win-wall-2-left>,1.57  #  14
*vertex,<Opt-Width>,<win-wall-2-left>,2.82  #  15
*vertex,<Opt-Width>,<win-wall-2-right>,2.82  #  16
*vertex,<win-wall-3-right>,<Opt-Length>,1.57  #  17
*vertex,<win-wall-3-left>,<Opt-Length>,1.57  #  18
*vertex,<win-wall-3-left>,<Opt-Length>,2.82  #  19
*vertex,<win-wall-3-right>,<Opt-Length>,2.82  #  20
*vertex,0.00000,<win-wall-4-right>,1.57  #  21
*vertex,0.00000,<win-wall-4-left>,1.57  #  22
*vertex,0.00000,<win-wall-4-left>,2.82  #  23
*vertex,0.00000,<win-wall-4-right>,2.82  #  24
*vertex,<Opt-Roof-Peak-W>,0.00000,<Opt-Roof-Height>  #  25 
*vertex,<Opt-Roof-Peak-W>,<Opt-Length>,<Opt-Roof-Height>  #  26 
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9    #  1
*edges,10,2,3,7,6,2,13,16,15,14,13  #  2
*edges,10,3,4,8,7,3,17,20,19,18,17  #  3
*edges,10,4,1,5,8,4,21,24,23,22,21  #  4
*edges,4,1,4,3,2  #  5
*edges,4,9,10,11,12   #  6
*edges,4,13,14,15,16  #  7
*edges,4,17,18,19,20  #  8
*edges,4,21,22,23,24  #  9
*edges,3,5,6,25       #  10
*edges,4,6,7,26,25    #  11
*edges,3,7,8,26       #  12
*edges,4,8,5,25,26    #  13
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
*surf,Base-6,FLOR,-,-,-,<Opt-IntFloor>,OPAQUE,ANOTHER,01,05     #   5 ||< Base-6:Top_bsm
*surf,win-wall-1,VERT,Wall-1,-,-,<OptAtt-Win1Con>,<OptAtt-Win1Opt>,EXTERIOR,0,0  #   6 ||< external
*surf,win-wall-2,VERT,Wall-2,-,-,<OptAtt-Win2Con>,<OptAtt-Win2Opt>,EXTERIOR,0,0  #   7 ||< external
*surf,win-wall-3,VERT,Wall-3,-,-,<OptAtt-Win3Con>,<OptAtt-Win3Opt>,EXTERIOR,0,0  #   8 ||< external
*surf,win-wall-4,VERT,Wall-4,-,-,<OptAtt-Win4Con>,<OptAtt-Win4Opt>,EXTERIOR,0,0  #   9 ||< external
*surf,Gable-1,VERT,-,-,-,<Opt-Ceiling>,OPAQUE,EXTERIOR,0,0  #   10 ||< not yet defined
*surf,Slope-2,SLOP,-,-,-,<Opt-Ceiling>,OPAQUE,EXTERIOR,0,0  #   11 ||< not yet defined
*surf,Gable-3,VERT,-,-,-,<Opt-Ceiling>,OPAQUE,EXTERIOR,0,0  #   12 ||< not yet defined
*surf,Slope-4,SLOP,-,-,-,<Opt-Ceiling>,OPAQUE,EXTERIOR,0,0  #   13 ||< not yet defined
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none # insolation sources
# 
*base_list,0,<Opt-Area>, 0  # zone base list
