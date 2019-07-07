function [A, B] = linearization(eq_val)

% This function takes the teta that characterize the system and the value
% of the state variables to return the matrices A and B in the following
% system: dX/dt=Ax+Bu
% Every expressions of the non 0/1 coefficient is processed by hand and
% written in matlab after.
% g is the gravity of the system. We call it from outside because there are
% some unit choices that impact teta also. We prefer the user to give its
% own standards.

% Warning : The matrices A and B are written for the following state
% vector: (x1, x2, x3, x4)T, where x1=q1, x2=q1dot, x3=q2, x4=q2dot.
global g theta;

%% Getting the datas from the parameters
% Not absolute necessity, just to be clearer.
t1= theta(1,1);
t2= theta(2,1);
t3= theta(3,1);
t4= theta(4,1);
t5= theta(5,1);

q1eq = eq_val(1,1);
q2eq = eq_val(2,1);


% den is the denominator value which is common to all of the expression
% (because of the inversion of the inertia matrix).
den = t2*(t1+t2+2*t3*cos(q2eq))-(t2+t3*cos(q2eq))*(t2+t3*cos(q2eq));

%% Calculating matrice A
% We will only look for the values of a21, a23, a41, a43.

a21 = (t2*t4*g*sin(q1eq)+t2*t5*g*sin(q1eq+q2eq)...
    -(t2+t3*cos(q2eq))*t5*g*sin(q1eq+q2eq))/den;

a23 = (-(-t2*t5*g*sin(q1eq+q2eq)*den...
    +(2*t2*t3*sin(q2eq)-2*t3*sin(q2eq)*(t2+t3*cos(q2eq)))...
    *(t2*t4*g*cos(q1eq)+t2*t5*g*cos(q1eq+q2eq)))...
    +(-t2*t5*g*sin(q1eq+q2eq)-t3*t5*g*sin(q2eq)*cos(q1eq+q2eq)...
    -t3*t5*g*cos(q2eq)*sin(q1eq+q2eq))*den...
    +(2*t2*t3*sin(q2eq)-2*t3*sin(q2eq)*(t2+t3*cos(q2eq)))...
    *(t2*t5*g*cos(q1eq+q2eq)+t3*t5*g*cos(q2eq)*cos(q1eq+q2eq)))/(den*den);

a41 = (-(t2+t3*cos(q2eq))*(t4*g*sin(q1eq)+t5*g*sin(q1eq+q2eq))...
    +(t1+t2+2*t3*cos(q2eq))*t5*g*sin(q1eq+q2eq))/den;

a43 = ((-t4*t3*g*cos(q1eq)*sin(q2eq)-t2*t5*g*sin(q1eq+q2eq)...
    -t3*t5*g*sin(q2eq)*cos(q1eq+q2eq)-t3*t5*g*cos(q2eq)*sin(q1eq+q2eq))*den...
    +(2*t2*t3*sin(q2eq)-2*t3*sin(q2eq)*(t2+t3*cos(q2eq)))...
    *(t2+t3*cos(q2eq))*(t4*g*cos(q1eq)+t5*g*cos(q1eq+q2eq))...
    +(t1*t5*g*sin(q1eq+q2eq)+t2*t5*g*sin(q1eq+q2eq)...
    +2*t3*t5*g*sin(q2eq)*cos(q1eq+q2eq)+2*t3*t5*g*cos(q2eq)*sin(q1eq+q2eq))...
    *den -(2*t2*t3*sin(q2eq)-2*t3*sin(q2eq)*(t2+t3*cos(q2eq)))...
    *(t1+t2+2*t3*cos(q2eq))*t5*g*cos(q1eq+q2eq))/(den*den);

A= [ 0  1  0  0;...
    a21 0 a23 0;...
    0   0  0  1;...
    a41 0 a43 0];

%% Calculating matrice B

b12 = t2 / den;
b14 = -(t2+t3*cos(q2eq))/den;

B= [0;...
    b12;...
    0;...
    b14];

end



