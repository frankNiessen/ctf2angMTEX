%main.m
% Main file to 'ctf2ang' - Conversion of ctf to ang 
% -> Tested for Bruker to TSL
% *************************************************************************
% Dr. Frank Niessen, University of Wollongong, Australia, 2019
% contactnospam@fniessen.com (remove the nospam to make this email address 
% work)
% *************************************************************************
% ang column names: [Euler1,Euler2,Euler3,X,Y,IQ,CI,phase,Edge,FIT]
% ang IQ is equivalent to 'ctf' BC
% ang CI can be approximated by 'ctf' BS
% Edge is not important - set to 1
% ang FIT is equivalent to ctf MAD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc 
close all  
scrPrnt('StartUp','ctf2ang');                                              %ScreenPrint
try MTEXmenu; catch; startup_mtex; end                                     %Startup m-tex
%% USER INPUT - declaration
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');
%% Preprocessing
Ini.DefInDir = 'data\Input - ctf';                                         % Input subdirectory
Ini.DefOutDir = 'data\Output - ang';                                       % Input subdirectory
ebsd = importCtf(Ini.DefInDir);
%% Data extraction and file conversion
ang = constr_ang(ebsd,Ini.DefOutDir);                                      % Execute Function 'constr_ang.m'   - Construction of ang file
fprintf(1,'\nctf2ang terminated!\n\n'); % Screen Output






















