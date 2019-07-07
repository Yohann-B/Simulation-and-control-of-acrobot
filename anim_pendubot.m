function anim_pendubot(q1, q2)

nbr=length(q1);

O = [0 0];
axis(gca, 'equal');
axis([-7 7 -7 7]);
grid off;
title('Animation pendubot');
L1 = 2;
L2 = 2.5;

for i=1:nbr
   
    
    P1= [L1*cos(q1(i,1)) L1*sin(q1(i,1))];
    
    P2= [L1*cos(q1(i,1))+L2*cos(q1(i,1)+q2(i,1)), ...
        L1*sin(q1(i,1))+L2*sin(q1(i,1)+q2(i,1))];
     
    link1=line([O(1) P1(1)], [O(2) P1(2)], 'lineWidth', 2);
    link2=line([P1(1) P2(1)], [P1(2) P2(2)], 'lineWidth', 2);
    O_circ = viscircles(O, 0.01);
    ball1 = viscircles(P1, 0.05);
    ball2 = viscircles(P2, 0.05);
    
    pause(0.005);
    
    if i<nbr
        delete(link1);
        delete(link2);
        delete(ball1);
        delete(ball2);
        delete(O_circ);
    end
end
end