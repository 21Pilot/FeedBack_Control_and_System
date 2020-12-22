
clear all; close all; clc

%% Flora, Andrew and Shawn

%% a) the equilibrium points are =  when xdot and ydot are 0, 
x = (gamma/ delta) and y = (alpha/beta)
%% b) with a=b=c=d= 1,  x=1 and y =1
%% c) phase portrait 
 
a=1;
b=1;
c=1;
d=1;
 
[x,y] = meshgrid(0:0.2:2,0:0.2:2);
xdot = a .* x - b .* x .* y;
ydot = c .* x .* y - d .* y;
 
figure
quiver(x,y,xdot,ydot)

%% d)
%% initial condition 1
 
x0= 1;
y0= 1;
 
syms x(t) y(t) T Y 
 
Eqns = [diff(x(t),t) == (x - x * y);
        diff(y(t),t) == (x * y - y)];
    
[DEsys, Subs] = odeToVectorField(Eqns);
 
DEfcn = matlabFunction(DEsys, 'Vars', {T, Y});
tspan = linspace (0, 40, 250);
Y0 = [x0; y0];
[T,Y] = ode45(DEfcn, tspan, Y0);
 
figure
grid on
plot (T, Y)
legend ('x(t)', 'y(t)')
 
%% e)
%% initial condition 2
 
x0= 2;
y0= 2;
 
syms x(t) y(t) T Y 

%% f)
%% plot (t, x+y) 
x0= 2;
y0= 2;
syms x(t) y(t) T Y 
 
Eqns = [diff(x(t),t) == (x - x * y);
        diff(y(t),t) == (x * y - y)];
    
[DEsys, Subs] = odeToVectorField(Eqns);
DEfcn = matlabFunction(DEsys, 'Vars', {T, Y});
tspan = linspace (0, 40, 250);
Y0 = [x0; y0];
[T,Y] = ode45(DEfcn, tspan, Y0); 
figure
grid on
plot (T, Y(:,1)+ Y(:, 2))
legend ('x+y', 't')

 
Eqns = [diff(x(t),t) == (x - x * y);
        diff(y(t),t) == (x * y - y)];
    
[DEsys, Subs] = odeToVectorField(Eqns);
 
DEfcn = matlabFunction(DEsys, 'Vars', {T, Y});
tspan = linspace (0, 40, 250);
Y0 = [x0; y0];
[T,Y] = ode45(DEfcn, tspan, Y0);
 
figure
grid on
plot (T, Y)
legend ('x(t)', 'y(t)')

