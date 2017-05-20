function str = namecompactor(varargin)
conson = {'a','e','i','o','u','y'};

str = varargin{1}
for ivar = 1 : length(varargin)
    for icon = conson
        str = strrep(str, icon, '')
    end
end