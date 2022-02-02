%% First Part, Representation of signal
clc 
clear
close all
%% Create signals
fs = 100;
t = 0:1/fs:1;
A = 3 * sin(2*5*pi*t);
B = 2 * sin(2*12*pi*t);
C = A + B;
n = length(A);
%% Representation of signals in time Domain
figure();
subplot(3,1,1);
plot(t,C,'r');
title("Original Signal");
xlabel("Time (secs)");
ylabel("Amplitude");
ylim([-5 5]);
subplot(3,1,2);
plot(t,A);
title("First component");
xlabel("Time (secs)");
ylabel("Amplitude");
ylim([-5 5]);
subplot(3,1,3);
plot(t,B);
title("Second Component");
xlabel("Time (secs)");
ylabel("Amplitude");
ylim([-5 5]);
suptitle("Signal Analysing")

%% Representation in frequency Domain
figure();
noise = 2*rand(1 , length(t));
D = C + noise - mean(noise);
F = fft(D);
Y = fftshift(F);
frange = (-n/2:n/2-1)*(fs/n); 
subplot(2,1,1);
plot(t,D)
ylim([-6 6]);
title("Time Domain");
xlabel("Time (secs)");
ylabel("Amplitude");
subplot(2,1,2);
plot(frange,abs(Y));
xlim([0 fs/2])
title("Frequency Domain");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
suptitle("Frequency and Time Representation");