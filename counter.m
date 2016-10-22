classdef (Sealed) counter < handle
    %COUNTER このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties
        value
    end
    
    methods
       function obj=counter()
           obj.value=0;
       end
       
       function reset(obj)
           obj.value=0;           
       end
       
       function obj=incr(obj)
            obj.value=obj.value+1;
       end
              
       function obj=decr(obj)
            obj.value=obj.value-1;
       end
    end
    
end

