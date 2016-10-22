% Designed by linwest@vip.qq.com
function main
%MAIN この関数の概要をここに記述
%   詳細説明をここに記述
    clc;
%     rand('seed',100);
%     randn('seed',100);
for simulationTimes = 1:10
    disp('============================================');
    Scheduler=scheduler.getThis();
    Scheduler.init();
    Scheduler.createChannel('wireless');    
    Scheduler.setEndTime(1);
    traceFileName=sprintf('trace%d.txt',numel(dir('trace*.txt'))+1);
    Scheduler.traceFile=traceFileName;
    
    cellNum.node=10; % node num for each cell
    cellNum.x=3; % cell num for topology
    cellNum.y=3;
    cellSize.x=50;
    cellSize.y=50;    
    cellPosition.x=cellSize.x/2;
    cellPosition.y=cellSize.y/2;
    ApStaDistance.min=10;
    ApStaDistance.max=cellSize.x/2;    
    
    para_AP=defaultConfig('IEEE802_11MAC');
    para_AP.maxPropagationDelay=max(cellSize.x, cellSize.y)/constants.c; 
    para_STA=para_AP;
    para_AP.type='AP';
    para_STA.type='STA';
    
    para_PHY=defaultConfig('IEEE802_11PHY');
    para_PHY.power=0.000001; 
    
    para_cbr=defaultConfig('cbr');
    para_cbr.pktSize=1460;
    para_cbr.interval=0.01;
    para_cbr.pktType='SEQUENCE';
	para_cbr.randStartTime=true;      % start generate packet at 0s or a rand time
    fprintf('CBR rate is %f Mbyte/s\n',para_cbr.pktSize/para_cbr.interval*1e-6);
    
    para_node=defaultConfig('baseNode');
    para_node.tracePHY=false;
    
    for i=1:cellNum.x
        for j=1:cellNum.y
            ap_index=(i-1) * cellNum.y + j;
            AP(ap_index)=Scheduler.createNode('baseNode',para_node);

            %===create and connect layers========
            AP(ap_index).createAPP('cbr',para_cbr);
            AP(ap_index).createDLL('baseDLL');
            AP(ap_index).createMAC('IEEE802_11MAC',para_AP);
            AP(ap_index).createPHY('IEEE802_11PHY',para_PHY);
            AP(ap_index).connectAllLayer();
            %===create and connect layers end====        

            AP(ap_index).setPosition(cellPosition.x,cellPosition.y);
            for k=1:cellNum.node
                sta_index=(ap_index-1) * cellNum.node + k;
                STA(sta_index)=Scheduler.createNode('baseNode',para_node);

                %===create and connect layers========
                STA(sta_index).createAPP('cbr',para_cbr);
                STA(sta_index).createDLL('baseDLL');
                STA(sta_index).createMAC('IEEE802_11MAC',para_STA);
                STA(sta_index).createPHY('IEEE802_11PHY',para_PHY);
                STA(sta_index).connectAllLayer();
                %===create and connect layers end====

                % ======rand node position==========
                distance_tmp=rand()*(ApStaDistance.max-ApStaDistance.min)+ApStaDistance.min;
                offsetX_tmp=rand()*distance_tmp;
                offsetY_tmp=sqrt(distance_tmp^2-offsetX_tmp^2);
                STA(sta_index).setPosition(cellPosition.x+((rand()>0.5)*2-1)*offsetX_tmp,...
                                           cellPosition.y+((rand()>0.5)*2-1)*offsetY_tmp);
                % ======rand node position end======

                %=======connect STA to AP=============
                STA(sta_index).MAC.addRecvNode(AP(ap_index).id);
                AP(ap_index).MAC.addRecvNode(STA(sta_index).id);
                %=======connect STA to AP end=========
            end
            cellPosition.x=cellPosition.x+cellSize.x;
        end
        cellPosition.x=cellSize.x/2;
        cellPosition.y=cellPosition.y+cellSize.y;  
    end 
    Scheduler.run();
    [throughput_, delay_]=addon.netPerformance(traceFileName);
    fprintf('Throughput = %.6fMByte/s. Delay = %.9fs.\n',throughput_*1e-6, delay_);
    
end

end

