*Geometry 1.1,GEN,roof # tag version, format, zone name
*date Thu Feb  5 15:18:10 2015  # latest file modification 
roof describes the roof
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,10.94840  #   1
*vertex,6.60000,0.00000,10.94840  #   2
*vertex,6.60000,9.35000,10.94840  #   3
*vertex,0.00000,9.35000,10.94840  #   4
*vertex,3.30200,0.00000,12.60000  #   5
*vertex,3.30200,9.35000,12.60000  #   6
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
*surf,Wall-1,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Surf-2,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Surf-4,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,roof-base,FLOR,-,-,-,CeilR50R,OPAQUE,ANOTHER,04,05  #   5 ||< Top-3rd:third_fl
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,61.76,0  # zone base
