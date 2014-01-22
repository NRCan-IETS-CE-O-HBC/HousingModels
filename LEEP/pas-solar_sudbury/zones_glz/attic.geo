*Geometry 1.1,GEN,attic # tag version, format, zone name
*date Wed Jan 19 11:02:01 2011  # latest file modification 
attic describes a
*previous_rotate  90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,4.72480  #   1
*vertex,0.00000,-10.76300,4.72480  #   2
*vertex,12.34000,-10.76300,4.72480  #   3
*vertex,12.34000,0.00000,4.72480  #   4
*vertex,5.92000,-5.38150,7.41555  #   5
*vertex,6.42000,-5.38150,7.41555  #   6
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
*surf,atc_w,SLOP,-,-,-,Sdb_roof,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,atc_s,SLOP,-,-,-,Sdb_roof,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,atc_e,SLOP,-,-,-,Sdb_roof,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,atc_n,SLOP,-,-,-,Sdb_roof,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,atc_fl,FLOR,-,-,-,Sdb_at_fl_up,OPAQUE,ANOTHER,01,05  #   5 ||< main_cl:main_flr
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,none  # no insolation requested
# 
*base_list,0,132.82,0  # zone base
