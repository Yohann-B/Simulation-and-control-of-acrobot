function [D, C, G] = calc_matrix(q1, dq1, q2, dq2)

global theta g;

% Constants:
theta_1= theta(1,1);
theta_2= theta(2,1);
theta_3= theta(3,1);
theta_4= theta(4,1);
theta_5= theta(5,1);

%% Dynamics of the pendubot:

% Inertia matrix
d11 = theta_1+theta_2+2*theta_3*cos(q2);
d12 = theta_2+theta_3*cos(q2);
d21 = theta_2+theta_3*cos(q2);
d22 = theta_2;
D = [d11 d12; d21 d22];

% Cetripetal/Coriolis matrix
c11 = -theta_3*sin(q2)*dq2;
c12 = -theta_3*sin(q2)*dq2-theta_3*sin(q2)*dq1;
c21 = theta_3*sin(q2)*dq1;
c22 = 0;
C = [c11 c12; c21 c22];

% Gravity matrix
g1 = theta_4*g*cos(q1)+theta_5*g*cos(q1+q2);
g2 = theta_5*g*cos(q1+q2);
G = [g1; g2];

end
