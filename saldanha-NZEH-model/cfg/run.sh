#!/bin/sh
echo "-- Input file ---------------------------------------------"
echo "$1"
echo "-- Processing shading & Isolation -------------------------"
ish -mode text -file $1 -zone bsmt -act update_silent;
ish -mode text -file $1 -zone first_fl -act update_silent;
ish -mode text -file $1 -zone master -act update_silent;
ish -mode text -file $1 -zone ensuite -act update_silent;
ish -mode text -file $1 -zone top_fl -act update_silent;
ish -mode text -file $1 -zone bedroom -act update_silent;