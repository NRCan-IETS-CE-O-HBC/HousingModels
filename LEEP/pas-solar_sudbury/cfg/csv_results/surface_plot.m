#I hope this works. This should take in the hour
#and make a mesh plot of the surface temperatures

#function [] = surface_plot(hour)

#This is how we'll probably end up graphing stuff
x = [2.207 5.633 7.8365 9.792];
y = [1.055 3.165 4.985 6.76 8.87 11.155];
z = [surface_no_mass(hour_view) surface_no_mass(hour_view) surface_7(hour_view) surface_1(hour_view) ; surface_no_mass(hour_view) surface_no_mass(hour_view) surface_8(hour_view) surface_2(hour_view) ;surface_no_mass(hour_view) surface_13(hour_view) surface_9(hour_view) surface_3(hour_view) ;surface_no_mass(hour_view) surface_14(hour_view) surface_10(hour_view) surface_4(hour_view) ;surface_no_mass(hour_view) surface_15(hour_view) surface_11(hour_view) surface_5(hour_view) ;surface_no_mass(hour_view) surface_16(hour_view) surface_12(hour_view) surface_6(hour_view) ;];
surf(x,y,z);
xlabel('Distance to back of house from front garage (m)')
ylabel('Distance to side of house from front garage (m)')
zlabel('Surface temp(^oC)')
title( datestr(time(hour_view)));
pause
#end