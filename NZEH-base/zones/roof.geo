*Geometry 1.1,GEN,roof # tag version, format, zone name
*date Mon Mar  7 16:18:31 2011  # latest file modification 
roof describes the roof
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,-0.00000,-5.31810,11.79600  #   1
*vertex,12.43330,-5.31810,11.79600  #   2
*vertex,10.55065,1.21920,9.81080  #   3
*vertex,10.55065,-2.33970,9.81080  #   4
*vertex,0.00000,0.00000,8.25100  #   5
*vertex,-0.00000,-4.50000,8.25100  #   6
*vertex,4.89600,-4.50000,8.25100  #   7
*vertex,4.89600,-7.00000,8.25100  #   8
*vertex,5.30000,-7.00000,8.25100  #   9
*vertex,7.30000,-7.00000,8.25100  #  10
*vertex,7.30000,-5.63600,8.25100  #  11
*vertex,12.43330,-5.63600,8.25100  #  12
*vertex,12.43330,1.21920,8.25100  #  13
*vertex,8.66800,1.21920,8.25100  #  14
*vertex,8.66800,-0.00000,8.25100  #  15
*vertex,-0.00000,-10.63620,8.25100  #  16
*vertex,5.30000,-10.63620,8.25100  #  17
*vertex,7.30000,-10.63620,8.25100  #  18
*vertex,12.43330,-10.63620,8.25100  #  19
*vertex,12.43330,-0.00000,8.25100  #  20
# 
# tag, number of vertices followed by list of associated vert
*edges,4,5,6,16,1  #  1
*edges,4,19,12,20,2  #  2
*edges,6,5,1,2,20,4,15  #  3
*edges,6,19,2,1,16,17,18  #  4
*edges,3,3,13,14  #  5
*edges,4,3,4,20,13  #  6
*edges,4,4,3,14,15  #  7
*edges,12,6,5,15,14,13,20,12,11,10,9,8,7  #  8
*edges,6,16,6,7,8,9,17  #  9
*edges,4,17,9,10,18  # 10
*edges,5,18,10,11,12,19  # 11
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-3,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Surf-4,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Surf-5,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Wall-6,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,Surf-7,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   6 ||< external
*surf,Surf-8,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,Top-11,FLOR,-,-,-,<Opt-CeilingR>,OPAQUE,ANOTHER,07,11  #   8 ||< Top-11:top_fl
*surf,Top-7,FLOR,-,-,-,<Opt-CeilingR>,OPAQUE,ANOTHER,04,07  #   9 ||< Top-7:master
*surf,Top-5,FLOR,-,-,-,<Opt-CeilingR>,OPAQUE,ANOTHER,05,05  #  10 ||< Top-5:ensuite
*surf,Top-6,FLOR,-,-,-,<Opt-CeilingR>,OPAQUE,ANOTHER,06,05  #  11 ||< Top-5:bedroom
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,136.83,0  # zone base
