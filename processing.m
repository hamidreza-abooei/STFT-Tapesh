clc
close all
clear
%% Import Data 
% load("Data/seizure.mat");
% data =  double(data(:));
% fs = 256;

[data,fs] = audioread('Data/Recording.m4a');
data = data(:,1);   

%% preprocessing 
% Notch = designfilt(...
%     'bandstopiir','FilterOrder',2,...
%     'HalfPowerFrequency1',49,'HalfPowerFrequency2',51,...
%     'DesignMethod','butter','SampleRate',fs);
% % freqz(Notch);
% data = filtfilt(Notch, data);
% data = detrend(data);
% d = designfilt('bandpassiir','FilterOrder',10, ...
%     'HalfPowerFrequency1',1,'HalfPowerFrequency2',40, ...
%     'SampleRate',fs);
% % freqz(d)
% data = filtfilt(d,data);

%% Select data
% data = data(fs*2996:fs*3036); % Seizure
% data = data(fs*2000:fs*2040); % Non Seizure


%% Show Frequency domain of signal 
figure()
n = length(data);
X = fft(data);
f = (0:n-1)*(fs/n);     %frequency range
Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;     % zero-centered power
plot(fshift,powershift)
title("Frequency Domain of Data")

%% Show signal in time domain
t = 0:1/fs:(length(data)-1)/fs;

figure();
subplot(2,1,1)
plot(t,data);
title("Time Representation");
xlabel("Time (secs)");
ylabel("Magnitude");
xlim([0,length(data)/fs]);

subplot(2,1,2);

% this section is for initialization of paramaeters
window = 40;
overlap_percentage = 0.1:0.1:0.9;
counter = 0;
while (window < length(data))
    counter = counter +1;
    window = round(window *1.5);
end

window = 40;
renyi = zeros(length(overlap_percentage),counter);
windows = zeros(length(overlap_percentage),counter);
overlaps = zeros(length(overlap_percentage),counter);
i = 0;
windowval = zeros(counter,1);

%% Looking forward the best window and overlap for rectangle window
while(window < length(data))
    i = i + 1;
    j = 0;
    for overlap = overlap_percentage
        j = j+1;
        specto = spectrogram(data,window,round(overlap*window),100,fs,'yaxis'); % Note that FFT window is 100
        ren = renyi_entro(specto,4); % calculating renyi entropy
        renyi(j,i) = ren;
        windows(j,i) = window;
        overlaps(j,i) = round(overlap*window);
    end
    windowval(i) = window;
    window = round(window *1.5);
end
[minvalj, minindj] = min(renyi);
[minvali, minindi] = min(minvalj);

%% Show spectrogram with the best parameters
spectrogram(data,windows(minindj(minindi),minindi),...
            overlaps(minindj(minindi),minindi),100,fs,'yaxis');
        % Also Note that FFT window is 100
title("STFT Representation");

%% Plot Renyi Amount in heatmap
figure();
renyi_heat_map = heatmap((renyi));
renyi_heat_map.Colormap = colormap(jet);
renyi_heat_map.XData = windowval;
renyi_heat_map.YData = overlap_percentage;
xlabel("Window length (sample)");
ylabel("overlap percent");
title("Renyi entropy for diffrent windows and overlaps")
