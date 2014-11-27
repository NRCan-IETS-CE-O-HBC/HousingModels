*Geometry 1.1,GEN,bsmt # tag version, format, zone name
*date Mon Mar  7 16:17:58 2011  # latest file modification 
bsmt describes the NZEH basement
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,<Opt-Width>,0.0000,0.00000  #   1
*vertex,<Opt-Width>,<Opt-Length>,0.00000  #   2
*vertex,0.00000,<Opt-Length>,0.00000  #   3
*vertex,<Opt-Width>,0.0000,2.4384  #   4
*vertex,<Opt-Width>,<Opt-Length>,2.4384  #   5
*vertex,0.00000,<Opt-Length>,2.4384  #   6
*vertex,<gar-width>,0.00000,2.4384  #   7
*vertex,0.00000,<gar-length>,2.4384  #   8
*vertex,<gar-width>,<gar-length>,2.4384  #   9
*vertex,<gar-width>,0.00000,0.00000  #  10
*vertex,<gar-width>,<gar-length>,0.00000  #  11
*vertex,0.00000,<gar-length>,0.00000  #  12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,10,1,4,7  #  1
*edges,4,1,2,5,4  #  2
*edges,4,2,3,6,5  #  3
*edges,4,3,12,8,6  #  4
*edges,6,7,4,5,6,8,9  #  5
*edges,6,12,3,2,1,10,11  #  6
*edges,4,12,11,9,8  #  7
*edges,4,9,11,10,7  #  8
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, Optical name
#  boundary condition tag followed by two data items
*surf,bsm-Wall-1,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,<OptAtt-bsm1BC>  #   1 ||< BASESIMP config type   1
*surf,bsm-Wall-2,VERT,-,-,-,<OptAtt-bsm2Con>,OPAQUE,<OptAtt-bsm2BC>  #   2 ||< BASESIMP config type   1
*surf,bsm-Wall-3,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,<OptAtt-bsm3BC>  #   3 ||< BASESIMP config type   1
*surf,bsm-Wall-4,VERT,-,-,-,<OptAtt-bsm4Con>,OPAQUE,<OptAtt-bsm4BC>  #   4 ||< BASESIMP config type   1
*surf,Top_bsm,CEIL,Base-1st,-,-,<Opt-IntFloorInv>,OPAQUE,ANOTHER,02,06  #   5 ||< Top_bsm:Base-6
*surf,Base_bsm,FLOR,-,-,-,BsmFlrR0,OPAQUE,BASESIMP,01,40  #   6 ||< BASESIMP config type  68
*surf,bsm-Wall-5,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,<OptAtt-bsm5BC>  #   7 ||< BASESIMP config type   1
*surf,bsm-Wall-6,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,<OptAtt-bsm6BC>  #   8 ||< BASESIMP config type   1
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none # insolation sources
# 
*base_list,0,<Opt-Area>, 0  # zone base
