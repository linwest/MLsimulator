function parameter = defaultConfig( className )
%DEFAULTCONFIG この関数の概要をここに記述
%   詳細説明をここに記述
    
    switch className
        case 'baseNode'
            parameter.traceMAC=true; 
            parameter.tracePHY=true;
        case 'baseAPP'
            parameter=[];   
        case 'baseDLL'
            parameter.para_queue=defaultConfig('queue');            
        case 'baseMAC'
            parameter=[];
        case 'basePHY'
            parameter.X=0;
            parameter.Y=0;
            parameter.Z=0;
            parameter.power=0.1; 
        case 'powerMonitor'
            parameter.thresh=2.653e-14; % -105.7dBm
            parameter.CSThresh=1.559e-11; % channel sensing threshold
        case 'queue'
            parameter.maxLen=100;
            parameter.type='DropTail';
        case 'wireless'
            parameter.noisePower=7.96159e-14; % -101dBm
            parameter.centerFreq=5.0e9;       % 5GHz
            
        case 'cbr'
            parameter=defaultConfig('baseAPP'); % get parameters of superclass first
            parameter.randStartTime=true;      % start generate packet at 0s or a rand time
            parameter.pktSize=1460;             % Byte
            parameter.interval=0.01;            % s
            parameter.pktType='FRAME';          % 'FRAME' or 'SEQUENCE'
        case 'IEEE802_11MAC'
            parameter=defaultConfig('baseMAC'); % get parameters of superclass first
            parameter.type='STA';
            parameter.headerDuration=20e-6;  % 20 us headerDuration for PHY preamble
            parameter.symbolDuration=4e-6;   %  4 us
            parameter.slotTime=9e-6;        %  9 us
            parameter.SIFS=16e-6;           % 16 us
            parameter.maxPropagationDelay=10e-6;        % 10 us
            parameter.CWmin=15;
            parameter.CWmax=1023;
            parameter.RTSthreshold=1000;
            parameter.shortRetryLimit=7;    
            parameter.longRetryLimit=4;
            parameter.RTSlen=20;  % Byte 
            parameter.CTSlen=14;  % Byte      
            parameter.ACKlen=14;  % Byte   
            parameter.FCSlen=4;  % Byte   
            parameter.MACheaderLen=30;  % Byte   length of MAC header 
        case 'IEEE802_11PHY'
            parameter=defaultConfig('basePHY'); % get parameters of superclass first
            parameter.recaptureSwitch=true;    % whether recapture new packet with higer SINR
            %%%%%%%%%%%%%%%%% example for convolutional code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             parameter.codeParameter.type='CC'; % use which code
%             parameter.codeParameter.code_book=[0 1;  
%                                                1 1]; 
%             parameter.codeParameter.feedback=[];
            %%%%%%%%%%%%%%%%% example for turbo code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            parameter.codeParameter.type='TURBO'; % use which code
            parameter.codeParameter.rate='1/3';
            parameter.codeParameter.interleave_mode='RANDOM';
            parameter.codeParameter.iter_time=3;
            
            parameter.codeParameter.type1='CC';
            parameter.codeParameter.code_book1=[1 1]; % first row is omitted because always is the original data
            parameter.codeParameter.feedback1=[];

            parameter.codeParameter.type2='CC';
            parameter.codeParameter.code_book2=[1 1];
            parameter.codeParameter.feedback2=[];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        otherwise
            parameter=[];
    end

end

