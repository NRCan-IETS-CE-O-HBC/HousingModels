*Geometry 1.1,GEN,bsmt # tag version, format, zone name
*date Mon Mar  7 16:17:58 2011  # latest file modification 
bsmt describes the NZEH basement
*previous_rotate 0.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00000  #   1
*vertex,<Opt-Width>,0.0000,0.00000  #   2
*vertex,<Opt-Width>,<Opt-Length>,0.00000  #   3
*vertex,0.00000,<Opt-Length>,0.00000  #   4
*vertex,0.00000,0.00000,<Opt-Bsm-Height>  #   5
*vertex,<Opt-Width>,0.0000,<Opt-Bsm-Height>  #   6
*vertex,<Opt-Width>,<Opt-Length>,<Opt-Bsm-Height>  #   7
*vertex,0.00000,<Opt-Length>,<Opt-Bsm-Height>  #   8
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,6,5  #  1
*edges,4,2,3,7,6  #  2
*edges,4,3,4,8,7  #  3
*edges,4,4,1,5,8  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, Optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,BASESIMP,01,15  #   1 ||< BASESIMP config type   1
*surf,Wall-2,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,BASESIMP,01,15  #   2 ||< BASESIMP config type   1
*surf,Wall-3,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,BASESIMP,01,15  #   3 ||< BASESIMP config type   1
*surf,Wall-4,VERT,-,-,-,<OPT-BsmWall>,OPAQUE,BASESIMP,01,15  #   4 ||< BASESIMP config type   1
*surf,Top_bsm,CEIL,gr_flr,-,-,<Opt-IntFloorInv>,OPAQUE,ANOTHER,02,06  #   5 ||< Top_bsm:Base-6
*surf,Base_bsm,FLOR,-,-,-,<OPT-BsmFloor>,OPAQUE,BASESIMP,01,40  #  6 ||< BASESIMP config type   1
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none # insolation sources
# 
*base_list,0,<Opt-Area>,1  # zone base
