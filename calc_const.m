function theta = calc_const(Time, q1, dq1, q2, dq2, signal_Gain)
% This function will calculates the ssytems constants teta_1,...,teta_5.
% It uses an energy equation method.
% Calling it at each process of the simulation should give us the ability
% to change the system variables (put an object on the last arm for 
% example) without having any issues.
global g;

dq1(1)=0;
dq1(2)=0;
dq1(3)=0;
dq2(1)=0;
dq2(2)=0;
dq2(3)=0;

dL1=.5.*dq1.^2;
dL2=.5.*dq1.^2+dq1.*dq2+.5.*dq2.^2;
dL3=cos(q2).*(dq1.^2+dq1.*dq2);
dL4=g.*sin(q1);
dL5=g.*sin(q1+q2);

taudq1= signal_Gain.*dq1*0.4125*2.68;


for i=1:(length(dL1)-10)
    DL(i,1)=dL1(i+10)-dL1(i);
    DL(i,2)=dL2(i+10)-dL2(i);
    DL(i,3)=dL3(i+10)-dL3(i);
    DL(i,4)=dL4(i+10)-dL4(i);
    DL(i,5)=dL5(i+10)-dL5(i);
    Itq(i,1)=trapz(Time(i:i+10),taudq1(i:i+10));
end

theta=lsqnonneg(DL, Itq);
end
