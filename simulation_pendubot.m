clear; clc; close all;

global theta A B sw g T Keq;

g=9.81; % gravity
T=0.005; % Sample time for discrete controler

%% Choose the swing:
% We choose between the swing up and the swing mid:
%   - 'up' to target [pi/2; 0] for a swing up 
%   - 'mid' to target [-pi/2; pi] for a swing mid
sw='up';

if strcmp(sw,'up')
    eq_point = [pi/2; 0];
elseif strcmp(sw, 'mid')
    eq_point = [-pi/2; pi];
end

%% Calculation of the system's caracteristics teta:
% This comented part can be used in case you want to change the values of
% theta with which you know the result of the experiment... Uncomment this
% one and comment the lower part if you want to use it.

% for set 1:
% teta_1= ;
% teta_2= ;
% teta_3= ;
% teta_4= ;
% teta_5= ;

% theta=[teta_1; teta_2; teta_3; teta_4;teta_5];

% Here we get the values of the system's constants theta(i), i=1,...,5.
% To do so we use the function "calc_const(*data*)" that needs experimental
% data that we got from trials with step response from the lab. The
% results are stored in the function "expData_X()" where X is the trial
% number.

% Theta from the first trial:
[Time, q1, dq1, q2, dq2, signal_Gain]=expData_1();
theta_A = calc_const(Time, q1, dq1, q2, dq2, signal_Gain);

% Theta from the first trial:
[Time, q1, dq1, q2, dq2, signal_Gain]=expData_2();
theta_B = calc_const(Time, q1, dq1, q2, dq2, signal_Gain);

% Theta from the first trial:
[Time, q1, dq1, q2, dq2, signal_Gain]=expData_3();
theta_C = calc_const(Time, q1, dq1, q2, dq2, signal_Gain);

% Calculating overall theta by averaging the previously computed values:
theta=(theta_A+theta_B+theta_C)/3;


%% Balancing control
% (This will probably be implemented in another function later.)
% System linearization for balancing control:
[A,B]=linearization(eq_point);

Q=[1 0 0 0;...
   0 0 0 0;...
   0 0 1 0;...
   0 0 0 0];

R=1;

Keq = lqrd(A, B, Q, R,T);

%% Simulation
% initial conditions:
initials=[-pi/2 0 0 0];

% Timestamp:
timestamp = 0:0.01:5;

% Solving:
% We use ode45 function to solve the dynamics of the robot, and therefore
% get the several values of the state variable regarding the time. The
% dynamic and the controler caracteristics are defined in the "swing()"
% function.
[t, States] = ode45(@swing, timestamp, initials);

% Save the states values:
angle_1    = States(:,1);
%angle_1dot = States(:,2);
angle_2    = States(:,3);
%angle_2dot = States(:,4);

% Plot angle of link 1 with y axis and the angle of link2 with link1 
% regarding the time:
figure;
plot(t, angle_1);
hold all
plot(t, angle_2);
hold all
title('Angles of the pendubot over the time to perform a swing');
xlabel('Time');
ylabel('Angle (rad)');
figure;
anim_pendubot(angle_1, angle_2);
