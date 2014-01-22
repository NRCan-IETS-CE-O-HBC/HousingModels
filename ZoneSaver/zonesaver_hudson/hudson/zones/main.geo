*Geometry 1.1,GEN,main # tag version, format, zone name
*date Fri Apr 15 10:10:37 2011  # latest file modification 
main describes a
*previous_rotate -45.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,2.58801,2.58801,2.60000  #   1
*vertex,6.25082,-1.07480,2.60000  #   2
*vertex,3.66281,-3.66281,2.60000  #   3
*vertex,5.38815,-5.38815,2.60000  #   4
*vertex,14.01486,3.23855,2.60000  #   5
*vertex,8.62670,8.62670,2.60000  #   6
*vertex,2.58801,2.58801,5.60000  #   7
*vertex,6.25082,-1.07480,5.60000  #   8
*vertex,3.66281,-3.66281,5.60000  #   9
*vertex,5.38815,-5.38815,5.60000  #  10
*vertex,14.01486,3.23855,5.60000  #  11
*vertex,8.62670,8.62670,5.60000  #  12
*vertex,6.36396,6.36396,5.60000  #  13
*vertex,11.75211,0.97581,5.60000  #  14
*vertex,9.05804,3.66988,8.60000  #  15
*vertex,11.32078,5.93263,8.60000  #  16
*vertex,3.88909,-3.88909,2.62500  #  17
*vertex,4.38406,-4.38406,2.62500  #  18
*vertex,4.38406,-4.38406,5.52500  #  19
*vertex,3.88909,-3.88909,5.52500  #  20
*vertex,4.54670,-4.54670,2.62500  #  21
*vertex,5.18309,-5.18309,2.62500  #  22
*vertex,5.18309,-5.18309,5.52500  #  23
*vertex,4.54670,-4.54670,5.52500  #  24
*vertex,13.02491,4.22850,2.85000  #  25
*vertex,11.96425,5.28916,2.85000  #  26
*vertex,11.96425,5.28916,5.05000  #  27
*vertex,13.02491,4.22850,5.05000  #  28
*vertex,11.89354,5.35987,2.85000  #  29
*vertex,10.62074,6.63266,2.85000  #  30
*vertex,10.62074,6.63266,5.25000  #  31
*vertex,11.89354,5.35987,5.25000  #  32
*vertex,10.55003,6.70337,2.85000  #  33
*vertex,9.48937,7.76403,2.85000  #  34
*vertex,9.48937,7.76403,5.05000  #  35
*vertex,10.55003,6.70337,5.05000  #  36
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,2,8,7  #  1
*edges,4,2,3,9,8  #  2
*edges,16,3,4,22,21,24,23,22,4,10,9,3,17,20,19,18,17  #  3
*edges,5,4,5,11,14,10  #  4
*edges,5,6,1,7,13,12  #  5
*edges,6,1,6,5,4,3,2  #  6
*edges,6,7,8,9,10,14,13  #  7
*edges,23,5,6,30,29,32,31,30,6,34,33,36,35,34,6,12,16,11,5,25,28,27,26,25  #  8
*edges,4,12,13,15,16  #  9
*edges,4,14,11,16,15  # 10
*edges,3,13,14,15  # 11
*edges,4,17,18,19,20  # 12
*edges,4,21,22,23,24  # 13
*edges,4,25,26,27,28  # 14
*edges,4,29,30,31,32  # 15
*edges,4,33,34,35,36  # 16
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,R19_wall,OPAQUE,ANOTHER,04,02  #   1 ||< Wall-3:garage
*surf,Wall-2,VERT,-,-,-,R19_wall,OPAQUE,ANOTHER,04,08  #   2 ||< Wall-8:garage
*surf,Wall-3,VERT,window1,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-4,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Wall-6,VERT,-,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   5 ||< external
*surf,Base-8,FLOR,-,-,-,floors_r,OPAQUE,ANOTHER,01,07  #   6 ||< Top-7:basement
*surf,Top-7,CEIL,-,-,-,floors,OPAQUE,ANOTHER,03,10  #   7 ||< Base-8:second
*surf,Wall-5,VERT,window2,-,-,R19_wall,OPAQUE,EXTERIOR,0,0  #   8 ||< external
*surf,Slop-1,SLOP,-,-,-,R40_ceiling,OPAQUE,EXTERIOR,0,0  #   9 ||< external
*surf,Slop-2,SLOP,-,-,-,R40_ceiling,OPAQUE,EXTERIOR,0,0  #  10 ||< external
*surf,Wall-9,VERT,-,-,-,int_partitn,OPAQUE,ANOTHER,03,05  #  11 ||< Wall-6:second
*surf,window1,VERT,Wall-3,C-WINDOW,CLOSED,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  12 ||< external
*surf,door,VERT,Wall-3,-,-,ext_doors,OPAQUE,EXTERIOR,0,0  #  13 ||< external
*surf,window2,VERT,Wall-5,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  14 ||< external
*surf,window3,VERT,Wall-5,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  15 ||< external
*surf,window4,VERT,Wall-5,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  16 ||< external
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,74.01,0  # zone base
