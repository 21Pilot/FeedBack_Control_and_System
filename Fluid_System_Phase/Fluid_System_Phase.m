close all; clear all; clc;
 
%% Control 2_1 MATLAB
% Seo, Jun, Blank

%% parameters
R = 100; C1 = 2; C2 = 1; T = 400; rho_g = 1;
tau1 = R * C1; tau2 = R * C2;
 
%% graph "h1,h2 vs t"
x0 = [125 50];
figure(1)
phaseplot(@(t,y) fluid_system(t,y,tau1,tau2), [0 150 30], [0 150 30], x0, T)
 
[time, state] = ode45(@(t,y) fluid_system(t,y,tau1,tau2), [0 T], x0, []);
figure(2), plot(time,state), legend('h_1', 'h_2')
xlabel('Time'); ylabel('h1, h2')
axis ([0 T 0 150])
 
%% Introduction of rate Q_in
a = [-1/tau1 1/tau1;
    1/tau2 -1/tau2];
b = [1/(C1*rho_g);
    0];
c = [1 0; 0 1];
d = [0; 0];
sys = ss(a,b,c,d);
 
figure(3)
[y,t,x] = step(sys, T); ylim([0 300]);
plot(t,y(:,1),t,y(:,2),'--')
 
 
xlabel('time'); ylabel('level'); legend('h1','h2');
title('IC response')

% Control 2_2

clear all; close all; clc;
 
%% Parameters
R = 100000; C = 1e-6; 
tau = R*C/2; K = 0.5;
 
a = -1/tau; b = K/tau;
sys = ss(a,b,1,0);
 
%% Step response
T = 0.6;
[y,t] = step(sys,T);
figure(), plot(t,y);
title('Step Response');
xlabel('Time [s]'); ylabel('Vout [V]');

% Control 2_3


clear all; close all; clc;
 
t = linspace(0,5);
y = 2/3*(1 - exp(-3.*t));
figure; plot(t,y);
xlabel("Time"); ylabel("Output");
text(0.33,0.42,'\leftarrow (\tau, y(\tau))');
hold on;
plot(t,t.*0+2/3, '--k');
text(0.2,0.65,'K=2/3');
hold off;


% Control 2_4

clear all; close all; clc;
 
Tfinal = 15;
%% System in ss
A = [0 1; -0.5 -1];
B = [0; 1];
C = eye(2);
D = 0;
sys = ss(A ,B ,C , D );
%% pole zero map
figure , pzmap ( sys )
axis ([ -1 1 -1 1])
%% IVP
y0 = [0; 2];
[y, t, x] = initial (sys, y0, Tfinal);
figure, plot (t, y(:,1), t, y(:,2) , '--') , legend ('y','ydot')
xlabel ('Time'); ylabel ('Output')
title ('IC response')

function a = phaseplot(odefun, xlimv, ylimv, xinit, T, varargin)
 
% Initialize the color grid
color = ['m', 'c', 'r', 'g', 'b', 'k', 'y'];
 
% Figure out the set of points for the quiver plot
[x1,x2] = meshgrid(xlimv(1):(xlimv(2)-xlimv(1))/xlimv(3):xlimv(2), ylimv(1):(ylimv(2)-ylimv(1))/ylimv(3):ylimv(2));
 
% Figure out if we have parameter arguments and create the required string
if (length(varargin) == 0)
  parms = '';
else
  parms = ', []';
  for (k = 1:length(varargin))
    parms = strcat(parms, sprintf(', %g', varargin{k}));
  end;
end;
 
% Now calculate the vector field at those points
[nr,nc] = size(x1);
dx = zeros(nr,nc,2);
for i = 1:nr
  for j = 1:nc
%     eval(['dx(' num2str(i) ',' num2str(j) ',1:2) = ' ...
%   odefun '(0, [' num2str(x1(i,j)) ' ' num2str(x2(i,j)) ']' parms ');']);
    dx(i,j,1:2) = odefun(0, [x1(i,j) x2(i,j)]);
 
  end
end
 
% Plot the quiver plot
% clf; 
xy=quiver(x1,x2,dx(:,:,1),dx(:,:,2));
set(xy,'LineWidth',1);
a=gca; set(a,'DataAspectRatio',[1,1,1]);
set(a,'XLim',xlimv(1:2)); set(a,'YLim',ylimv(1:2));
xlabel('h_1'); ylabel('h_2','Rotation',0);
 
% See if we should also generate the streamlines
if (nargin < 4) return; end

% See if we were passed a simulation time
if (nargin < 5) T = 50; end
 
% Generate the streamlines for each initial condition
[nr, nc] = size(xinit);
for i = 1:nr
    xinit(i,:)
    
  [time, state] = ode45(odefun, [0 T], xinit(i,:), [], varargin{:});
  hold on;
  plot(state(:,1), state(:,2), color(mod(i-1, 7)+1));
end
set(a,'XLim',xlimv(1:2)); set(a,'YLim',ylimv(1:2));


