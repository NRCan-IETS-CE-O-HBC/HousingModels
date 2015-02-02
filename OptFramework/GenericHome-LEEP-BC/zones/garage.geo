*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Thu Nov 13 14:35:28 2014  # latest file modification 
garage describes the inset garage
*previous_rotate  90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,2.43840  #   1
*vertex,<Opt-Width>,0.00000,2.43840  #   2
*vertex,<Opt-Width>,<gar-length>,2.43840  #   3
*vertex,0.00000,<gar-length>,2.43840  #   4
*vertex,0.00000,0.00000,5.4864  #   5
*vertex,<Opt-Width>,0.00000,5.4864  #   6
*vertex,<Opt-Width>,<gar-length>,5.4864  #   7
*vertex,0.00000,<gar-length>,5.4864  #   8
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
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1-gar,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2-gar,VERT,-,-,-,<Opt-MainWall-Bri>,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3-gar,VERT,-,-,-,<Opt-MainWall-Dry>R,OPAQUE,ANOTHER,01,01  #   3 ||< back-gar-1:first_fl
*surf,Wall-4-gar,VERT,-,-,-,ex_brk,OPAQUE,ADIABATIC,0,0  #   4 ||< adiabatic
*surf,top-gar,CEIL,-,-,-,<Opt-ExposedFloor>,OPAQUE,ANOTHER,02,11  #   5 ||< Top-9:second_fl
*surf,slab-gar,FLOR,-,-,-,grg_slab,OPAQUE,BASESIMP,29,100  #   6 ||< BASESIMP config type 29
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,<gar-area>,0  # zone base
