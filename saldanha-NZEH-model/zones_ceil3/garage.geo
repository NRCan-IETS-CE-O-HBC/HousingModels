*Geometry 1.1,GEN,garage # tag version, format, zone name
*date Mon Mar  7 16:17:58 2011  # latest file modification 
garage describes the garage
*previous_rotate -90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,1.97400  #   1
*vertex,-0.00000,-6.52300,1.97400  #   2
*vertex,4.89610,-6.52300,1.97400  #   3
*vertex,4.89610,-0.00000,1.97400  #   4
*vertex,0.00000,0.00000,5.78100  #   5
*vertex,-0.00000,-6.52300,5.78100  #   6
*vertex,4.89610,-6.52300,5.78100  #   7
*vertex,4.89610,-0.00000,5.78100  #   8
*vertex,-0.00000,-6.52300,2.73800  #   9
*vertex,4.89610,-6.52300,2.73800  #  10
*vertex,4.89610,-0.00000,2.73800  #  11
*vertex,-0.00000,-4.50000,5.78100  #  12
*vertex,4.89610,-4.50000,5.78100  #  13
# 
# tag, number of vertices followed by list of associated vert
*edges,6,1,2,9,6,12,5  #  1
*edges,4,9,10,7,6  #  2
*edges,5,10,11,8,13,7  #  3
*edges,5,4,1,5,8,11  #  4
*edges,4,5,12,13,8  #  5
*edges,4,1,4,3,2  #  6
*edges,4,2,3,10,9  #  7
*edges,4,3,4,11,10  #  8
*edges,4,12,6,7,13  #  9
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,Wall-1,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,Wall-2,VERT,-,-,-,gr_wll_g,OPAQUE,ANOTHER,03,08  #   2 ||< Wall-8:first_fl
*surf,Wall-3,VERT,-,-,-,gr_wll_g,OPAQUE,ANOTHER,03,07  #   3 ||< Wall-7:first_fl
*surf,Wall-4,VERT,-,-,-,ex_brk,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,Top-5,CEIL,-,-,-,gr_ceil,OPAQUE,ANOTHER,07,14  #   5 ||< Base-14:top_fl
*surf,Base-6,FLOR,-,-,-,grg_slab,OPAQUE,BASESIMP,29,100  #   6 ||< BASESIMP config type  29
*surf,Wall-7,VERT,-,-,-,gr_wll_g,OPAQUE,ANOTHER,01,18  #   7 ||< Wall-18:bsmt
*surf,Wall-8,VERT,-,-,-,gr_wll_g,OPAQUE,ANOTHER,01,17  #   8 ||< Wall-17:bsmt
*surf,Top-9,CEIL,-,-,-,gr_ceil,OPAQUE,ANOTHER,04,09  #   9 ||< Base-9:master
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,31.94,0  # zone base
