clc;
clear;

% create tcp object, set Port,assign Networkrole Client 
% use this when on the same pc
tcpIpClient = tcpip('192.168.201.242',29999,'NetworkRole','Client');
% use this in a network
%tcpipClient = tcpip('192.168.0.106',7000,'NetworkRole','Client');
% set(tcpipClient,'Timeout',10);

program_name = ' test.urp\n';
load = 'load';
space = ' ';
play = 'play\n';

order = strcat(load,program_name);

fopen(tcpIpClient);
%y = fread(tcpipClient); 
fprintf(tcpIpClient,order);
pause(0.01);
fprintf(tcpIpClient,play);
%x = fread(tcpipClient);
fclose(tcpIpClient); 

% msg = char(x);
% msg = msg';



x = num2str(x);
