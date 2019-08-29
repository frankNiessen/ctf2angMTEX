function ebsd = importCtf(inPath)
scrPrnt('SegmentStart','Reading in EBSD data')
%% Define Mtex plotting convention as X = right, Y = up
setMTEXpref('FontSize',16);
setMTEXpref('convertEuler2SpatialReferenceFrame','false');
%% Loading Cpr file
scrPrnt('Step',sprintf('Loading ''ctf'' file'));
tmp = what(inPath);
if isempty(tmp.path)
    inPath = pwd;
else
    inPath = tmp.path;
end
[FileName,inPath] = uigetfile([inPath,'/','*.ctf'],'EBSD-Data Input - Open *.ctf file');
if FileName == 0
    error('The program was terminated by the user');
else
    scrPrnt('Step',sprintf('Loading file ''%s''',FileName));
    [ebsd] = loadEBSD_ctf([inPath FileName],'interface','crc','convertSpatial2EulerReferenceFrame');
    scrPrnt('Step',sprintf('Loaded file ''%s'' succesfully',FileName));
end

%% Save output data
ebsd.opt.fName = FileName;                                                 %Save filename
