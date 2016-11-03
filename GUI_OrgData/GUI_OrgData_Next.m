%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %                                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%						  

    if index < 1 | index > length(correctlabel)
        disp('Index out of range')
    else
        L  = get(S.ls,{'string','value'});
        oldlabel{1,index} = L{1}(L{2}(:));

        current = find(strcmp(fields, L{1}(L{2}(:))));
        fields(current) = [];

        index = index+1;
        if index > length(correctlabel)
            disp('Assignement complete')
            close all
        else
        set(S.pb,'string',correctlabel{index}.Text);
        set(S.ls,'string',fields);
        end
    end
