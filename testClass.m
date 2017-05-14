classdef testClass
    
    properties % your variables
        Value
    end
    
    methods % your functions
        
        function obj = testClass(val) % the first method is a CONSTRUCTOR (name = class)
            if nargin > 0
                if isnumeric(val)
                    obj.Value = val;
                else
                    error('Value must be numeric')
                end
            end
        end
        
        function r = roundOff(obj)
            r = round([obj.Value],2);
        end
        
        function r = multiplyBy(obj,n)
            r = [obj.Value] * n;
        end
        
        function r = plus(o1,o2)
            r = o1.Value + o2.Value;
        end
        
    end
end