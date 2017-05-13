function output = describe(data, varargin)

%%%%%%%
% Create an InputParser
p = inputParser;

p.addRequired('data');
p.addOptional('id',num2cell(1:size(data,2)));
% p.addParameter('title','Default title');


p.parse(data,varargin{:})
inputs = p.Results;
%%%%%%%


% I) central tendency characteristics
% a) mean
output(1,:) = mean(inputs.data);
% b) median
output(2,:) = median(inputs.data);
% c) first and third quantiles
output(3,:) = quantile(inputs.data, .25);
output(4,:) = quantile(inputs.data, .75);

% II) dispersion characteristics
% a) range
output(5,:) = max(inputs.data) - min(inputs.data);
% b) variance
output(6,:) = var(inputs.data);
% c) standard deviation
output(7,:) = std(inputs.data);
% round to 2 digits
output = round(output, 2);

