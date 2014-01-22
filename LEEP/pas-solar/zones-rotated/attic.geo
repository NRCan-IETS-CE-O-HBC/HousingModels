*Geometry 1.1,GEN,attic # tag version, format, zone name
*date Wed Oct  6 15:17:15 2010  # latest file modification 
attic describes the uncontrolled CCHT attic
*previous_rotate 180.00,   6.000,   6.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,12.00000,12.00000,5.48500  #   1
*vertex,12.00000,-0.09000,5.48500  #   2
*vertex,-0.20000,12.00000,2.77000  #   3
*vertex,-0.20000,-0.09000,2.77000  #   4
*vertex,7.25250,7.25250,9.44125  #   5
*vertex,7.25250,4.65750,9.44125  #   6
*vertex,2.50500,12.00000,5.48500  #   7
*vertex,2.50500,-0.09000,5.48500  #   8
*vertex,2.50500,8.80000,5.48500  #   9
*vertex,2.50500,3.11000,5.48500  #  10
*vertex,5.40202,5.95500,7.89900  #  11
*vertex,2.50500,12.00000,2.77000  #  12
*vertex,2.50500,-0.09000,2.77000  #  13
*vertex,-0.20000,3.58000,2.77000  #  14
*vertex,3.26000,12.00000,5.48500  #  15
*vertex,-0.20000,8.33000,2.77000  #  16
*vertex,-0.20000,8.33000,5.48500  #  17
*vertex,-0.20000,3.58000,5.48500  #  18
*vertex,3.26000,-0.09000,5.48500  #  19
*vertex,3.26000,8.33000,5.48500  #  20
*vertex,3.26000,3.58000,5.48500  #  21
*vertex,3.26000,12.00000,2.77000  #  22
*vertex,3.26000,8.33000,2.77000  #  23
*vertex,3.26000,-0.09000,2.77000  #  24
*vertex,3.26000,3.58000,2.77000  #  25
*vertex,-0.20000,5.95500,7.89900  #  26
# 
# tag, number of vertices followed by list of associated vert
*edges,7,3,16,17,18,14,4,26  #  1
*edges,4,1,5,6,2  #  2
*edges,4,1,15,7,5  #  3
*edges,4,2,6,8,19  #  4
*edges,5,3,26,11,9,12  #  5
*edges,5,4,13,10,11,26  #  6
*edges,7,6,5,7,9,11,10,8  #  7
*edges,8,15,1,2,19,21,18,17,20  #  8
*edges,4,7,15,22,12  #  9
*edges,4,15,20,23,22  # 10
*edges,4,17,16,23,20  # 11
*edges,5,22,23,16,3,12  # 12
*edges,4,19,8,13,24  # 13
*edges,4,19,24,25,21  # 14
*edges,4,25,14,18,21  # 15
*edges,5,14,25,24,13,4  # 16
*edges,3,12,9,7  # 17
*edges,3,13,8,10  # 18
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-7,VERT,-,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Surf-3,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-4,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-5,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Surf-6,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,Surf-7,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   6 ||< external
*surf,Surf-17,SLOP,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,Top-7,FLOR,-,-,-,attic_floor,OPAQUE,ANOTHER,04,05  #   8 ||< Top-7:main_flrs
*surf,Wall-10,VERT,-,-,-,ext_wall_gar,OPAQUE,EXTERIOR,0,0  #   9 ||< external
*surf,Wall-11,VERT,-,-,-,ext_wall_inv,OPAQUE,ANOTHER,04,08  #  10 ||< Wall-9:main_flrs
*surf,Wall-12,VERT,-,-,-,ext_wall_inv,OPAQUE,ANOTHER,04,09  #  11 ||< Wall-10:main_flrs
*surf,Base-13,FLOR,-,-,-,attic_floor,OPAQUE,ANOTHER,02,07  #  12 ||< Base-13:garage
*surf,Wall-14,VERT,-,-,-,ext_wall,OPAQUE,EXTERIOR,0,0  #  13 ||< external
*surf,Wall-15,VERT,-,-,-,ext_wall_inv,OPAQUE,ANOTHER,04,13  #  14 ||< Surf-15:main_flrs
*surf,Wall-16,VERT,-,-,-,ext_wall_inv,OPAQUE,ANOTHER,04,10  #  15 ||< Wall-11:main_flrs
*surf,Base-17,FLOR,-,-,-,attic_floor,OPAQUE,ANOTHER,04,14  #  16 ||< Top-16:main_flrs
*surf,Wall-18,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #  17 ||< external
*surf,Wall-19,VERT,-,-,-,roof,OPAQUE,EXTERIOR,0,0  #  18 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,110.63,1  # zone base
