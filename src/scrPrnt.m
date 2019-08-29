%% scrPrnt - Screen print
function scrPrnt(mode,varargin)
%function scrPrnt(mode,varargin)
switch mode
    case 'StartUp'
        titleStr = varargin{1};
        fprintf('\n*************************************************************');
        fprintf(['\n                 ',titleStr,' \n']);
        fprintf('*************************************************************\n'); 
    case 'Termination'
        titleStr = varargin{1};
        fprintf('\n*************************************************************');
        fprintf(['\n                 ',titleStr,' \n']);
        fprintf('*************************************************************\n'); 
    case 'SegmentStart'
        titleStr = varargin{1};
        fprintf('\n------------------------------------------------------');
        fprintf(['\n     ',titleStr,' \n']);
        fprintf('------------------------------------------------------\n'); 
   case 'Step'
        titleStr = varargin{1};
        fprintf([' -> ',titleStr,'\n']);
   case 'SubStep'
        titleStr = varargin{1};
        fprintf(['    - ',titleStr,'\n']);
   case 'SubSubStep'
        titleStr = varargin{1};
        fprintf(['      * ',titleStr,'\n']);
   case 'SegmentEnd'
        fprintf('\n- - - - - - - - - - - - - - - - - - - - - - - - - - - \n');
end