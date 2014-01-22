 #!/bin/sh
 
 
 rm out.* monthly_results.csv; 
 echo "-- Imput file ---------------------------------------------"
 echo "$1"
 echo "-- Processing shading & Isolation -------------------------"
 ish -mode text -file $1 -zone 4 -act update_silent; 
 echo "-- Running Simulation -------------------------------------"
 bps -file $1 -mode text -p default silent; 
 echo "-- Results ------------------------------------------------"
 cat out.summary | grep GJ; 
 now=`date`
 echo "-- Done at $now ."
 