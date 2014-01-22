#This is my general working function cause octave kinda sucks for that



start = datenum([2001 05 01 2 0 0]); #This is the start of when you want to see
finish = datenum([2001 08 31 0 0 0]); #This is the end of when you want to see



start_real = floor((start - datenum([2001 01 01 0 0 0]))*24); 
finish_real = floor((finish - datenum([2001 01 01 0 0 0]))*24); 


#Original plot

plot(time(start_real:finish_real),main_temp_base(start_real:finish_real))
datetick(2)
axis([start,finish]);
legend('Basecase temp');
pause

#xlabel('Time');


#Additional plots
hold



plot(time(start_real:finish_real),main_temp_ins(start_real:finish_real),'g')
legend('Basecase temp','Insulation temp');
pause

plot(time(start_real:finish_real),main_temp_ori(start_real:finish_real),'k')
legend('Basecase temp','Insulation temp','Orientation temp');
pause

plot(time(start_real:finish_real),main_temp_glz(start_real:finish_real),'r')
legend('Basecase temp','Insulation temp','Orientation temp','Glazing temp');
pause

plot(time(start_real:finish_real),main_temp_tm1(start_real:finish_real),'c')
legend('Basecase temp','Insulation temp','Orientation temp','Glazing temp','Thermal 1 temp');
pause

plot(time(start_real:finish_real),main_temp_tm2(start_real:finish_real),'--g')
legend('Basecase temp','Insulation temp','Orientation temp','Glazing temp','Thermal 1 temp','Thermal 2 temp');
pause

plot(time(start_real:finish_real),main_temp_tm3(start_real:finish_real),'.b')
legend('Basecase temp','Insulation temp','Orientation temp','Glazing temp','Thermal 1 temp','Thermal 2 temp','Thermal 3 temp');
pause

plot(time(start_real:finish_real),outdoor_temp_base(start_real:finish_real),'y')
legend('Basecase temp','Insulation temp','Orientation temp','Glazing temp','Thermal 1 temp','Thermal 2 temp','Thermal 3 temp','Outdoor temp');
pause

hold off