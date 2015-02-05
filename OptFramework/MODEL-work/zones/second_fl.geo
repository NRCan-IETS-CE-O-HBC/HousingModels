*Geometry 1.1,GEN,second_fl # tag version, format, zone name
*date Thu Feb  5 14:17:37 2015  # latest file modification 
second_fl describes the second floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,5.15240  #   1
*vertex,6.60000,0.00000,5.15240  #   2
*vertex,6.60000,9.35000,5.15240  #   3
*vertex,0.00000,9.35000,5.15240  #   4
*vertex,0.00000,0.00000,8.17840  #   5
*vertex,6.60000,0.00000,8.17840  #   6
*vertex,6.60000,9.35000,8.17840  #   7
*vertex,0.00000,9.35000,8.17840  #   8
*vertex,0.50000,0.00000,5.98640  #   9
*vertex,3.40600,0.00000,5.98640  #  10
*vertex,3.40600,0.00000,7.20560  #  11
*vertex,0.50000,0.00000,7.20560  #  12
*vertex,6.60000,0.50000,5.98640  #  13
*vertex,6.60000,3.11900,5.98640  #  14
*vertex,6.60000,3.11900,7.20560  #  15
*vertex,6.60000,0.50000,7.20560  #  16
*vertex,6.10400,9.35000,5.98640  #  17
*vertex,3.06600,9.35000,5.98640  #  18
*vertex,3.06600,9.35000,7.20560  #  19
*vertex,6.10400,9.35000,7.20560  #  20
*vertex,0.00000,8.85300,5.98640  #  21
*vertex,0.00000,8.84300,5.98640  #  22
*vertex,0.00000,8.84300,7.20560  #  23
*vertex,0.00000,8.85300,7.20560  #  24
*vertex,6.60000,6.60400,5.15240  #  25
*vertex,0.00000,6.60400,5.15240  #  26
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9  #  1
*edges,11,2,25,3,7,6,2,13,16,15,14,13  #  2
*edges,10,3,4,8,7,3,17,20,19,18,17  #  3
*edges,11,4,26,1,5,8,4,21,24,23,22,21  #  4
*edges,4,5,6,7,8  #  5
*edges,4,25,26,4,3  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
*edges,4,17,18,19,20  #  9
*edges,4,21,22,23,24  # 10
*edges,4,26,25,2,1  # 11
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-2-1,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2-2,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-2-3,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-2-4,VERT,-,-,-,int_wl,OPAQUE,ADIABATIC,0,0  #   4 ||< adiabatic
*surf,Top-2nd,CEIL,-,-,-,floor_inv,OPAQUE,ANOTHER,03,06  #   5 ||< Base-3rd:third_fl
*surf,Base-2nd,FLOR,-,-,-,floor,OPAQUE,ANOTHER,01,05  #   6 ||< Top-1st:first_fl
*surf,win-wall-2-1,VERT,Wall-2-1,-,-,DblClr,DblClr,EXTERIOR,0,0  #   7 ||< external
*surf,win-wall-2-2,VERT,Wall-2-2,-,-,DblClr,DblClr,EXTERIOR,0,0  #   8 ||< external
*surf,win-wall-2-3,VERT,Wall-2-3,-,-,DblClr,DblClr,EXTERIOR,0,0  #   9 ||< external
*surf,win-wall-2-4,VERT,Wall-2-4,-,-,int_wl,OPAQUE,ADIABATIC,0,0  #  10 ||< adiabatic
*surf,garage_ceil,FLOR,-,-,-,ExpFlR31r,OPAQUE,ANOTHER,05,05  #  11 ||< top-gar:garage
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,61.76,0  # zone base
