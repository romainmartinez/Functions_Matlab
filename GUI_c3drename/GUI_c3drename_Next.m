%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %                                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%						  

    if index < 1 | index > length(newlabel)
        disp('Index out of range')
    else
        L  = get(S.ls,{'string','value'});
        oldlabel{1,index} = L{1}(L{2}(:));

        current = find(strcmp(fields, L{1}(L{2}(:))));
        fields(current) = [];

        index = index+1;
        if index > length(newlabel)
            disp('Assignement complete')
            close all
        elseif get(S.ls,'value') == length(L{1, 1})
        set(S.pb,'string',newlabel{index}.Text);
        set(S.ls,'string',fields, 'Value',1);
        else 
        set(S.pb,'string',newlabel{index}.Text);
        set(S.ls,'string',fields);   
        end
    end