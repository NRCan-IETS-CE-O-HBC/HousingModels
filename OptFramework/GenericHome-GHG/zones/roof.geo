*Geometry 1.1,GEN,roof # tag version, format, zone name
*date Mon Mar  7 16:18:31 2011  # latest file modification 
roof describes the roof
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,7.9248  #   1
*vertex,<Opt-Width>,0.00000,7.9248  #   2
*vertex,<Opt-Width>,<Opt-Length>,7.9248  #   3
*vertex,0.00000,<Opt-Length>,7.9248  #   4
*vertex,<Opt-Roof-Peak-W>,0.00000,<Opt-Roof-Height>  #   5
*vertex,<Opt-Roof-Peak-W>,<Opt-Length>,<Opt-Roof-Height>  #   6
# 
# tag, number of vertices followed by list of associated vert
*edges,3,1,2,5  #  1
*edges,4,2,3,6,5  #  2
*edges,3,3,4,6  #  3
*edges,4,4,1,5,6  #  4
*edges,4,1,4,3,2  #  5
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   1 ||< not yet defined
*surf,Surf-2,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   2 ||< not yet defined
*surf,Wall-3,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   3 ||< not yet defined
*surf,Surf-4,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   4 ||< not yet defined
*surf,roof-base,FLOR,-,-,-,<Opt-Ceiling>R,OPAQUE,ANOTHER,04,05  #   5 ||< roof-base:Top-3rd
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,<Opt-Area>, 0  # zone base list
