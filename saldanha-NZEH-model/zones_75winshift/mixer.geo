*Geometry 1.1,GEN,mixer # tag version, format, zone name
*date Mon Mar  7 16:18:31 2011  # latest file modification 
mixer describes an adiabatic mixing zone
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,-3.00000,3.00000,0.00000  #   1
*vertex,-3.00000,2.50000,0.00000  #   2
*vertex,-2.50000,2.50000,0.00000  #   3
*vertex,-2.50000,3.00000,0.00000  #   4
*vertex,-3.00000,3.00000,0.50000  #   5
*vertex,-3.00000,2.50000,0.50000  #   6
*vertex,-2.50000,2.50000,0.50000  #   7
*vertex,-2.50000,3.00000,0.50000  #   8
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
*surf,Wall-1,VERT,-,-,-,bsm_flr,OPAQUE,ADIABATIC,0,0  #   1 ||< adiabatic
*surf,Wall-2,VERT,-,-,-,bsm_flr,OPAQUE,ADIABATIC,0,0  #   2 ||< adiabatic
*surf,Wall-3,VERT,-,-,-,bsm_flr,OPAQUE,ADIABATIC,0,0  #   3 ||< adiabatic
*surf,Wall-4,VERT,-,-,-,bsm_flr,OPAQUE,ADIABATIC,0,0  #   4 ||< adiabatic
*surf,Top-5,CEIL,-,-,-,bsm_flr,OPAQUE,ADIABATIC,0,0  #   5 ||< adiabatic
*surf,Base-6,FLOR,-,-,-,bsm_flr,OPAQUE,ADIABATIC,0,0  #   6 ||< adiabatic
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,0.25,0  # zone base
