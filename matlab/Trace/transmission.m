function [d_data_str] = transmission(data,size,dir,tcpObject,t_type)
%% Task
% compose data string and transmit to Unity

%% Work
format = '%4.2f';
sepSign = '|';

switch(t_type)
    case 1
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

        for i= 1:size+1
        %str = num2str(d_data(i));
        str = num2str(d_data(i),format);
        d_data_str = strcat(d_data_str,str);
        d_data_str = strcat(d_data_str,sepSign);
        end
    
    case 2
        size_alt = 2;
        d_data = [size_alt data];
        
        switch(dir)
            case 'x'
                d_data_str = 'xData|';
            case 'y'
                d_data_str = 'yData|';
            case 'z'
                d_data_str = 'zData|';
        end
        
        for i= 1:size_alt+1
        %str = num2str(d_data(i));
        str = num2str(d_data(i),format);
        d_data_str = strcat(d_data_str,str);
        d_data_str = strcat(d_data_str,sepSign);
        end
end
% transmit data
fopen(tcpObject);
fwrite(tcpObject,d_data_str);
fclose(tcpObject); 
end

