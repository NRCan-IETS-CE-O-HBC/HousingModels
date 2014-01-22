*Geometry 1.1,GEN,basement # tag version, format, zone name
*date Wed Jan 19 15:51:02 2011  # latest file modification 
basement describes the basement floor of the house
*previous_rotate  90.00,   0.000,   0.000  # prior rotation angle X Y
# tag, X co-ord, Y co-ord, Z co-ord
*vertex,0.00000,0.00000,0.00000  #   1
*vertex,0.00000,-10.76300,0.00000  #   2
*vertex,12.34000,-10.76300,0.00000  #   3
*vertex,0.00000,0.00000,2.26480  #   4
*vertex,0.00000,-10.76300,2.26480  #   5
*vertex,12.34000,-10.76300,2.26480  #   6
*vertex,12.34000,0.00000,0.00000  #   7
*vertex,12.34000,0.00000,2.26480  #   8
*vertex,0.00000,0.00000,1.96000  #   9
*vertex,0.00000,-10.76300,1.26480  #  10
*vertex,12.34000,-10.76300,1.26480  #  11
*vertex,12.34000,0.00000,1.96000  #  12
*vertex,0.00000,-1.00000,1.96000  #  13
*vertex,12.34000,-1.00000,1.96000  #  14
*vertex,0.00000,-7.11200,1.26480  #  15
*vertex,12.34000,-7.11200,1.26480  #  16
*vertex,12.34000,-8.73300,1.42780  #  17
*vertex,12.34000,-7.51380,1.42780  #  18
*vertex,12.34000,-7.51380,2.18980  #  19
*vertex,12.34000,-8.73300,2.18980  #  20
*vertex,1.92900,-10.76300,1.42780  #  21
*vertex,3.14820,-10.76300,1.42780  #  22
*vertex,3.14820,-10.76300,2.18980  #  23
*vertex,1.92900,-10.76300,2.18980  #  24
*vertex,5.48640,-10.76300,1.42780  #  25
*vertex,6.70560,-10.76300,1.42780  #  26
*vertex,6.70560,-10.76300,2.18980  #  27
*vertex,5.48640,-10.76300,2.18980  #  28
*vertex,0.00000,-6.85200,2.26480  #  29
*vertex,4.22000,-6.85200,2.26480  #  30
*vertex,4.22000,-4.41400,2.26480  #  31
*vertex,12.34000,-4.41400,2.26480  #  32
*vertex,0.00000,-8.82100,2.26480  #  33
*vertex,2.11000,-8.82100,2.26480  #  34
*vertex,4.22000,-8.82100,2.26480  #  35
*vertex,5.75000,-8.82100,2.26480  #  36
*vertex,7.77000,-8.82100,2.26480  #  37
*vertex,9.97000,-8.82100,2.26480  #  38
*vertex,12.34000,-8.82100,2.26480  #  39
*vertex,5.75000,-6.85200,2.26480  #  40
*vertex,7.77000,-6.85200,2.26480  #  41
*vertex,9.97000,-6.85200,2.26480  #  42
*vertex,12.34000,-6.85200,2.26480  #  43
*vertex,2.11000,-10.76300,2.26480  #  44
*vertex,4.22000,-10.76300,2.26480  #  45
*vertex,5.75000,-10.76300,2.26480  #  46
*vertex,7.77000,-10.76300,2.26480  #  47
*vertex,9.97000,-10.76300,2.26480  #  48
*vertex,9.97000,-4.41400,2.26480  #  49
*vertex,7.77000,-4.41400,2.26480  #  50
*vertex,5.75000,-4.41400,2.26480  #  51
*vertex,2.11000,-6.85200,2.26480  #  52
# 
# tag, number of vertices followed by list of associated vert
*edges,6,1,2,10,15,13,9  #  1
*edges,4,2,3,11,10  #  2
*edges,6,3,7,12,14,16,11  #  3
*edges,4,7,1,9,12  #  4
*edges,10,4,29,52,30,31,51,50,49,32,8  #  5
*edges,4,1,7,3,2  #  6
*edges,8,9,13,15,10,5,33,29,4  #  7
*edges,21,10,26,25,28,27,26,10,11,6,48,47,46,45,44,5,10,21,24,23,22,21  #  8
*edges,15,11,16,14,12,8,32,43,39,6,11,17,20,19,18,17  #  9
*edges,4,12,9,4,8  # 10
*edges,4,17,18,19,20  # 11
*edges,4,21,22,23,24  # 12
*edges,4,25,26,27,28  # 13
*edges,4,29,33,34,52  # 14
*edges,4,52,34,35,30  # 15
*edges,4,31,30,40,51  # 16
*edges,4,51,40,41,50  # 17
*edges,4,50,41,42,49  # 18
*edges,4,49,42,43,32  # 19
*edges,4,30,35,36,40  # 20
*edges,4,40,36,37,41  # 21
*edges,4,41,37,38,42  # 22
*edges,4,42,38,39,43  # 23
*edges,4,33,5,44,34  # 24
*edges,4,34,44,45,35  # 25
*edges,4,35,45,46,36  # 26
*edges,4,36,46,47,37  # 27
*edges,4,37,47,48,38  # 28
*edges,4,38,48,6,39  # 29
# 
# surf attributes:
#  surf name, surf position VERT/CEIL/FLOR/SLOP/UNKN
#  child of (surface name), useage (pair of tags) 
#  construction name, optical name
#  boundary condition tag followed by two data items
*surf,bw_g_w,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,BASESIMP,01,12  #   1 ||< BASESIMP config type   1
*surf,bw_g_s,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,BASESIMP,01,10  #   2 ||< BASESIMP config type   1
*surf,bw_g_e,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,BASESIMP,01,12  #   3 ||< BASESIMP config type   1
*surf,bw_g_n,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,BASESIMP,01,16  #   4 ||< BASESIMP config type   1
*surf,sub_fl,CEIL,-,-,-,no_ther_INV,OPAQUE,ANOTHER,01,06  #   5 ||< no_th_m:main_flr
*surf,grd_fl,FLOR,-,-,-,bsmt_flr_up,OPAQUE,BASESIMP,01,50  #   6 ||< BASESIMP config type   1
*surf,av_g_w,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,EXTERIOR,0,0  #   7 ||< external
*surf,av_g_s,VERT,bsm_glz_sw,-,-,Sdbsm_wal_up,OPAQUE,EXTERIOR,0,0  #   8 ||< external
*surf,av_g_e,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,EXTERIOR,0,0  #   9 ||< external
*surf,av_g_n,VERT,-,-,-,Sdbsm_wal_up,OPAQUE,EXTERIOR,0,0  #  10 ||< external
*surf,bsm_glz_e,VERT,av_g_e,C-WINDOW,CLOSED,Tpl-low-e,Tpl-2coats,EXTERIOR,0,0  #  11 ||< external
*surf,bsm_glz_sw,VERT,av_g_s,C-WINDOW,CLOSED,Tpl-low-e,Tpl-2coats,EXTERIOR,0,0  #  12 ||< external
*surf,bsm_glz_se,VERT,av_g_s,C-WINDOW,CLOSED,Tpl-low-e,Tpl-2coats,EXTERIOR,0,0  #  13 ||< external
*surf,Top-14,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,25  #  14 ||< th_m_9:main_flr
*surf,Top-15,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,24  #  15 ||< th_m_8:main_flr
*surf,Top-16,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,19  #  16 ||< bathroom:main_flr
*surf,Top-17,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,18  #  17 ||< th_m_3:main_flr
*surf,Top-18,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,17  #  18 ||< th_m_2:main_flr
*surf,Top-19,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,16  #  19 ||< th_m_1:main_flr
*surf,Top-20,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,23  #  20 ||< th_m_7:main_flr
*surf,Top-21,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,22  #  21 ||< th_m_6:main_flr
*surf,Top-22,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,21  #  22 ||< th_m_5:main_flr
*surf,Top-23,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,20  #  23 ||< th_m_4:main_flr
*surf,Top-24,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,31  #  24 ||< th_m_15:main_flr
*surf,Top-25,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,28  #  25 ||< th_m_12:main_flr
*surf,Top-26,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,30  #  26 ||< th_m_14:main_flr
*surf,Top-27,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,27  #  27 ||< th_m_11:main_flr
*surf,Top-28,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,29  #  28 ||< th_m_13:main_flr
*surf,Top-29,CEIL,-,-,-,mass_up_3_IN,OPAQUE,ANOTHER,01,26  #  29 ||< th_m_10:main_flr
# 
*insol,3,0,0,0  # default insolation distribution
# 
# shading directives
*shad_calc,none  # no temporal shading requested
# 
*insol_calc,all_applicable   3 # insolation sources
 11 12 13
# 
*base_list,0,132.82,0  # zone base