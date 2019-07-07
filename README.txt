*------------------------------------------------------------------------------*
                   Simulation and control design of the pendubot
                                 README file
*------------------------------------------------------------------------------*

This is a matlab project realized in education purposes.

*------------------------------------------------------------------------------*
#To run the simulation:

	- Launch matlab and open the file "simulation_pendubot.m".
 	- Choose between mid and up swing by writing "mid" or "up" in the string
	area dedicated to this.
 	- It displays both angles q1 and q2 over the time, and launches an 
	animation of the pendubot for the chosen swing.

*------------------------------------------------------------------------------*
#Files overview:
	"Report_AN.pdf"
This pdf file contains the report of the project that defines the problem's setup
and gives explanations about the procedure and the math. The results are also 
displayed and lightly discussed.

	"simulation_pendubot.m"
This matlab file contains the main script to run to start the simulation. It runs
"calc_const.m", "linearization.m", "swing.m". It's the skeleton of the code.

	"linearization.m"
This matlab file is a function that perform a linearization process using Taylor
series. It returns matrices A and B in Xdot=Ax+Bu.

	"calc_const.m"
This matlab file is a function that compute the system's paramters theta using
experimental sets of data. Using energy equation method.

	"expData_X.m"
These matlab files are functions that are used by "calc_const.m".
	
	"swing.m"
This matlab file is a function that contains everything to compute the controller
coefficients and compute the values of the state variables of the next step. it
uses "calc_matrix.m" to compute the matrices D, C and G.
	
	"calc_matrix.m"
This matlab file is a function that computes the matrices D, C and G for each 
step, using the new values of the state variables.

	"anim_pendubot.m"
This matlab file is a function that uses the processed angles value to design a
little animation that allows the user to visualize what's happening a better way
than the angle's plot.

	"data_swMID/UP.m"
This matlab file is a script that can be launch to visualize the result of the
experiments we led at the lab. There are no use in this simulation.

*------------------------------------------------------------------------------*