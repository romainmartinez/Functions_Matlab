%function algo_cut_file(inside)
% inside parameter is facultative. Default is true. Inside is if you want
% to keep data inside the point you pin-pointed

[filename path] = uigetfile('*.csv');
if filename == 0
    return
end
filename = [path filename];

disp(filename)


% ENTER THE NAME OF THE FILE HERE
data = dlmread(filename,',',5,8);

% Back-up of the data
data_bak = data; %#ok<NODEF>

% Plot the data to know where to cut

f1 = figure;
[n,p] = size(data_bak);
for i=1:p% plot(data)
    subplot(3,5,i), plot(data_bak(:,i));
end

% Ginput to click
x  = ginput(2);

% Cut the data
% ENTER THE FIRST FRAME YOU WANT TO KEEP HERE
first = round(x(1,1)); 
    
% ENTER THE LAST FRAME YOU WANT TO KEEP HERE
last = round(x(2,1));


if first<1, first=1; end
if last>n; last = n; end
if nargin < 1 || inside == true
    kept = first:last;
else
    kept = setdiff(1:n,first:last);
end

% Cut the data
data = data_bak(kept, :);

fs=4000;
l=length(data);
nfft=2^nextpow2(l);
f2 = figure;
% plot the cutted data
for i=1:p
    dat = data(:,i);
    figure(f1); subplot(3,5,i), hold on, plot(kept,dat,'r');
    
    
    data_fft=fft(dat,nfft);
    data_fft=(data_fft(1:(nfft/2)+1));
    mag=abs(data_fft);
    mag=mag/l;
    mag=mag.^2;
    mag(2:end)=mag(2:end)*2;
    faxis=0:fs/nfft:fs/2;
    figure(f2); subplot(3,5,i),
    plot(faxis,mag)
end

%% Save the data
% If everything is fine, save the new data
 dlmwrite('Triceps_1_Recoupe2.csv',data,',',5,8)
 
% Diff= last-first+6; 
% DRange = 'I6'; 
% sheet=1;
% Range= [DRange ':' 'S' num2str(Diff)]
% xlswrite('Triceps_1_Recoupe.csv',data,sheet,'Range');

%% Power Spectrum FFT

