*Geometry 1.1,GEN,third_fl # tag version, format, zone name
*date Thu Feb  5 15:18:10 2015  # latest file modification 
third_fl describes the third floor
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,8.17840  #   1
*vertex,6.60000,0.00000,8.17840  #   2
*vertex,6.60000,9.35000,8.17840  #   3
*vertex,0.00000,9.35000,8.17840  #   4
*vertex,0.00000,0.00000,10.94840  #   5
*vertex,6.60000,0.00000,10.94840  #   6
*vertex,6.60000,9.35000,10.94840  #   7
*vertex,0.00000,9.35000,10.94840  #   8
*vertex,0.50000,0.00000,8.42540  #   9
*vertex,3.40600,0.00000,8.42540  #  10
*vertex,3.40600,0.00000,9.64460  #  11
*vertex,0.50000,0.00000,9.64460  #  12
*vertex,6.60000,0.50000,8.42540  #  13
*vertex,6.60000,0.51000,8.42540  #  14
*vertex,6.60000,0.51000,9.64460  #  15
*vertex,6.60000,0.50000,9.64460  #  16
*vertex,6.10400,9.35000,8.42540  #  17
*vertex,3.06600,9.35000,8.42540  #  18
*vertex,3.06600,9.35000,9.64460  #  19
*vertex,6.10400,9.35000,9.64460  #  20
*vertex,0.00000,8.85300,8.42540  #  21
*vertex,0.00000,6.23400,8.42540  #  22
*vertex,0.00000,6.23400,9.64460  #  23
*vertex,0.00000,8.85300,9.64460  #  24
# 
# tag, number of vertices followed by list of associated vert
*edges,10,1,2,6,5,1,9,12,11,10,9  #  1
*edges,10,2,3,7,6,2,13,16,15,14,13  #  2
*edges,10,3,4,8,7,3,17,20,19,18,17  #  3
*edges,10,4,1,5,8,4,21,24,23,22,21  #  4
*edges,4,5,6,7,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
*edges,4,17,18,19,20  #  9
*edges,4,21,22,23,24  # 10
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-3-1,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-3-2,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,Wall-3-3,VERT,-,-,-,BaseR20Bri,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,Wall-3-4,VERT,-,-,-,int_wl,OPAQUE,ADIABATIC,0,0  #   4 ||< adiabatic
*surf,Top-3rd,CEIL,-,-,-,CeilR50,OPAQUE,ANOTHER,04,05  #   5 ||< roof-base:roof
*surf,Base-3rd,FLOR,-,-,-,floor,OPAQUE,ANOTHER,03,05  #   6 ||< Top-2nd:second_fl
*surf,win-wall-3-1,VERT,Wall-3-1,-,-,DblClr,DblClr,EXTERIOR,0,0  #   7 ||< external
*surf,win-wall-3-2,VERT,Wall-3-2,-,-,DblClr,DblClr,EXTERIOR,0,0  #   8 ||< external
*surf,win-wall-3-3,VERT,Wall-3-3,-,-,DblClr,DblClr,EXTERIOR,0,0  #   9 ||< external
*surf,win-wall-3-4,VERT,Wall-3-4,-,-,int_wl,OPAQUE,ADIABATIC,0,0  #  10 ||< adiabatic
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,61.76,0  # zone base
