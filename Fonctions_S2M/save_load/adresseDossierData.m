function [files_directory, lib_directory] = adresseDossierData(modeltype)
    [~, hostname] = system('hostname');
	ordinateur = hostname(hostname ~= 10); % enlever le retour de ligne

    if nargin < 1
        modeltype = 'shoulder';
    end
    
    switch modeltype
        case 'shoulder'
            if strcmpi(ordinateur, 'mickaelbegon-63611') == 1
                files_directory = '/home/collaboration/mnt/Data/Shoulder/RAW/';
                lib_directory = '/home/collaboration/mnt/ShoulderLib/';
            elseif strcmpi(ordinateur, 'bimec12-kinesio') == 1
                files_directory = 'F:/Data/Shoulder/RAW/';
                lib_directory = 'F:/Data/Shoulder/Lib/';
            elseif strcmpi(ordinateur, 'mickaelbegon-HP-dc5000-uT-PJ101UA') == 1
                files_directory = '/home/collaboration/mnt/Data/Shoulder/RAW/';
                lib_directory = '/home/collaboration/mnt/ShoulderLib/';
            elseif strcmpi(ordinateur, 'mickaelbegon-HP-Compaq-dc5850-Microtower') == 1
                files_directory = '/home/collaboration/mnt/Data/Shoulder/RAW/';
                lib_directory = '/home/collaboration/mnt/ShoulderLib/';
            elseif strcmpi(ordinateur, 'mickaelbegon-HP-Compaq-6000-Pro-MT-PC') == 1
                files_directory = '/home/collaboration/mnt/Data/Shoulder/RAW/';
                lib_directory = '/home/collaboration/mnt/ShoulderLib/';
			elseif strcmpi(ordinateur, 'ing3-kinesio') == 1
				files_directory = 'C:/Devel/F_Data/Shoulder/RAW/';
				lib_directory = 'C:/Devel/F_Data/Shoulder/Lib/';
            elseif strcmpi(ordinateur, 'maplesrv')
                files_directory = '/home/collaboration/mnt/F/Data/Shoulder/RAW/';
                lib_directory = '/home/collaboration/mnt/F/Data/Shoulder/Lib/';
            else
                files_directory = '\\bimec12-kinesio\Data\Shoulder/RAW/';
                lib_directory = '\\bimec12-kinesio\ShoulderLib\';
            end
        case 'muscod'
            files_directory = '../DAT/generic/RAW/';
            lib_directory = '../DAT/generic/Lib/';
        otherwise
            error('%s is not a proper model type', modeltype)
    end

end