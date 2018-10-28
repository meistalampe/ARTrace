% title:        trace.mat
% author:       Dominik Limbach
% date:         28.10.18

% description:  program forms the trace using beziér curves (quadratic and
%               cubic) between starting and target point using a fixed
%               amount of reference points


%% time definition
t = 0:.001:1;

%% quadratic beziér
% basis functions

bq0 = (1-t).^2;
bq1 = 2*t.*(1-t);
bq2 = t.^2;

% point definition [x,y,z]
pq_start = [1,0,1];
pq_target = [0,2,0];
pq_ref = [-2,5,1];

% coordinate definition
% x coordinate
xq = pq_start(1)*bq0 + pq_target(1)*bq1 + pq_ref(1)*bq2;
% y coordinate
yq = pq_start(2)*bq0 + pq_target(2)*bq1 + pq_ref(2)*bq2;
% z coordinate
zq = pq_start(3)*bq0 + pq_target(3)*bq1 + pq_ref(3)*bq2;

% trace defintion
% Trace = [xq(t),yq(t),zq(t)]

% control points
pq_control = [pq_start ; pq_target ; pq_ref];


%% cubic beziér
% basis functions
bc0 = (1-t).^3;
bc1 = 3*t.*(1-t).^2;
bc2 = 3*(t.^2).*(1-t);
bc3 = t.^3;

% point definition [x,y,z]
pc_start = [1,0,1];
pc_target = [0,2,0];
pc_ref1 = [-2,5,1];
pc_ref2 = [-5,2,0];

% coordinate definition
% x coordinate
xc = pc_start(1)*bc0 + pc_target(1)*bc1 + pc_ref1(1)*bc2 + pc_ref2(1)*bc3;
% y coordinate
yc = pc_start(2)*bc0 + pc_target(2)*bc1 + pc_ref1(2)*bc2 + pc_ref2(2)*bc3;
% z coordinate
zc = pc_start(3)*bc0 + pc_target(3)*bc1 + pc_ref1(3)*bc2 + pc_ref2(2)*bc3;

% trace defintion
% Trace = [xc(t),yc(t),zc(t)]

% control points
pc_control = [pc_start ; pc_target ; pc_ref1 ; pc_ref2];



%% plot

% quadratic beziér
sumq = bq0 + bq1 + bq2;

% basic functions
figure(1);
hold on;
title('quadratic beziér');
plot(t,bq0);
plot(t,bq1);
plot(t,bq2);
plot(t,sumq);
legend('bq0','bq1','bq2','sum');
hold off;
% trace
figure(2);
hold on;
plot3(xq,yq,zq);
plot3(pq_control(:,1),pq_control(:,2),pq_control(:,3),'LineStyle','none','Marker','o');
title('Trace : quadratic beziér')
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
hold off;

% cubic beziér
sumc = bc0 + bc1 + bc2 + bc3;

%basic functions
figure(3);
hold on;
title('cubic beziér');
plot(t,bc0);
plot(t,bc1);
plot(t,bc2);
plot(t,bc3);
plot(t,sumc);
legend('bc0','bc1','bc2','bc3','sum');
hold off;
%trace
figure(4);
hold on;
plot3(xc,yc,zc);
plot3(pc_control(:,1),pc_control(:,2),pc_control(:,3),'LineStyle','none','Marker','o');
title('Trace : cubic beziér')
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
hold off;