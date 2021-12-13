clear all;
close all;

%% beolvasás
filename='b13_br.i16';
fileID = fopen(filename, 'r', 'ieee-le');
if fileID == -1, error('Cannot open file: %s', filename); end
format = 'int16';
Data = fread(fileID, Inf, format);
fclose(fileID);

%%

fs=44100;
% sound(Data,fs);
code=[1  0  0  1  1  1  0  1  0  1  0  0  0  1  1  1  1  0  1  1  0  1  0  0  0  0  1  0  0  1  0  0];
plot(abs(fft(Data)));
867423000/fs=1.9669e+04;
%%
sound(Data,fs);
