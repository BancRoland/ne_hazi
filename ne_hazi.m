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
Data=Data/max(Data);
fs=44100;
% sound(Data,fs);
code=[1  0  0  1  1  1  0  1  0  1  0  0  0  1  1  1  1  0  1  1  0  1  0  0  0  0  1  0  0  1  0  0];
plot(abs(fft(Data)));
% 867423000/fs=1.9669e+04;
% 8921/fs=2.0229e+04
%%
sound(Data,fs);
%%
x=0:(length(Data)-1);
%%
close all;
% signal=sin(8921*2*pi*x/length(Data));


signal=exp(i*8921*2*pi*x/length(Data));
% plot(signal(1:fs/100));
% hold on;
% plot(Data(1:fs/100));

% mixed=Data.*signal';
mixed=Data.*signal';

lpfMix=lowpass(mixed,10,fs);
figure(1);
plot(real(lpfMix));
hold on;
plot(imag(lpfMix));
% figure(2);
% plot(angle(mixed));

%bitsebesség: 1 bit/430 órajel