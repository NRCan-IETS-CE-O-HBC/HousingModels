*Geometry 1.1,GEN,first_fl # tag version, format, zone name
*date Fri Apr  8 8:41:55 2011  # latest file modification 
first_fl describes the first floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,<Opt-Width>,<gar-length>,2.4384  #   1
*vertex,<Opt-Width>,<Opt-Length>,2.4384  #   2
*vertex,0.00000,<Opt-Length>,2.4384  #   3
*vertex,0.00000,<gar-length>,2.4384  #   4
*vertex,<Opt-Width>,<gar-length>,5.4864  #   5
*vertex,<Opt-Width>,<Opt-Length>,5.4864  #   6
*vertex,0.00000,<Opt-Length>,5.4864  #   7
*vertex,0.00000,<gar-length>,5.4864  #   8
*vertex,<win-wall-3-right>,<Opt-Length>,2.9384  #  9
*vertex,<win-wall-3-left>,<Opt-Length>,2.9384  #  10
*vertex,<win-wall-3-left>,<Opt-Length>,4.4624  #  11
*vertex,<win-wall-3-right>,<Opt-Length>,4.4624  # 12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,4,1,5,8   #  1
*edges,4,1,2,6,5   #  2
*edges,10,2,3,7,6,2,9,12,11,10,9   #  3
*edges,4,3,4,8,7 #  4
*edges,4,5,6,7,8   #  5
*edges,4,1,4,3,2   #  6
*edges,4,9,10,11,12  #  7
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1-1,VERT,-,-,-,<Opt-MainWall-Dry>,OPAQUE,ANOTHER,05,03  #   1 ||< wall-1-1:Wall-3-gar
*surf,Wall-1-2,VERT,-,-,-,<OptAtt-Wall2Con>,<OptAtt-Wall2Opt>,<OptAtt-Wall2BC> #   2 ||< external
*surf,Wall-1-3,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-1-4,VERT,-,-,-,<OptAtt-Wall4Con>,<OptAtt-Wall4Opt>,<OptAtt-Wall4BC>,0,0  #   4 ||< external
*surf,Top-1st,CEIL,-,-,-,<Opt-IntFloorInv>,OPAQUE,ANOTHER,02,06       #   5 ||< Top-1st:Base-2nd
*surf,Base-1st,FLOR,-,-,-,<OPT-BsmFloor>,OPAQUE,BASESIMP,28,100  #   6 ||< BASESIMP config type 29
*surf,win-wall-1-3,VERT,Wall-1-3,-,-,<OptAtt-Win3Con>,<OptAtt-Win3Opt>,EXTERIOR,0,0  # 7 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none # insolation sources
# 
*base_list,0,<Opt-Area>, 0  # zone base list
