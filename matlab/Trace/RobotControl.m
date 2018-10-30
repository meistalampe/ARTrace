clc;
clear;

%% Robot Dashboard Control
% Setup Connection
socketPort = 29999;
dClient = tcpip('192.168.201.242',socketPort,'NetworkRole','Client');

% Choose Program
program_name = ' test.urp\n';

% Orders
load = 'load';
play = 'play\n';

% Build Command String
order = strcat(load,program_name);

% Handle Transmisssion
fopen(dClient);
%y = fread(tcpipClient); 
fprintf(dClient,order);
% Processing Pause
pause(0.01);
fprintf(dClient,play);
%x = fread(tcpipClient);
fclose(tcpIpClient); 

% Read out MSG (Ascii to str)
% msg = char(x);
% msg = msg';

%% Robot 3D Grid Control

clc;
clear all;
socketPort = 30002;
tClient = tcpip('192.168.201.242',socketPort,'NetworkRole','Client');

% Orders
move = 'movej ';

% Variable
% position = zeros(1,6);
% for i=1:length(position)
% position(i) = 2-4*rand;
% end

a = 1.4;
v = 1.05;
t = 0;
r = 0;

% Build Command
formatSpec = '%2.2f';
position = [-0.129 -0.324 0.35 3,1 0 1];
command = ['(p[' , num2str(position(1),formatSpec) , ',' , num2str(position(2),formatSpec) , ',' , num2str(position(3),formatSpec) , ',' ...
     , num2str(position(4),formatSpec) , ',' , num2str(position(5),formatSpec) , ',' , num2str(position(6),formatSpec) , ...
      '],' , num2str(a,formatSpec) , ',' , num2str(v,formatSpec) , ')\n'];

send = strcat(move, command);

% Handle Transmisssion
fopen(tClient);
%y = fread(tcpipClient); 
fprintf(tClient,send);
% Processing Pause
% pause(1);
fclose(tClient);

fopen(tClient);
[A,count,msg] = fread(tClient);
fclose(tClient);

