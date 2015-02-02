*Geometry 1.1,GEN,third_fl # tag version, format, zone name
*date Thu Nov 13 11:55:30 2014  # latest file modification 
third_fl describes the third floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,7.92540  #   1
*vertex,<Opt-Width>,0.00000,7.92540  #   2
*vertex,<Opt-Width>,<Opt-Length>,7.92540  #   3
*vertex,0.00000,<Opt-Length>,7.92540  #   4
*vertex,0.00000,0.00000,10.36380  #   5
*vertex,<Opt-Width>,0.00000,10.36380  #   6
*vertex,<Opt-Width>,<Opt-Length>,10.36380  #   7
*vertex,0.00000,<Opt-Length>,10.36380  #   8
*vertex,<win-wall-1-right>,0.00000,8.42540  #   9
*vertex,<win-wall-1-left>,0.00000,8.42540  #  10
*vertex,<win-wall-1-left>,0.00000,9.64460  #  11
*vertex,<win-wall-1-right>,0.00000,9.64460  #  12
*vertex,<Opt-Width>,<win-wall-2-right>,8.42540  #  13
*vertex,<Opt-Width>,<win-wall-2-left>,8.42540  #  14
*vertex,<Opt-Width>,<win-wall-2-left>,9.64460  #  15
*vertex,<Opt-Width>,<win-wall-2-right>,9.64460  #  16
*vertex,<win-wall-3-right>,<Opt-Length>,8.42540  #  17
*vertex,<win-wall-3-left>,<Opt-Length>,8.42540  #  18
*vertex,<win-wall-3-left>,<Opt-Length>,9.64460  #  19
*vertex,<win-wall-3-right>,<Opt-Length>,9.64460  #  20
*vertex,0.00000,<win-wall-4-right>,8.42540  #  21
*vertex,0.00000,<win-wall-4-left>,8.42540  #  22
*vertex,0.00000,<win-wall-4-left>,9.64460  #  23
*vertex,0.00000,<win-wall-4-right>,9.64460  #  24
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
*surf,Wall-3-1,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-3-2,VERT,-,-,-,<OptAtt-Wall2Con>,<OptAtt-Wall2Opt>,<OptAtt-Wall2BC>,0,0  #   2 ||< external
*surf,Wall-3-3,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-3-4,VERT,-,-,-,<OptAtt-Wall4Con>,<OptAtt-Wall4Opt>,<OptAtt-Wall4BC>,0,0  #   4 ||< 
*surf,Top-3rd,CEIL,-,-,-,<Opt-Ceiling>,OPAQUE,ANOTHER,04,05  #   5 ||< roof-base:roof
*surf,Base-3rd,FLOR,-,-,-,<Opt-IntFloor>,OPAQUE,ANOTHER,03,05  #   6 ||< Top-2nd:second_fl
*surf,win-wall-3-1,VERT,Wall-3-1,-,-,<OptAtt-Win1Con>,<OptAtt-Win1Opt>,EXTERIOR,0,0  #   7 ||< external
*surf,win-wall-3-2,VERT,Wall-3-2,-,-,<OptAtt-Win2Con>,<OptAtt-Win2Opt>,<OptAtt-Win2BC>,0,0  #   8 ||< external
*surf,win-wall-3-3,VERT,Wall-3-3,-,-,<OptAtt-Win3Con>,<OptAtt-Win3Opt>,EXTERIOR,0,0  #   9 ||< external
*surf,win-wall-3-4,VERT,Wall-3-4,-,-,<OptAtt-Win4Con>,<OptAtt-Win4Opt>,<OptAtt-Win4BC>,0,0  #  10 ||< 
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,<Opt-Area>,0  # zone base
