*Geometry 1.1,GEN,secondfloor # tag version, format, zone name
*date Mon Jun 14 16:50:35 2010  # latest file modification 
secondfloor describes the second floor of the ccht house as 1 zo
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,5.62000  #   1
*vertex,0.00000,-12.00000,5.62000  #   2
*vertex,12.20000,-12.00000,5.62000  #   3
*vertex,12.20000,0.00000,5.62000  #   4
*vertex,0.00000,0.00000,8.08500  #   5
*vertex,0.00000,-12.00000,8.08500  #   6
*vertex,12.20000,-12.00000,8.08500  #   7
*vertex,12.20000,0.00000,8.08500  #   8
*vertex,1.00000,-12.00000,6.02000  #   9
*vertex,3.43000,-12.00000,6.02000  #  10
*vertex,3.43000,-12.00000,7.66000  #  11
*vertex,1.00000,-12.00000,7.66000  #  12
*vertex,4.25000,-12.00000,6.62000  #  13
*vertex,5.88000,-12.00000,6.62000  #  14
*vertex,5.88000,-12.00000,7.66000  #  15
*vertex,4.25000,-12.00000,7.66000  #  16
*vertex,7.00000,-12.00000,6.41000  #  17
*vertex,9.22000,-12.00000,6.41000  #  18
*vertex,9.22000,-12.00000,7.66000  #  19
*vertex,7.00000,-12.00000,7.66000  #  20
*vertex,2.83000,0.00000,6.02000  #  21
*vertex,1.00000,0.00000,6.02000  #  22
*vertex,1.00000,0.00000,7.26000  #  23
*vertex,2.83000,0.00000,7.26000  #  24
*vertex,8.20000,0.00000,6.02000  #  25
*vertex,6.97000,0.00000,6.02000  #  26
*vertex,6.97000,0.00000,7.26000  #  27
*vertex,8.20000,0.00000,7.26000  #  28
*vertex,4.45000,0.00000,6.22000  #  29
*vertex,3.82000,0.00000,6.22000  #  30
*vertex,3.82000,0.00000,7.26000  #  31
*vertex,4.45000,0.00000,7.26000  #  32
*vertex,2.27000,-4.83000,8.06500  #  33
*vertex,0.00000,-4.83000,8.06500  #  34
*vertex,0.00000,-4.83000,5.62000  #  35
*vertex,2.27000,-4.83000,5.62000  #  36
*vertex,2.27000,-7.25000,5.62000  #  37
*vertex,2.27000,-7.25000,8.06500  #  38
*vertex,0.00000,-7.25000,8.06500  #  39
*vertex,0.00000,-7.25000,5.62000  #  40
*vertex,12.20000,-4.97000,5.62000  #  41
*vertex,6.79000,-4.97000,5.62000  #  42
*vertex,6.79000,-12.00000,5.62000  #  43
# 
# tag, number of vertices followed by list of associated vert
*edges,4,1,35,34,5  #  1
*edges,23,6,12,11,10,9,12,6,2,43,14,13,16,15,14,43,3,18,17,20,19,18,3,7  #  2
*edges,5,3,41,4,8,7  #  3
*edges,22,4,1,22,23,24,21,22,1,5,31,32,29,30,31,5,8,4,25,26,27,28,25  #  4
*edges,8,5,34,33,38,39,6,7,8  #  5
*edges,10,1,4,41,42,43,2,40,37,36,35  #  6
*edges,4,9,10,11,12  #  7
*edges,4,13,14,15,16  #  8
*edges,4,17,18,19,20  #  9
*edges,4,22,21,24,23  # 10
*edges,4,26,25,28,27  # 11
*edges,4,30,29,32,31  # 12
*edges,4,33,34,35,36  # 13
*edges,4,37,38,33,36  # 14
*edges,4,39,38,37,40  # 15
*edges,4,39,40,2,6  # 16
*edges,4,42,41,3,43  # 17
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,2nd_rt_side,VERT,-,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #   1 ||< external
*surf,2nd_front,VERT,w_bathroom,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #   2 ||< external
*surf,2ns_l_side,VERT,-,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #   3 ||< external
*surf,2nd_back,VERT,-,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #   4 ||< external
*surf,2nd_ceiling,CEIL,-,-,-,ceiling,OPAQUE,ANOTHER,06,10  #   5 ||< ceiling:roof
*surf,2nd_floor,FLOR,-,-,-,floors,OPAQUE,ANOTHER,03,08  #   6 ||< main_ceiling:mainfloor
*surf,w_bedrm2,VERT,2nd_front,-,-,dbl_CFC_ivb,CFC,EXTERIOR,0,0  #   7 ||< external
*surf,w_bathroom,VERT,2nd_front,-,-,dbl_CFC_ivb,CFC,EXTERIOR,0,0  #   8 ||< external
*surf,w_master,VERT,2nd_front,-,-,dbl_CFC_ivb,CFC,EXTERIOR,0,0  #   9 ||< external
*surf,w_bdroom3,VERT,-,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  10 ||< external
*surf,w_bedroom4,VERT,-,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  11 ||< external
*surf,w_bathrom2,VERT,-,-,-,ccht_window,DCF7671_06nb,EXTERIOR,0,0  #  12 ||< external
*surf,stair_north,VERT,-,-,-,int_partitn,OPAQUE,ANOTHER,05,11  #  13 ||< 2nd_north:stairwell
*surf,stair_east,VERT,-,-,-,fictitious,SC_fictit,ANOTHER,05,10  #  14 ||< 2nd_east:stairwell
*surf,stair_south,VERT,-,-,-,int_partitn,OPAQUE,ANOTHER,05,12  #  15 ||< 2nd_south:stairwell
*surf,2nd_rt_side2,VERT,-,-,-,ccht_wall,OPAQUE,EXTERIOR,0,0  #  16 ||< external
*surf,flr_abv_gar,FLOR,-,-,-,exp_flr_r,OPAQUE,ANOTHER,02,05  #  17 ||< garage_ceiln:garage
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,all_applicable  11 # list of surfs
  1  2  3  4  7  8  9 10 11 12 16
# 
*insol_calc,all_applicable   3 # insolation sources
 10 11 12
# 
*base_list,2,6,17,   140.91 0  # zone base list
