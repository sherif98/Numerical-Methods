function val = scan()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[FileName,PathName] = uigetfile('*.txt','Select the TXT file');
fileID = fopen([PathName FileName]);
val = textscan(fileID,'%f %f');
val = cell2mat(val);
fclose(fileID);
end

