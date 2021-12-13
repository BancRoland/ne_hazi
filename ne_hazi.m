clear all;
close all;

%% beolvasás
filename='b13_br_att.i16';
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
figure(1);
hold on;
title('Jel Diszkrét Fourier Transzformáltja');
plot(abs(fft(Data)));

% 867423000/fs=1.9669e+04;
% 8921/fs=2.0229e+04
%%
% sound(Data,fs);
%%
x=0:(length(Data)-1);
%%
% signal=sin(8921*2*pi*x/length(Data));

% signal=exp(1i*8921*2*pi*x/length(Data)); %b13_br.i16
signal=exp(1i*8930*2*pi*x/length(Data));    %b13_br_att.i16
% plot(signal(1:fs/100));
% hold on;
% plot(Data(1:fs/100));

% mixed=Data.*signal';
mixed=Data.*signal';

lpfMix=lowpass(mixed,10,fs);
figure(2);
hold on;
title('Lekevert alulátereszett komplex jel');
plot(real(lpfMix));
plot(imag(lpfMix));
legend('valós','képzetes');
% figure(2);
% plot(angle(mixed));

%bitsebesség: 1 bit/430 órajel

%%
incVal=430;
barker=[1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
incBarker=[];
for inc=1:length(barker)
    incBarker=[incBarker barker(inc)*ones(1,incVal)];
end

%%
detect=xcorr(incBarker,lpfMix);
% detect=xcorr(lpfMix,incBarker);
figure(3)
title('Korreláltatott jel komplex jel') 
plot(real(detect(1:length(detect)/2)));
hold on;
plot(imag(detect(1:length(detect)/2)));
legend('valós','képzetes');
figure(4)
hold on;
title('Korreláltatott komplex jel abszolút értéke') 
plot(abs(detect(1:length(detect)/2)));