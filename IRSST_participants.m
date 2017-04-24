function participants = IRSST_participants(varargin)
% participants with '1' are blacklisted
% add 'IRSST' to include IRSST_SujeTd'

participants = [
    ['sarc' '1'];...
    ['inea' '1'];...
    ['dapo' '1'];...
    ['laug' '1'];...
    ['mara' '0'];...
    ['mars' '1'];...
    ['yosc' '0'];...
    ['marc' '0'];...
    ['benl' '1'];...
    ['davo' '1'];...
    ['marb' '0'];...
    ['gatb' '1'];...
    ['yoap' '1'];...
    ['romm' '1'];...
    ['camb' '1'];...
    ['eved' '1'];...
    ['naus' '1'];...
    ['emid' '0'];...
    ['verc' '1'];...
    ['marh' '1'];...
    ['samn' '1'];...
    ['alef' '1'];...
    ['danf' '0'];...
    ['aimq' '1'];...
    ['ameg' '1'];...
    ['noel' '1'];...
    ['karm' '1'];...
    ['patm' '1'];...
    ['vicj' '0'];...
    ['luia' '0'];...
    ['gabf' '1'];...
    ['aleb' '1'];...
    ['humm' '0'];...
    ['emmb' '0'];...
    ['fabg' '0'];...
    ['nicl' '0'];...
    ['sylg' '1'];...
    ['daml' '0'];...
    ['land' '0'];...
    ['emyc' '0'];...
    ['amia' '1'];...
    ['romr' '1'];...
    ['carb' '1'];...
    ['anns' '1'];...
    ['steb' '1'];...
    ['chac' '0'];...
    ['roxd' '1'];...
    ['vivs' '0'];...
    ['adrc' '0'];...
    ['geoa' '1'];...
    ['yoab' '1'];...
    ['nemk' '1'];...
    ['matr' '1'];...
    ['doca' '1'];...
    ['jawr' '1'];...
    ['fabd' '1'];...
    ['damg' '1'];...
    ['arst' '1'];...
    ['phil' '1'];...
    ['marm' '1'];...
    ];

participants(participants(:,5) == '0',:) = [];

if nargin > 0
    temp(:,:) = strcat('IRSST_',[upper(participants(:,1)) participants(:,2:end-2) upper(participants(:,end-1))]);
    participants = cellstr(temp(:,1:end));
else
    participants = cellstr(participants(:,1:end-1));
end