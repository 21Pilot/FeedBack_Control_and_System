# Design state feedback controllers of the form u = -Kx,  K is chosen by pole placement. 
# Compute K : 
# -55i, -10
# -55i, -200
# -11i, -10

# Flora Hyomin Seo

# Subsection A 

A = [-200 -15 -12;32 0 0;0 8 0];
B = [2 0 0]';
C = [0 0 1];
D = 0;
[b,a] = ss2tf(A,B,C,D);
sys = tf(b,a)
%% pole placement 
p1 = [-5+5*1i -5-5*1i -10 ];
K1 = place(A,B,p1)
 
p2 = [-5+5*1i -5-5*1i -200];
K2 = place(A,B,p2)
 
p3 = [-1+1*1i -1-1*1i -10];
K3 = place(A,B,p3)

# Subsection B 

A = [-200 -15 -12;32 0 0;0 8 0];
B = [2 0 0]';
C = [0 0 1];
D = 0;
[b,a] = ss2tf(A,B,C,D);
sys = tf(b,a)
sys = tf(b,a)   
figure;step(sys); 
xlabel('step 1');
figure;bode(sys) ;
xlabel('bode 1');
%% Pole placement 1
p = [-5-5*i,-5+5*i,-10];
K = place(A,B,p);
L = ss(A,B,K,0); 
T = feedback(L,1);
figure, step(T)
figure, rlocus(L)
xlabel('1');
ylabel('1');
figure, nyquist(L)
ylabel('1');
 
%% Pole placement 2
p = [-5-5*i,-5+5*i,-200];
K = place(A,B,p);
L = ss(A,B,K,0);
T = feedback(L,1);
figure, step(T)
figure, rlocus(L)
xlabel('2');
ylabel('2');
figure, nyquist(L)
ylabel('2');
%% Pole placement 3
p = [-1-1*i,-1+1*i,-10];
K = place(A,B,p);
L = ss(A,B,K,0);
T = feedback(L,1);
figure, step(T)
figure, rlocus(L)
xlabel('3');
ylabel('3');
figure, nyquist(L)
ylabel('3');
