function [ ] = transmission(data,size,dir,tcpObject)
%% Task
% compose data string and transmit to Unity

%% Work
% format = formatSpec;
sepSign = '|';

% prepare coordinates
d_data = [size data];
switch(dir)
    case 'x'
        d_data_str = 'xData|';
    case 'y'
        d_data_str = 'yData|';
    case 'z'
        d_data_str = 'zData|';
end

for i= 1:tSize+1
str = num2str(d_data(i));
% str = num2str(d_data(i),format);
d_data_str = strcat(d_data_str,str);
d_data_str = strcat(d_data_str,sepSign);
end

% transmit data
fopen(tcpObject);
fwrite(tcpObject,d_data_str);
fclose(tcpObject); 
end

