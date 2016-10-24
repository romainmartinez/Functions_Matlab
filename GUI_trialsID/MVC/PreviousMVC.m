index=index-1;
if index < 0
	disp('Index out of range')
else
    for j=1:length(C3dfiles)
 MAX2 = max(Maxdesmuscles);
subplot(5,6,j),plot(essai(j).RMS(:,index),'r'),title(sprintf('%d (%s)\n', j, C3dfiles(j).name)), axis([0 inf 0 MAX2(1,index)]);
if max(essai(j).RMS(:,index)) == MAX2(1,index)
    set(subplot(5,6,j),'color',[0.4 0.6 0.4])
end
    end
    set(gcf,'name',num2str(index),'numbertitle','off')
end
