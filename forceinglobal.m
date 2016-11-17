function [ forcein0, momentin0, corners ] = forceinglobal( markers, analog, tagplot)
%% Force
    % marqueurs de la boite (dim*markers*time)
Mmat(:,1,:) = markers.boite_arriere_droit';
Mmat(:,2,:) = markers.boite_arriere_gauche';
Mmat(:,3,:) = markers.boite_avant_droit';
Mmat(:,4,:) = markers.boite_avant_gauche';
Mmat(:,5,:) = markers.boite_droite_ext';
Mmat(:,6,:) = markers.boite_droite_int';
Mmat(:,7,:) = markers.boite_gauche_int';
Mmat(:,8,:) = markers.boite_gauche_ext';
    % marqueurs de la main (dim*markers*time)
Mmat(:,9,:) = markers.INDEX';
Mmat(:,10,:) = markers.LASTC';
Mmat(:,11,:) = markers.MEDH';
Mmat(:,12,:) = markers.LATH';

    % Milieu M5 M6
M5M6 = (Mmat(:,5,:)+Mmat(:,6,:))/2;

    % Axes
RT = defineAxis(Mmat(:,3,:) - Mmat(:,4,:), Mmat(:,1,:) - Mmat(:,3,:), 'xz', 'x',  M5M6);
RT(1:3,4,:) = RT(1:3,3,:)*78.5+RT(1:3,4,:); % Translation de 78.5mm en z
RT_Trans = invR(RT);

    if tagplot == 1
        % plot de la boite
    plot3d(Mmat(:,1:8,1)); hold on
    plot3d(Mmat(:,1:8,1), 'b.'); axis equal
        % plot axe du capteur
    plotAxes(RT(:,:,1),'length', 20)
    end
    
%% Force et moment dans le global
    % matrix 6xn des voltages
voltage(1,:) = btkanalog.Voltage_1;
voltage(2,:) = btkanalog.Voltage_2;
voltage(3,:) = btkanalog.Voltage_3;
voltage(4,:) = btkanalog.Voltage_4;
voltage(5,:) = btkanalog.Voltage_5;
voltage(6,:) = btkanalog.Voltage_6;
    % Étalonnage
matrixetal=[15.7377 -178.4176 172.9822 7.6998 -192.7411 174.1840;
                 208.3629 -109.1685 -110.3583  209.3269 -104.9032 -103.5278;
                 227.6774 222.8613 219.1087 234.3732 217.1453 221.2831;
                 5.6472 -0.7266 -0.3242 5.4650 -8.9705 -8.4179;
                 5.7700 6.7466 -6.9682 -4.1899 1.5741 -2.4571;
                 -1.2722 1.6912 -3.0543 5.1092 -5.6222 3.3049];
forcemoment    = matrixetal * voltage;

    % Reshape de la matrice de force
forcemoment = reshape(forcemoment, [6, 1, size(forcemoment,2)]);
ratioFreq = size(forcemoment, 3) / size(RT,3);

    % Forces dans le global
forcein0       = multiprod(RT_Trans(1:3,1:3,:), forcemoment(1:3,:,1:ratioFreq:end));

    % Moments dans le global (/!\ moment exprimés au centre du capteur /!\)
momentin0      = multiprod(RT_Trans(1:3,1:3,:), forcemoment(4:6,:,1:ratioFreq:end));

    % Moments exprimés dans le global     
momentin0 = momentin0 + cross(RT(1:3,4,:), forcein0);

    % Matrice 3D vers 2D
forcein0  = transpose(squeeze(forcein0));
momentin0 = transpose(squeeze(momentin0));

    % Rebase force et moment

    % Interpolation pour que frame force = frame analog
oldframe = (1:size(forcein0,1))./size(forcein0,1)*100;
newframe = linspace(oldframe(1,1),100,length(btkanalog.Voltage_1));
forcein0 = interp1(oldframe,forcein0,newframe,'spline');
momentin0 = interp1(oldframe,momentin0,newframe,'spline');

    % Corners qui ne servent à rien (prit au hasard)
corners =    [0    0    0;
              0    0    0;
              0    0    0;
              0    0    0];
end

