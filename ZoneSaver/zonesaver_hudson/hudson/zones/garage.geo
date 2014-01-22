*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Fri Apr 15 10:11:24 2011  # latest file modification 
garage describes a
*previous_rotate -45.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,-1.71827,-1.71827,2.60000  #   1
*vertex,1.94454,-5.38108,2.60000  #   2
*vertex,6.25082,-1.07480,2.60000  #   3
*vertex,2.58801,2.58801,2.60000  #   4
*vertex,-1.71827,-1.71827,5.60000  #   5
*vertex,1.94454,-5.38108,5.60000  #   6
*vertex,6.25082,-1.07480,5.60000  #   7
*vertex,2.58801,2.58801,5.60000  #   8
*vertex,-0.70711,-0.70711,5.60000  #   9
*vertex,2.95571,-4.36992,5.60000  #  10
*vertex,3.66281,-3.66281,2.60000  #  11
*vertex,3.66281,-3.66281,5.60000  #  12
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,6,5  #  1
*edges,4,3,4,8,7  #  2
*edges,5,4,1,5,9,8  #  3
*edges,5,1,4,3,11,2  #  4
*edges,4,5,6,10,9  #  5
*edges,5,9,10,12,7,8  #  6
*edges,5,2,11,12,10,6  #  7
*edges,4,11,3,7,12  #  8
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,int_doors,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-3,VERT,-,-,-,R19_wall_r,OPAQUE,ANOTHER,02,01  #   2 ||< Wall-1:main
*surf,Wall-4,VERT,-,-,-,R12_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Base-6,FLOR,-,-,-,slab_floor,OPAQUE,GROUND,01,0  #   4 ||< ground profile  1
*surf,Top-6,CEIL,-,-,-,R40_ceiling,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,Top-7,CEIL,-,-,-,R40_ceiling,OPAQUE,ANOTHER,03,09  #   6 ||< Base-9:second
*surf,Wall-7,VERT,-,-,-,R12_wall,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,Wall-8,VERT,-,-,-,R19_wall_r,OPAQUE,ANOTHER,02,02  #   8 ||< Wall-2:main
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,31.55,0  # zone base
