function[ref_point, mid_point] = findRefPoint(start_point,end_point)

%% Note
% start_point can not be [0 0 0] !!!

%% Work

% assign points
p1 = start_point;
p2 = end_point;
% get grid coordinates
x = [p1(1) p2(1)];
y = [p1(2) p2(2)];
z = [p1(3) p2(3)];
% calculate distance
sub = p2-p1;
dist = sqrt(sub(1).^2 + sub(2).^2 + sub(3).^2);
% find center of points
mid = sub ./2 + p1;
mid_point = mid;
% find normal vector
kp = cross(p1,p2);
% calculate the norm
kpn = kp/norm(kp);

if dist >= 0 && dist <= 5
    dist_factor = 1;
elseif dist > 5 && dist <= 15
    dist_factor = 2;
else
    dist_factor = 3;
end

% create reference point
kpv = mid + dist_factor*kpn;
ref_point = kpv;
% build line from mid to ref 
dv = [mid(1) kpv(1);mid(2) kpv(2);mid(3) kpv(3)];
%% plot

figure(100)
hold on;
plot3(x,y,z);
plot3(mid(1),mid(2),mid(3),'ro');
plot3(dv(1,:),dv(2,:),dv(3,:));
plot3(kpv(1),kpv(2),kpv(3),'ro');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
hold off;
end
