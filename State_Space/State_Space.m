close all; clear all; clc;
 
%% Flora Hyomin Seo 
%% State Space
%% 4D-G

% parameters 
% resistors
Ra = 0.02;
Rb = 2.00;
Rc = 2.2;
Rd = 0.2;
Re = 0.02;
% capacitors
C1 = 8700;
C2 = 6200;
C3 = 6600;
C4 = 20000; 
% state space matrix
A1 = [ (-1/C1)*(1/Ra + 1/Rb) (1/C1)*(1/Rb) 0 0 ;
     (1/C2)*(1/Rb) (-1/C2)*(1/Rb + 1/Rc) (1/C2)*(1/Rc) 0];
A2 = [0 (1/C3)*(1/Rc) (-1/C3)*(1/Rc + 1/Rd) (1/C3)*(1/Rd);
     0 0 (1/C4)*(1/Rd) (-1/C4)*(1/Rd + 1/Re) ];
A = [A1; A2]
B = [ 0 ;
      0 ;
      0 ;
     (1/C4)*(1/Re)];
C = eye(4);
D = [ 0;
      0;
      0;
      0 ];
sys = ss(A,B,C,D);
[Y,T] = step(sys);

% state space graph 
figure(1)
plot(T,Y)
legend('T1', 'T2', 'T3', 'T4')
title('step response for all temperature')
xlabel('Time in second ')
ylabel('Temperature in C')
 
%% E)
% time condition 
t = 0:0.1:3600;
% state space graph 
sys = ss(A,B,C,D);
x0 = [ -5;
       -5;
       -5;
       -5 ];
u = -15 - 15*t;
[Y, T] = lsim(sys,u,t,x0);
T1 = Y(:,1)+20;
T2 = Y(:,2)+20; 
T3 = Y(:,3)+20;
T4 = Y(:,4)+20;
figure(2)
plot(T,T1,T,T2,T,T3,T,T4)
legend('T1','T2','T3','T4')
title('state space graph with time condition ')
xlabel('Time in second')
ylabel('Temperature in C')

%% F)
% calculate the poles of the system 
SP=ss(A,B,C,D)
TF=tf(SP)
%poles natural frequnecy and damping 
[wn,zeta,p]=damp(TF)
Ra=0.02;C1=8700
 
% the poles graph shows that 0.0058 is the fastest
% and 0.0001 is the slowest


%% G)
%time constant approximation 
figure(4)
sys = ss(A,B,C,D);
[Y,T] = step(sys);
plot(T,Y(:,1))
title('Step Response for T1')
xlabel('Time in second')
ylabel('Temperature in C')
