classdef prncplcmpnt < handle
    
    properties
        inputs
        x
    end
    %-------------------------------------------------------------------------%
    methods
        
        function obj = prncplcmpnt(data, varargin)
            % inputs :
            %   data (numeric matrix)
            %   vars (columns name in cell format)
            %   id (row names in cell format)
            
            p = inputParser;
            
            p.addRequired('data', @isnumeric);
            p.addOptional('vars', num2cell(1:size(data,2)), @iscell);
            p.addOptional('id', num2cell(1:size(data,1)), @iscell);
            % p.addParameter('plotstyle', 'all', @ischar);
            
            p.parse(data, varargin{:})
            obj.inputs = p.Results;
            
            % PCA
            % rebase and reduce data
            obj.x.rrdata = (obj.inputs.data - mean(obj.inputs.data)) ./ std(obj.inputs.data);
            % principal component analysis
            [obj.x.coeff, obj.x.score, obj.x.latent, obj.x.tsquared, obj.x.explained] = pca(obj.x.rrdata);
        end % prncplcmpnt
        
        %-------------------------------------------------------------------------%
        
        function obj = dscrb(obj)
            f = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
            
            g = uix.Grid('Parent', f, 'Spacing', 5);
            
            % 1) description panel
            dscrb.mtrx = [mean(obj.inputs.data)',...
                median(obj.inputs.data)',...
                quantile(obj.inputs.data, .25)',...
                quantile(obj.inputs.data, .75)',...
                (max(obj.inputs.data) - min(obj.inputs.data))',...
                var(obj.inputs.data)',...
                std(obj.inputs.data)'];
            dscrb.mtrx = round(dscrb.mtrx, 2);
            
            dscrb.panel = uix.Panel('Parent', g, 'Title', 'data description', 'Padding', 5);
            dscrb.t = uitable('Parent', dscrb.panel,'Data',dscrb.mtrx);
            dscrb.t.ColumnName = {'mean', 'median', 'Q1', 'Q3', 'range', 'variance', 'std'};
            dscrb.t.RowName = obj.inputs.vars;
            
            % 2) correlation matrix
            crr.mtrx = corr(obj.inputs.data);
            crr.mtrx(crr.mtrx == 1) = nan;
            crr.panel = uix.Panel('Parent', g, 'Title', 'correlation matrix', 'Padding', 5);
            heatmap(obj.inputs.vars, obj.inputs.vars, crr.mtrx, 'Parent', crr.panel);
            
            % 3) latent pannel
            latent.panel = uix.Panel('Parent', g, 'Title', 'latent pannel', 'Padding', 5);
            latent.data = [obj.x.latent, obj.x.explained, cumsum(obj.x.explained)];
            latent.t = uitable('Parent', latent.panel, 'Data', latent.data);
            latent.t.ColumnName = {'latent', '%', '% cumulated'};
            latent.t.RowName = 1:length(obj.inputs.vars);
            
            % 4) latent plot
            latent.plot = uix.Panel('Parent', g, 'Title', 'latent plot', 'Padding', 5);
            axes('Parent', latent.plot)
            hold on
            for ilat = 1:length(obj.x.latent)
                b = bar(ilat, obj.x.latent(ilat));
                if obj.x.latent(ilat) > 1
                    set(b, 'FaceColor', 'r')
                else
                    set(b, 'FaceColor', 'b')
                end
            end
            hold off
            
            set(g, 'Heights', [-1 -1]);
        end % dscrb
        
        %-------------------------------------------------------------------------%
        
        function plotpca(obj)
            f = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
            
            g = uix.Grid('Parent', f, 'Spacing', 5);
            
            % 1) CP1-CP2 factorial plane
            panel{1} = uix.BoxPanel('Parent', g, 'Title', 'CP1-CP2 factorial plane', 'Padding', 5);
            axes('Parent', panel{1})
            scatter(obj.x.score(:,1), obj.x.score(:,2), 'filled', 'b^')
            text(obj.x.score(:,1), obj.x.score(:,2),...
                obj.inputs.id,...
                'VerticalAlignment', 'bottom',...
                'HorizontalAlignment', 'right')
            xlabel('Factor 1 : CP1')
            ylabel('Factor 2 : CP2')
            
            % 2) correlation circle
            panel{2} = uix.BoxPanel('Parent', g, 'Title', 'correlation circle', 'Padding', 5);
            axes('Parent', panel{2})
            quiver(zeros(size(obj.x.coeff, 1),1), zeros(size(obj.x.coeff, 1),1),...
                obj.x.coeff(:,1), obj.x.coeff(:,2))
            text(obj.x.coeff(:,1), obj.x.coeff(:,2), obj.inputs.vars,...
                'VerticalAlignment', 'bottom',...
                'HorizontalAlignment', 'right')
            viscircles([0 0], max(max(obj.x.coeff(:,1:2))), 'color', 'k');
            axis equal
            xlabel('Factor 1 : CP1')
            ylabel('Factor 2 : CP2')
            
            % 3) biplot correlation (coeff, score)
            % variables-individus superposition
            panel{3} = uix.BoxPanel('Parent', g, 'Title', 'biplot correlation', 'Padding', 5);
            axes('Parent', panel{3})
            biplot(obj.x.coeff(:,1:2), 'scores', obj.x.score(:,1:2),...
                'varlabels', obj.inputs.vars,...
                'linewidth', 2)
            
            % 4) biplot distance (score, coeff)
            % variables-individus superposition
            panel{4} = uix.BoxPanel('Parent', g, 'Title', 'biplot distance', 'Padding', 5);
            axes('Parent', panel{4}, 'ActivePositionProperty', 'outerposition')
            biplot(obj.x.score(:,1:2), 'scores', obj.x.coeff(:,1:2),...
                'varlabels', obj.inputs.id,...
                'linewidth', 2)
            
            set(g, 'Heights', [-1 -1]);
            
            set(panel{1}, 'DockFcn', {@nDock, 1});
            set(panel{2}, 'DockFcn', {@nDock, 2});
            set(panel{3}, 'DockFcn', {@nDock, 3});
            set(panel{4}, 'DockFcn', {@nDock, 4});
            
            %-------------------------------------------------------------------------%
            
            function nDock(eventSource, eventData, whichpanel) %#ok<INUSL>
                % Set the flag
                panel{whichpanel}.Docked = ~panel{whichpanel}.Docked;
                if panel{whichpanel}.Docked
                    % Put it back into the layout
                    newfig = get(panel{whichpanel}, 'Parent');
                    set(panel{whichpanel}, 'Parent', g);
                    delete(newfig);
                else
                    % Take it out of the layout
                    pos = getpixelposition(panel{whichpanel});
                    newfig = figure(...
                        'Name', get(panel{whichpanel}, 'Title'), ...
                        'NumberTitle', 'off', ...
                        'MenuBar', 'none', ...
                        'Toolbar', 'none', ...
                        'CloseRequestFcn', {@nDock, whichpanel});
                    figpos = get(newfig, 'Position');
                    set(newfig, 'Position', [figpos(1,1:2), pos(1,3:4)] );
                    set(panel{whichpanel}, 'Parent', newfig, ...
                        'Units', 'Normalized', ...
                        'Position', [0 0 1 1]);
                end
            end % nDock
            
            %-------------------------------------------------------------------------%
            function nCloseAll(~, ~)
                % User wished to close the application, so we need to tidy up
                
                % Delete all windows, including undocked ones. We can do this by
                % getting the window for each panel in turn and deleting it.
                for ii=1:numel(panel)
                    if isvalid(panel{ii}) && ~strcmpi(panel{ii}.BeingDeleted, 'on')
                        figh = ancestor( panel{ii}, 'figure');
                        delete figh);
                    end
                end
                
            end % nCloseAll
            %%%
        end % plotpca
        
    end % methods
end % main function