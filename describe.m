classdef describe2 < handle
    
    properties
        inputs
    end
    
    methods
        
        function obj = describe2(data, varargin)
            p = inputParser;
            
            p.addRequired('data', @isnumeric);
            p.addOptional('id', num2cell(1:size(data,2)), @iscell);
            p.addParameter('plotstyle', 'all', @ischar);
            
            p.parse(data, varargin{:})
            obj.inputs = p.Results;
        end
        
        function T = charac(obj)
            T = table(mean(obj.inputs.data)',...
                median(obj.inputs.data)',...
                quantile(obj.inputs.data, .25)',...
                quantile(obj.inputs.data, .75)',...
                (max(obj.inputs.data) - min(obj.inputs.data))',...
                var(obj.inputs.data)',...
                std(obj.inputs.data)',...
                'VariableNames',{'mean', 'median', 'Q1', 'Q3', 'range', 'variance', 'std'},...
                'RowNames',obj.inputs.id');
            
            T{:,:} = round(T{:,:}, 2);
        end
        
        function boxplot(obj)
            figure
            switch obj.inputs.plotstyle
                case 'all'
                    boxplot(obj.inputs.data, 'labels', {obj.inputs.id})
                case 'subplot'
                    colsize = size(obj.inputs.data, 2);
                    for i = colsize : -1 : 1
                        subplot(3, round(colsize/3), i)
                    boxplot(obj.inputs.data(:,i), 'labels', obj.inputs.id{i})
                    end
            end
        end
        
    end
end