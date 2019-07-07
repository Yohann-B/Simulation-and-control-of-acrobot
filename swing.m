function dstate = swing(t, state)

global sw Keq theta g;

% We have to second order equations we want to solve.
% We are going to set up the variables we are using in those equations and
% give everything to ode to solve the equations of the pendubot.

%% Setting up:
% We will define 4 state variable for the system: q1 and q2 which are the
% angles of the two links with the x axis, dq1dt and dq2dt which are the 
% time derivate of those two variables:
q1    = state(1);
q1dot = state(2);
q2    = state(3);
q2dot = state(4);

% Setting up the desired positions of angle q1des and q2des:
if strcmp(sw,'up')
    q1des = pi/2;
    q2des = 0;
elseif strcmp(sw, 'mid')
    if t<1*2*pi/5
        q1des = 1.4*sin(5*t)-pi/2;
    else
        q1des = -pi/2;
    end
    q2des = pi;
end

%

%% Matrices calculation:
[D, C, G] = calc_matrix(q1, q1dot, q2, q2dot);

% Simplifying the writing of matrices' coefs:
d11 = D(1,1); d12 = D(1,2);
d21 = D(2,1); d22 = D(2,2);

c11 = C(1,1); c12 = C(1,2);
c21 = C(2,1); c22 = C(2,2);

g1 = G(1,1);
g2 = G(2,1);

d11_bis = d11-(d12*d21)/d22;
c11_bis = c11-(d12*c21)/d22;
c12_bis = c12;
g1_bis = g1-(d12*g2)/d22;

Dden =(d11*d22-d12*d21);
Dinv11 = d22/Dden;
Dinv12 = -d12/Dden;
Dinv21 = -d21/Dden;
Dinv22 = d11/Dden;

Keq1=Keq(1,1);
Keq2=Keq(1,2);
Keq3=Keq(1,3);
Keq4=Keq(1,4);

%% Control of the movement

% Equilibrium condition:
% tau_eq=theta(4,1)*g*cos(q1des); = 0 for our situations.

% We will use a proportionnal-derivate controller with the following values
% for Kd and Kp:
if strcmp(sw, 'up')
    Kp=99.873;%99.873
    Kd=15;%15
       
elseif strcmp(sw, 'mid')

    Kp=118;%124.1655
    Kd=15;
    
end

if abs(q1des-q1)<0.1 && abs(q2des-q2)<0.2
    tau = -(Keq1*(q1-q1des)+Keq2*q1dot+Keq3*(q2-q2des)+Keq4*q2dot);
    
else
	% v is the lambda, it's basically the value that comes out of the
    % controller into the system:
    v = Kp*(q1des-q1)-Kd*q1dot;

    % Inner loop control:
    tau = d11_bis*v+c11_bis*q1dot+c12_bis*q2dot+g1_bis;
end

%% Computation of the new position:
% We use the state equations of the system to define all system's state:

    dS(1)=q1dot;
    dS(2)= Dinv11*(tau-g1-c11*q1dot-c12*q2dot)-Dinv12*(g2+c21*q1dot+c22*q2dot);

    dS(3)=q2dot;
    dS(4)= Dinv21*(tau-g1-c11*q1dot-c12*q2dot)-Dinv22*(g2+c21*q1dot+c22*q2dot);

dstate=[dS(1); dS(2); dS(3); dS(4)];

end
