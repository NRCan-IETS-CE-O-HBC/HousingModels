

#This is to read out out.csv


x = csvread('basecase.csv'); #read out the file

x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

insolation_total_adverse = x(:,1);
insolation_total = x(:,2);
insolation_total_useful = x(:,3);
cooling = x(:,4);
heating = x(:,5);
day = x(:,6);
hour = x(:,7);
month = x(:,8);
timestep = x(:,9);
main_temp = x(:,10);
main_infiltration = x(:,11);
main_heating  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass = x(:,13);
surface_1 = x(:,29);
surface_2 = x(:,26);
surface_3 = x(:,28);
surface_4 = x(:,25);
surface_5 = x(:,27);
surface_6 = x(:,24);
surface_7 = x(:,23);
surface_8 = x(:,22);
surface_9 = x(:,21);
surface_10 = x(:,20);
surface_11 = x(:,19);
surface_12 = x(:,18);
surface_13 = x(:,17);
surface_14 = x(:,16);
surface_15 = x(:,15);
surface_16 = x(:,14);

main_window = x(:,30);

basement_temp = x(:,31);
basement_heating = x(:,32);
basement_window = x(:,33);

garage_temp = x(:,34);
garage_heating = x(:,35);
garage_window = x(:,36);

attic_temp = x(:,37);
attic_heating = x(:,38);
attic_window = x(:,39);

outdoor_temp = x(:,40);

x = csvread('thermal3.csv'); #read out the file

x(1,:) = []; #remove the first row of data cause it's from earlier.

#Assign values

insolation_total_adverse = x(:,1);
insolation_total = x(:,2);
insolation_total_useful = x(:,3);
cooling = x(:,4);
heating = x(:,5);
day = x(:,6);
hour = x(:,7);
month = x(:,8);
timestep = x(:,9);
main_temp = x(:,10);
main_infiltration = x(:,11);
main_heating  = x(:,12);


#starting from the south west facing tile, these are the surfaces
surface_no_mass = x(:,13);
surface_1 = x(:,29);
surface_2 = x(:,26);
surface_3 = x(:,28);
surface_4 = x(:,25);
surface_5 = x(:,27);
surface_6 = x(:,24);
surface_7 = x(:,23);
surface_8 = x(:,22);
surface_9 = x(:,21);
surface_10 = x(:,20);
surface_11 = x(:,19);
surface_12 = x(:,18);
surface_13 = x(:,17);
surface_14 = x(:,16);
surface_15 = x(:,15);
surface_16 = x(:,14);

main_window = x(:,30);

basement_temp = x(:,31);
basement_heating = x(:,32);
basement_window = x(:,33);

garage_temp = x(:,34);
garage_heating = x(:,35);
garage_window = x(:,36);

attic_temp = x(:,37);
attic_heating = x(:,38);
attic_window = x(:,39);

outdoor_temp = x(:,40);

time = zeros(8760,1);
time(1) = datenum([2001 01 01 0 0 0]);

for i = 2:length(time)
	time(i) = time(i-1) + 1/24;
end


