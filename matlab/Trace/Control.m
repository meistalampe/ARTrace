% title:    Control.m
% author:   Dominik Limbach
%           Htw Saar

% last edited:  28.10.18
% description:  program allows value changes of key variables to control
%               vr and sends data to unity

%% Init
clc;
clear;
close all;
%% Connection
% create tcp object, set Port,assign Networkrole Client 
% use this when on the same pc
tcpipClient = tcpip('127.0.0.1',8888,'NetworkRole','Client');
% use this in a network
%tcpipClient = tcpip('192.168.0.106',7000,'NetworkRole','Client');
set(tcpipClient,'Timeout',10);

%% Input

% input prompts
prompt_input = 'Input target position [x y z] and confirm pressing [Enter].\n';
prompt_fail = 'Invalid input please try again. \n';

input verification
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
% pos_target = [3 2 1];

% define start position coordinates
pos_start = [1 1 1]; % will be automatic input from robot in the future
 
% check for one dimensional movement
x_check = isequal(pos_start(1),pos_target(1));
y_check = isequal(pos_start(2),pos_target(2));
z_check = isequal(pos_start(3),pos_target(3));
all_check = [x_check y_check z_check];

c(all_check == 1) = 1;
cc = sum(c);
% assign reference point according to movement type
if (cc < 2)
    % define reference point coordinates
    [ref_point,ref_point_alt] = findRefPoint(pos_start,pos_target);
    pos_ref = ref_point;
    [x_trace,y_trace,z_trace,points,tSize] = calcTrace(pos_start,pos_target,pos_ref);
    fprintf('Process successful.\n');
    
    t_type = 1;
    % transmit trace to Unity
    fprintf('Starting data transmission...\n');
    x_data_str = transmission(x_trace,tSize,'x',tcpipClient,t_type);
    y_data_str = transmission(y_trace,tSize,'y',tcpipClient,t_type);
    z_data_str = transmission(z_trace,tSize,'z',tcpipClient,t_type);
    fprintf('Process successful.\n');
    
else 
    
    x_trace = [pos_start(1) pos_target(1)];
    y_trace = [pos_start(2) pos_target(2)];
    z_trace = [pos_start(3) pos_target(3)];
    tSize = 2;
    fprintf('Process successful.\n');
    
    % plot trace    
    figure(100);
    hold on;
    plot3(x_trace,y_trace,z_trace)
    title('Trace : quadratic beziér')
    xlabel('x-axis');
    ylabel('y-axis');
    zlabel('z-axis');
    hold off;
    
    t_type = 2;
    % transmit trace to Unity
    fprintf('Starting data transmission...\n');
    x_data_str = transmission(x_trace,tSize,'x',tcpipClient,t_type);
    y_data_str = transmission(y_trace,tSize,'y',tcpipClient,t_type);
    z_data_str = transmission(z_trace,tSize,'z',tcpipClient,t_type);
    fprintf('Process successful.\n');
end
% calculate an plot trace
% 

%% Trace Transmission


% % prepare x coordinates
% x_data = [tSize x_trace];
% x_data_str = 'xData|';
% sepSign = '|';
% 
% for i= 1:tSize+1
% str = num2str(x_data(i));
% % str = num2str(x_data(i),formatSpec);
% x_data_str = strcat(x_data_str,str);
% x_data_str = strcat(x_data_str,sepSign);
% end
% 
% fopen(tcpipClient);
% fwrite(tcpipClient,x_data_str);
% fclose(tcpipClient); 
% 
% % prepare y coordinates
% y_data = [tSize y_trace];
% y_data_str = 'yData|';
% sepSign = '|';
% 
% for i= 1:tSize+1
% str = num2str(y_data(i));
% y_data_str = strcat(y_data_str,str);
% y_data_str = strcat(y_data_str,sepSign);
% end
% 
% fopen(tcpipClient);
% fwrite(tcpipClient,y_data_str);
% fclose(tcpipClient); 
% 
% % prepare z coordinates
% z_data = [tSize z_trace];
% z_data_str = 'zData|';
% sepSign = '|';
% 
% for i= 1:tSize+1
% str = num2str(z_data(i),formatSpec);
% z_data_str = strcat(z_data_str,str);
% z_data_str = strcat(z_data_str,sepSign);
% end
% 
% fopen(tcpipClient);
% fwrite(tcpipClient,z_data_str);
% fclose(tcpipClient); 
% 
%  