

#This is to read out out.csv
x = csvread('basecase.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_base = x(:,1);
ins_tot_base = x(:,2);
insolation_total_useful_base = x(:,3);
cooling_base = x(:,4);
heating_base = x(:,5);
day_base = x(:,6);
hour_base = x(:,7);
month_base = x(:,8);
timestep_base = x(:,9);
main_temp_base = x(:,10);
main_infiltration_base = x(:,11);
main_heating_base  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_base = x(:,13);
surface_1_base = x(:,29);
surface_2_base = x(:,26);
surface_3_base = x(:,28);
surface_4_base = x(:,25);
surface_5_base = x(:,27);
surface_6_base = x(:,24);
surface_7_base = x(:,23);
surface_8_base = x(:,22);
surface_9_base = x(:,21);
surface_10_base = x(:,20);
surface_11_base = x(:,19);
surface_12_base = x(:,18);
surface_13_base = x(:,17);
surface_14_base = x(:,16);
surface_15_base = x(:,15);
surface_16_base = x(:,14);

main_window_base = x(:,30);

basement_temp_base = x(:,31);
basement_heating_base = x(:,32);
basement_window_base = x(:,33);

garage_temp_base = x(:,34);
garage_heating_base = x(:,35);
garage_window_base = x(:,36);

attic_temp_base = x(:,37);
attic_heating_base = x(:,38);
attic_window_base = x(:,39);

outdoor_temp_base = x(:,40);




#This is to read out out.csv
x = csvread('insulation.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_ins = x(:,1);
ins_tot_ins = x(:,2);
insolation_total_useful_ins = x(:,3);
cooling_ins = x(:,4);
heating_ins = x(:,5);
day_ins = x(:,6);
hour_ins = x(:,7);
month_ins = x(:,8);
timestep_ins = x(:,9);
main_temp_ins = x(:,10);
main_infiltration_ins = x(:,11);
main_heating_ins  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_ins = x(:,13);
surface_1_ins = x(:,29);
surface_2_ins = x(:,26);
surface_3_ins = x(:,28);
surface_4_ins = x(:,25);
surface_5_ins = x(:,27);
surface_6_ins = x(:,24);
surface_7_ins = x(:,23);
surface_8_ins = x(:,22);
surface_9_ins = x(:,21);
surface_10_ins = x(:,20);
surface_11_ins = x(:,19);
surface_12_ins = x(:,18);
surface_13_ins = x(:,17);
surface_14_ins = x(:,16);
surface_15_ins = x(:,15);
surface_16_ins = x(:,14);

main_window_ins = x(:,30);

basement_temp_ins = x(:,31);
basement_heating_ins = x(:,32);
basement_window_ins = x(:,33);

garage_temp_ins = x(:,34);
garage_heating_ins = x(:,35);
garage_window_ins = x(:,36);

attic_temp_ins = x(:,37);
attic_heating_ins = x(:,38);
attic_window_ins = x(:,39);

outdoor_temp_ins = x(:,40);




#This is to read out out.csv
x = csvread('orientation.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_ori = x(:,1);
ins_tot_ori = x(:,2);
insolation_total_useful_ori = x(:,3);
cooling_ori = x(:,4);
heating_ori = x(:,5);
day_ori = x(:,6);
hour_ori = x(:,7);
month_ori = x(:,8);
timestep_ori = x(:,9);
main_temp_ori = x(:,10);
main_infiltration_ori = x(:,11);
main_heating_ori  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_ori = x(:,13);
surface_1_ori = x(:,29);
surface_2_ori = x(:,26);
surface_3_ori = x(:,28);
surface_4_ori = x(:,25);
surface_5_ori = x(:,27);
surface_6_ori = x(:,24);
surface_7_ori = x(:,23);
surface_8_ori = x(:,22);
surface_9_ori = x(:,21);
surface_10_ori = x(:,20);
surface_11_ori = x(:,19);
surface_12_ori = x(:,18);
surface_13_ori = x(:,17);
surface_14_ori = x(:,16);
surface_15_ori = x(:,15);
surface_16_ori = x(:,14);

main_window_ori = x(:,30);

basement_temp_ori = x(:,31);
basement_heating_ori = x(:,32);
basement_window_ori = x(:,33);

garage_temp_ori = x(:,34);
garage_heating_ori = x(:,35);
garage_window_ori = x(:,36);

attic_temp_ori = x(:,37);
attic_heating_ori = x(:,38);
attic_window_ori = x(:,39);

outdoor_temp_ori = x(:,40);




#This is to read out out.csv
x = csvread('glazing.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_glz = x(:,1);
ins_tot_glz = x(:,2);
insolation_total_useful_glz = x(:,3);
cooling_glz = x(:,4);
heating_glz = x(:,5);
day_glz = x(:,6);
hour_glz = x(:,7);
month_glz = x(:,8);
timestep_glz = x(:,9);
main_temp_glz = x(:,10);
main_infiltration_glz = x(:,11);
main_heating_glz  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_glz = x(:,13);
surface_1_glz = x(:,29);
surface_2_glz = x(:,26);
surface_3_glz = x(:,28);
surface_4_glz = x(:,25);
surface_5_glz = x(:,27);
surface_6_glz = x(:,24);
surface_7_glz = x(:,23);
surface_8_glz = x(:,22);
surface_9_glz = x(:,21);
surface_10_glz = x(:,20);
surface_11_glz = x(:,19);
surface_12_glz = x(:,18);
surface_13_glz = x(:,17);
surface_14_glz = x(:,16);
surface_15_glz = x(:,15);
surface_16_glz = x(:,14);

main_window_glz = x(:,30);

basement_temp_glz = x(:,31);
basement_heating_glz = x(:,32);
basement_window_glz = x(:,33);

garage_temp_glz = x(:,34);
garage_heating_glz = x(:,35);
garage_window_glz = x(:,36);

attic_temp_glz = x(:,37);
attic_heating_glz = x(:,38);
attic_window_glz = x(:,39);

outdoor_temp_glz = x(:,40);




#This is to read out out.csv
x = csvread('thermal1.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_tm1 = x(:,1);
ins_tot_tm1 = x(:,2);
insolation_total_useful_tm1 = x(:,3);
cooling_tm1 = x(:,4);
heating_tm1 = x(:,5);
day_tm1 = x(:,6);
hour_tm1 = x(:,7);
month_tm1 = x(:,8);
timestep_tm1 = x(:,9);
main_temp_tm1 = x(:,10);
main_infiltration_tm1 = x(:,11);
main_heating_tm1  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_tm1 = x(:,13);
surface_1_tm1 = x(:,29);
surface_2_tm1 = x(:,26);
surface_3_tm1 = x(:,28);
surface_4_tm1 = x(:,25);
surface_5_tm1 = x(:,27);
surface_6_tm1 = x(:,24);
surface_7_tm1 = x(:,23);
surface_8_tm1 = x(:,22);
surface_9_tm1 = x(:,21);
surface_10_tm1 = x(:,20);
surface_11_tm1 = x(:,19);
surface_12_tm1 = x(:,18);
surface_13_tm1 = x(:,17);
surface_14_tm1 = x(:,16);
surface_15_tm1 = x(:,15);
surface_16_tm1 = x(:,14);

main_window_tm1 = x(:,30);

basement_temp_tm1 = x(:,31);
basement_heating_tm1 = x(:,32);
basement_window_tm1 = x(:,33);

garage_temp_tm1 = x(:,34);
garage_heating_tm1 = x(:,35);
garage_window_tm1 = x(:,36);

attic_temp_tm1 = x(:,37);
attic_heating_tm1 = x(:,38);
attic_window_tm1 = x(:,39);

outdoor_temp_tm1 = x(:,40);




#This is to read out out.csv
x = csvread('thermal2.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_tm2 = x(:,1);
ins_tot_tm2 = x(:,2);
insolation_total_useful_tm2 = x(:,3);
cooling_tm2 = x(:,4);
heating_tm2 = x(:,5);
day_tm2 = x(:,6);
hour_tm2 = x(:,7);
month_tm2 = x(:,8);
timestep_tm2 = x(:,9);
main_temp_tm2 = x(:,10);
main_infiltration_tm2 = x(:,11);
main_heating_tm2  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_tm2 = x(:,13);
surface_1_tm2 = x(:,29);
surface_2_tm2 = x(:,26);
surface_3_tm2 = x(:,28);
surface_4_tm2 = x(:,25);
surface_5_tm2 = x(:,27);
surface_6_tm2 = x(:,24);
surface_7_tm2 = x(:,23);
surface_8_tm2 = x(:,22);
surface_9_tm2 = x(:,21);
surface_10_tm2 = x(:,20);
surface_11_tm2 = x(:,19);
surface_12_tm2 = x(:,18);
surface_13_tm2 = x(:,17);
surface_14_tm2 = x(:,16);
surface_15_tm2 = x(:,15);
surface_16_tm2 = x(:,14);

main_window_tm2 = x(:,30);

basement_temp_tm2 = x(:,31);
basement_heating_tm2 = x(:,32);
basement_window_tm2 = x(:,33);

garage_temp_tm2 = x(:,34);
garage_heating_tm2 = x(:,35);
garage_window_tm2 = x(:,36);

attic_temp_tm2 = x(:,37);
attic_heating_tm2 = x(:,38);
attic_window_tm2 = x(:,39);

outdoor_temp_tm2 = x(:,40);





#This is to read out out.csv
x = csvread('thermal3.csv'); #read out the file


x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

ins_tot_adv_tm3 = x(:,1);
ins_tot_tm3 = x(:,2);
insolation_total_useful_tm3 = x(:,3);
cooling_tm3 = x(:,4);
heating_tm3 = x(:,5);
day_tm3 = x(:,6);
hour_tm3 = x(:,7);
month_tm3 = x(:,8);
timestep_tm3 = x(:,9);
main_temp_tm3 = x(:,10);
main_infiltration_tm3 = x(:,11);
main_heating_tm3  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass_tm3 = x(:,13);
surface_1_tm3 = x(:,29);
surface_2_tm3 = x(:,26);
surface_3_tm3 = x(:,28);
surface_4_tm3 = x(:,25);
surface_5_tm3 = x(:,27);
surface_6_tm3 = x(:,24);
surface_7_tm3 = x(:,23);
surface_8_tm3 = x(:,22);
surface_9_tm3 = x(:,21);
surface_10_tm3 = x(:,20);
surface_11_tm3 = x(:,19);
surface_12_tm3 = x(:,18);
surface_13_tm3 = x(:,17);
surface_14_tm3 = x(:,16);
surface_15_tm3 = x(:,15);
surface_16_tm3 = x(:,14);

main_window_tm3 = x(:,30);

basement_temp_tm3 = x(:,31);
basement_heating_tm3 = x(:,32);
basement_window_tm3 = x(:,33);

garage_temp_tm3 = x(:,34);
garage_heating_tm3 = x(:,35);
garage_window_tm3 = x(:,36);

attic_temp_tm3 = x(:,37);
attic_heating_tm3 = x(:,38);
attic_window_tm3 = x(:,39);

outdoor_temp_tm3 = x(:,40);





time = zeros(8760,1);
time(1) = datenum([2001 01 01 0 0 0]);

for i = 2:length(time)
	time(i) = time(i-1) + 1/24;
end


