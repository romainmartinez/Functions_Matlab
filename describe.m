function output = describe(input)
top = {'mean', 'median', 'Q1', 'Q3', 'range', 'variance', 'std'};

% I) central tendency characteristics
% a) mean
output(1,:) = mean(input);
% b) median
output(2,:) = median(input);
% c) first and third quantiles
output(3,:) = quantile(input, .25);
output(4,:) = quantile(input, .75);

% II) dispersion characteristics
% a) range
output(5,:) = max(input) - min(input);
% b) variance
output(6,:) = var(input);
% c) standard deviation
output(7,:) = std(input);
% round to 2 digits
output = round(output, 2);

