function [ang] = constr_ang(ebsd,outPath)
fprintf(1,'\n\nang-file construction');                                     % Screen Output
fprintf(1,'\n...........................................................'); % Screen Output
load('angHeader.mat')
ang = angHeader.Stage;
%Write phase headers
phaseNrs = ebsd.phaseMap;
for i = 1:size(phaseNrs,1) 
    fprintf('\n\t->\tPhase %i: ''%s''',phaseNrs(i),ebsd.mineralList{i});% Screen output
    if phaseNrs(i)
        temp.phase{1} = sprintf('# Phase %i',phaseNrs(i));
        temp.phase{2} = sprintf('# MaterialName  \t%s',ebsd.mineralList{i}(isstrprop(ebsd.mineralList{i},'alphanum')));
        temp.phase{3} = sprintf('# Formula  \t');
        temp.phase{4} = sprintf('# Info  \t');
        ptGrps = ebsd(num2str(phaseNrs(i))).CS.pointGroups;
        grpId = find(strcmp(ebsd(num2str(phaseNrs(i))).CS.pointGroup,{ptGrps.Inter}));
        temp.phase{5} = sprintf('# Symmetry              %i',ptGrps(grpId).properId);
        temp.phase{6} = sprintf('# LatticeConstants      %.3f %.3f %.3f  %.3f  %.3f  %.3f',ebsd(num2str(phaseNrs(i))).CS.aAxis.abs, ebsd(num2str(phaseNrs(i))).CS.bAxis.abs, ebsd(num2str(phaseNrs(i))).CS.cAxis.abs,...
                                                                                           ebsd(num2str(phaseNrs(i))).CS.alpha/degree, ebsd(num2str(phaseNrs(i))).CS.beta/degree, ebsd(num2str(phaseNrs(i))).CS.gamma/degree);
        temp.phase{7} = sprintf('# NumberFamilies        0');
        temp.phase{8} = sprintf('# ElasticConstants 	0.000000 0.000000 0.000000 0.000000 0.000000 0.000000');
        temp.phase{9} = sprintf('# ElasticConstants 	0.000000 0.000000 0.000000 0.000000 0.000000 0.000000');
        temp.phase{10} = sprintf('# ElasticConstants 	0.000000 0.000000 0.000000 0.000000 0.000000 0.000000');
        temp.phase{11} = sprintf('# ElasticConstants 	0.000000 0.000000 0.000000 0.000000 0.000000 0.000000');
        temp.phase{12} = sprintf('# ElasticConstants 	0.000000 0.000000 0.000000 0.000000 0.000000 0.000000');
        temp.phase{13} = sprintf('# ElasticConstants 	0.000000 0.000000 0.000000 0.000000 0.000000 0.000000');
        temp.phase{14} = sprintf('# Categories1 1 1 1 1');
        temp.phase{15} = '';
        ang = {ang{:},temp.phase{:}};                                      % Append Phase header to ang file
    end
end
%Append Grid
ebsdGrid = ebsd.gridify;
angHeader.Grid{2} = [angHeader.Grid{2},num2str(round(ebsdGrid.dx,3))]; % Write x step
angHeader.Grid{3} = [angHeader.Grid{3},num2str(round(ebsdGrid.dy,3))]; % Write y step
clear ebsdGrid
angHeader.Grid{6} = [angHeader.Grid{6},num2str(size(gridify(ebsd),1)-1)];   % Write Nr of rows
ang = {ang{:},angHeader.Grid{:}};                                           % Append Grid Info
%Append General Info
ang = {ang{:},angHeader.General{:}};                                        % Append General Info
%Sort data and write ang file
ang_dat = [ebsd.rotations.phi1,ebsd.rotations.Phi,ebsd.rotations.phi2,ebsd.x,ebsd.y,ebsd.prop.bc,...
           ebsd.prop.bs./max(ebsd.prop.bs),ebsd.phase,ones(size(ebsd)),ebsd.prop.mad]; % Sorting Columns: [Euler1,Euler2,Euler3,X,Y,IQ,CI,phase,Edge,FIT] 
%Change convention of y axis
% ang_dat(:,5) = flip(ang_dat(:,5));
% %Set close to 0 x and y's to 0
% ang_dat(abs(ang_dat(:,4))<1e-3,4) = 0;
% ang_dat(abs(ang_dat(:,5))<1e-3,5) = 0;
% %Set close to 0 Euler angles to 0
% ang_dat(abs(ang_dat(:,1))<1e-12,1) = 0;
% ang_dat(abs(ang_dat(:,2))<1e-12,2) = 0;
% ang_dat(abs(ang_dat(:,1))<1e-12,3) = 0;
%Find output directory
tmp = what(outPath);
if isempty(tmp)
    outPath = pwd;
else
    outPath = tmp.path;
end       
%Write header
Ini.ang_filename = [outPath,'\',strtok(ebsd.opt.fName,'.'),'.ang'];         % Full filename with path
fprintf(1,'\n\t->\tBusy writing data ...');                                 % Screen Output
dlmcell(Ini.ang_filename,ang');                                             % Write ang-header into ang file
%Write data
file = fopen(Ini.ang_filename, 'a');
for i = 1:size(ang_dat,1)
    fprintf(file,'%0.4f\t%0.4f\t%0.4f\t%0.4f\t%0.4f\t%i\t%i\t%i\t%i\t%0.4f\r\n',ang_dat(i,1),ang_dat(i,2),ang_dat(i,3),ang_dat(i,4),ang_dat(i,5),ang_dat(i,6),ang_dat(i,7),ang_dat(i,8),ang_dat(i,9),ang_dat(i,10));
end
fclose(file);
% dlmwrite(Ini.ang_filename,ang_dat,'-append','precision',4,'delimiter',...
%          '\t','newline', 'pc');                                             % Append ang data to ang file
fprintf(1,'\n\t->\tang file created and saved under %s',Ini.ang_filename);  % Screen Output
fprintf(1,'\n...........................................................'); % Screen Output