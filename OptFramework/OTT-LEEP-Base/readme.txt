Instructions for modelling 2-storey attached homes
1. Determine the geometry tags using 2storey_model_geometry.xlsx (in this directory).
This file can be used to calculate the <Opt-Width> and <Opt_Length> from the area <Opt-Area> or those values can be input and the area calculated.
The value of <Opt-Width> should be the larger of the two dimensions - for the BASESIMP model to run.
The heights of each of the walls is pre-defined in the zone .geo files; so the values in the C6,C7 and C8 are just for calculating window sizes.
The roof height also needs to be defined. The roof slope can be modified in the spreadsheet, and the value of  <Opt-Roof-Height> needs to be input in the options file.


2. Input calculated dimension into OPTIONS-generic.options
Search the OPTIONS-generic.options file for "Geometry substitutions". In this section you will need to define the values calculated in the spreadsheet.
You should create a new case and add the geometry values to it.

3. Update DESIGN-generic-2storey.choices
a. To update the geometry substitutions, modify
! Geometry substitutions
Opt-geometry      : 
to reflect the case being simulated

b. Define the schedule for internal gains; constant or scheduled for 
OPT-OPR-SCHED

c. Define attachment; single, semi or row for
Opt-Attachment

d. Define the ACH in the AIM-2 file
Opt-ACH

3. Run substitute.pl
./substitute.pl -o OPTIONS-generic.options -c DESIGN-generic-3storey.choices -b GenericHome-3storey -vv