classdef (Sealed) counter < handle
    %COUNTER ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
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

