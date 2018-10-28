% title:    Control.m
% author:   Dominik Limbach
%           Htw Saar

% last edited:  28.10.18
% description:  program allows value changes of key variables to control
%               vr and sends data to unity

%% Connection
clc;
clear;

% create tcp object, set Port,assign Networkrole Client 
% use this when on the same pc
tcpipClient = tcpip('127.0.0.1',8888,'NetworkRole','Client');
% use this in a network
%tcpipClient = tcpip('192.168.0.106',7000,'NetworkRole','Client');
set(tcpipClient,'Timeout',30);

%% Input

% input prompts
prompt_input = 'Input target position [x y z] and confirm pressing [Enter].\n';
prompt_fail = 'Invalid input please try again. \n';

% input verification
valid_input = false;

while valid_input == false
    fprintf('TRACE CONTROL PROGRAM \n' );
    fprintf('******************** \n');
    inp_pos = input(prompt_input); 
    % find a way to int check            
        if(length(inp_pos) == 3) 
            valid_input = true;               
            fprintf('Valid Input. Calculating trace...\n');                                        
        else
            valid_input = false;
            fprintf('Invalid input. Please try again. \n');
        end
end
%% Trace Calculation
 
% define target position coordinates
pos_target = inp_pos;
%  x_target = pos_target(1);
%  y_target = pos_target(2);
%  z_target = pos_target(3);
 
% define start position coordinates
pos_start = [0 0 0]; % will be automatic input from robot in the future
%  x_start = pos_start(1);
%  y_start = pos_start(2);
%  z_start = pos_start(3);
 
% define reference point coordinates
pos_ref = [0 5 0]; % will be calculated according to start and goal position and ideally live on the unit circle
 
% calculate an plot trace
[x_trace,y_trace,z_trace,points,tSize] = calcTrace(pos_start,pos_target,pos_ref);
 
%% Trace Transmission
% transmit trace to Unity


xdata = [tSize,x_trace,y_trace,z_trace];

fopen(tcpipClient);
fwrite(tcpipClient,xdata);
fclose(tcpipClient);
 