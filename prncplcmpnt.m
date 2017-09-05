classdef prncplcmpnt < handle
    %
    %   Auteur:  Romain Martinez
    %   email:   martinez.staps@gmail.com
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
            % DSCRB  descriptive characteristics:
            %   1) description panel: print the summary statistics for each
            %   column.
            %
            %   2) correlation matrix: print the heatmap of the correlation
            %   matrix for each column.
            %
            %   3) latent pannel: print the principal component variances
            %   (eigenvalues of the covariance matrix of x), with the
            %   corresponding inertia (% cumulated).
            %
            %   4) latent plot: plot the principal component variances.
            %   The red bar represents the principal component variances to keep
            %   according to the Kaiser criterion (>1).
            %
            %   See also MEAN, MEDIAN, QUANTILE, VAR, STD, CORR, PCA.
            
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
            
            dscrb.panel = uix.BoxPanel('Parent', g, 'Title', 'data description', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('dscrb'));
            dscrb.t = uitable('Parent', dscrb.panel,'Data',dscrb.mtrx);
            dscrb.t.RowName = obj.inputs.vars;
            dscrb.t.ColumnName = {'mean', 'median', 'Q1', 'Q3', 'range', 'variance', 'std'};
            
            % 2) correlation matrix
            crr.mtrx = corr(obj.inputs.data);
            crr.mtrx(crr.mtrx == 1) = nan;
            crr.panel = uix.BoxPanel('Parent', g, 'Title', 'correlation matrix', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('dscrb'));
            heatmap(obj.inputs.vars, obj.inputs.vars, crr.mtrx, 'Parent', crr.panel);
            
            % 3) latent pannel
            latent.panel = uix.BoxPanel('Parent', g, 'Title', 'latent pannel', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('dscrb'));
            latent.data = [obj.x.latent, obj.x.explained, cumsum(obj.x.explained)];
            latent.t = uitable('Parent', latent.panel, 'Data', latent.data);
            latent.t.ColumnName = {'latent', '%', '% cumulated'};
            latent.t.RowName = 1:length(obj.inputs.vars);
            
            % 4) latent plot
            latent.plot = uix.BoxPanel('Parent', g, 'Title', 'latent plot', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('dscrb'));
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
            % PLOTPCA  principal components analysis:
            %   1) CP1-CP2 factorial plane: plot the coordinates of the
            %   original data in the new coordinate system defined by the
            %   principal components. The red text correspond to outliers
            %   based on Hotelling's T-squared statistic.
            %
            %   2) correlation circle: visualize each variable according to
            %   their correlation coefficient with the principal
            %   components. It allows to detect pattern in the variables.
            %
            %   3) biplot correlation (coeff, score):
            %   visualize both the orthonormal principal component coefficients
            %   for each variable and the principal component scores for each
            %   observation.
            %   All the variables are represented by a vector, and the
            %   direction and length of the vector indicates how each
            %   variable contributes to the two principal components.
            %   The bi-pllot also includes a point for each observations,
            %   with coordinates indicating the score for each observation
            %   for the two principal components.
            %
            %   4) biplot distance (score, coeff)
            %   variables-individus superposition
            %
            %   See also PCA, MEDIAN, QUANTILE, VAR, STD, CORR, PCA.
            
            f = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
            
            g = uix.Grid('Parent', f, 'Spacing', 5);
            
            % 1) CP1-CP2 factorial plane
            panel{1} = uix.BoxPanel('Parent', g, 'Title', 'CP1-CP2 factorial plane', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('plotpca'));
            axes('Parent', panel{1})
            scatter(obj.x.score(:,1), obj.x.score(:,2), 'filled', 'b^')
            text(obj.x.score(:,1), obj.x.score(:,2),...
                obj.inputs.id,...
                'VerticalAlignment', 'bottom',...
                'HorizontalAlignment', 'right')
            xlabel('Factor 1 : CP1')
            ylabel('Factor 2 : CP2')
            % detect outliers based on Hotelling's T-squared statistic
            [~,index] = sort(obj.x.tsquared,'descend'); % sort in descending order
            extreme = index(1:5);
            text(obj.x.score(extreme,1), obj.x.score(extreme,2),...
                obj.inputs.id(extreme),...
                'color', 'r',...
                'VerticalAlignment', 'bottom',...
                'HorizontalAlignment', 'right')
            obj.x.extreme = obj.inputs.id(extreme);
            
            % 2) correlation circle
            panel{2} = uix.BoxPanel('Parent', g, 'Title', 'correlation circle', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('plotpca'));
            axes('Parent', panel{2})
            quiver(zeros(size(obj.x.coeff, 1),1), zeros(size(obj.x.coeff, 1),1),...
                obj.x.coeff(:,1), obj.x.coeff(:,2))
            text(obj.x.coeff(:,1), obj.x.coeff(:,2), obj.inputs.vars,...
                'VerticalAlignment', 'bottom',...
                'HorizontalAlignment', 'right')
            viscircles([0 0], 1, 'color', 'k');
            axis equal
            xlabel('Factor 1 : CP1'); xlim([-1 1])
            ylabel('Factor 2 : CP2'); ylim([-1 1])
            
            % 3) biplot correlation (coeff, score)
            % variables-individus superposition
            panel{3} = uix.BoxPanel('Parent', g, 'Title', 'biplot correlation', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('plotpca'));
            axes('Parent', panel{3})
            biplot(obj.x.coeff(:,1:2), 'scores', obj.x.score(:,1:2),...
                'varlabels', obj.inputs.vars,...
                'linewidth', 2)
            
            % 4) biplot distance (score, coeff)
            % variables-individus superposition
            panel{4} = uix.BoxPanel('Parent', g, 'Title', 'biplot distance', 'Padding', 5,...
                'HelpFcn', @(a,b) doc('plotpca'));
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
        end % plotpca
    end % methods
end % main function