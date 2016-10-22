classdef packet
    %PACKET このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties
        id
        size
        data                % bit sequence for en/decoding simulation
        originalData        % used for calculating BER
        BER                 % bit error rate
        isError
        type                % packet type (set in the layer generating packet)
        genTime             % packet is generated at which time (set in this file)
        recvTime            % receiving packet at which time
        sourceAddr          % address of node which generated original packet (set in APP layer)
        destAddr            % final destination address, null value means broadcast (set in MAC layer)
        nextHop             % address of node which is the next hop, null value means broadcast (set in MAC layer)
        lastHop             % address of node which is the last (previous) hop (set in MAC layer)
        power               % sending/recving power (W）(set in PHY layer)
        moduMode            % modulate mode, such as 'BPSK' 'QPSK' 'QAM16' 'QAM64'
        isSendUp            % direction, send up or send down
        layer               % layer which is processing packet now
        header              % use this struct to set any attribute
    end
    
    properties (Constant,Hidden)
        pktNum=counter();
    end
    
    methods
        function obj=packet()
            obj.pktNum.incr();
            obj.id=obj.pktNum.value;
            obj.genTime=scheduler.getNow();
            obj.size=0;
            obj.isError=false;
            obj.isSendUp=false;
            obj.header=struct();
        end
    end
    
end

