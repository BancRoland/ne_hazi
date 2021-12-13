clear all;
close all;

%% beolvasás
filename='bin_br_att.i16';
fileID = fopen(filename, 'r', 'ieee-le');
if fileID == -1, error('Cannot open file: %s', filename); end
format = 'int16';
Data = fread(fileID, Inf, format);
fclose(fileID);

%%
Data=Data/max(Data);
fs=44100;
% sound(Data,fs);

figure(1);
hold on;
title('Jel Diszkrét Fourier Transzformáltja');
plot(abs(fft(Data)));

%%
% sound(Data,fs);
%%

%%
close all;

%DFT-ből származó adat (NEM a legnagyobb komponens, hanem a jel sávközepe!)
%érdemes lehet kicsit hangolgatni a lekevert eredmény alapján:
% f=8869; %bin_br.i16 
f=8860; %bin_br_att.i16 

x=0:(length(Data)-1);
% signal=sin(f*2*pi*x/length(Data));
signal=exp(1i*f*2*pi*x/length(Data)); 

%Teszteléshez,sávközép kereéséshez:
% figure(10);
% hold on;
% plot(real(signal(1:fs/50)));
% plot(Data(1:fs/50));

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



%%
% Figure(2) alapján a bitsebesség: 1 bit/430 órajel
incVal=430;
code=[1  0  0  1  1  1  0  1  0  1  0  0  0  1  1  1  1  0  1  1  0  1  0  0  0  0  1  0  0  1  0  0];  %saját kódom
incCode=[]; %incrementált kód (430 szorosra bővített)
for inc=1:length(code)
    incCode=[incCode code(inc)*ones(1,incVal)];
end

%%
% detect=xcorr(incCode,lpfMix);
detect=xcorr(lpfMix,incCode);
figure(3)
title('Korreláltatott jel komplex jel') 
plot(real(detect(length(detect)/2:end)));
hold on;
plot(imag(detect(length(detect)/2:end)));
legend('valós','képzetes');
figure(4)
hold on;
title('Korreláltatott komplex jel abszolút értéke') 
plot(abs(detect(length(detect)/2:end)));