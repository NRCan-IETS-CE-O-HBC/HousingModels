 #!/bin/sh
 
 
 rm out.* monthly_results.csv; 
 echo "-- Input file ---------------------------------------------"
 echo "$1"
 echo "-- Processing shading & Isolation -------------------------"
 ish -mode text -file $1 -zone main_flr -act update_silent; 
 ish -mode text -file $1 -zone basement -act update_silent; 
 ish -mode text -file $1 -zone garage   -act update_silent; 
 echo "-- Running Simulation -------------------------------------"
 bps -file $1 -mode text -p fullyear silent; 
 echo "-- Results ------------------------------------------------"
 cat out.summary | grep GJ; 
 now=`date`
 echo "-- Done at $now ."
 