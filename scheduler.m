classdef scheduler < handle
    %SCHEDULER このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties
        nodeList
        Channel
        traceFile
    end
        
    properties (Constant,Hidden)
        EventList=driver.eventList;
        Clock=driver.clock;
    end
    
    methods
        function obj = scheduler()
            obj.init();
        end
        
        function init(obj)
            obj.nodeList=[];
            obj.Channel=[];
            obj.traceFile=[];
            obj.EventList.init();
            obj.Clock.init();
            driver.timer.timerNum.reset();
            packet.pktNum.reset();
            node.baseNode.nodeNum.reset();
        end
        
        function Channel = createChannel(obj,ch_type,parameter)
            if nargin == 2
                parameter=defaultConfig(ch_type);
            end
            obj.Channel=eval(strcat('channel.',ch_type,'()'));
            obj.Channel.config(parameter);
            Channel=obj.Channel;
        end
        
        function Node = createNode(obj,node_type,parameter)            
            if nargin == 2
                parameter=defaultConfig(node_type);
            end
            Node=eval(strcat('node.',node_type,'()'));
            Node.config(parameter);
            obj.nodeList(Node.id).Node=Node;
        end
        
        function Node = getNode(obj,id_)
            Node=obj.nodeList(id_).Node;
        end
        
        % set simulation end time
        function setEndTime(obj,time_)
            obj.EventList.endTime=time_;
        end
        
        % run the scheduler to start simulation
        function run(obj)
            disp('Simulation start');
            if isempty(obj.traceFile)
                obj.traceFile=1;
            else
                obj.traceFile = fopen(obj.traceFile,'wt');
            end
            fprintf(obj.traceFile,'%s%s\n','time | [node id] | action | layer | packet id | ', ...
                'packet generated time | packet size | packet type | direction');
            obj.EventList.exeEvent();       
            fclose(obj.traceFile);
            disp('Simulation end');
        end
    end
    
    methods (Static)
        % get global Scheduler Object
        function obj=getThis()
            global Scheduler;
            if ~isempty(Scheduler)      
                obj=Scheduler;
            else
                Scheduler=scheduler();
                obj=Scheduler;
            end
        end        
        
        function now_=getNow()
            global Scheduler;
            now_=Scheduler.Clock.now;
        end
    end
    
end

