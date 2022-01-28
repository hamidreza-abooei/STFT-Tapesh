%% First Part, Representation of signal
clc 
clear
close all
%% Create signals
fs = 100;
n = 2;
t = 0:1/fs:n;
A = 3 * sin(10*pi*t);
B = 2 * sin(15*pi*t);
C = A + B;

%% Representation of signals in time Domain
figure();
subplot(3,1,1);
plot(t,C,'r');
title("Original Signal");
xlabel("Time");
ylabel("Amplitude");
ylim([-5 5]);
subplot(3,1,2);
plot(t,A);
title("First component");
xlabel("Time");
ylabel("Amplitude");
ylim([-5 5]);
subplot(3,1,3);
plot(t,B);
title("Second Component");
xlabel("Time");
ylabel("Amplitude");
ylim([-5 5]);
suptitle("Signal Analysing")

%% Representation in frequency Domain
figure();
noise = rand(1 , length(t));
D = C + noise - mean(noise);
F = fft(D);
Y = fftshift(F);
frange = (-n/2:1/fs:n/2)*(fs); 
subplot(2,1,1);
plot(t,D)
title("Time Domain");
xlabel("Time");
ylabel("Amplitude");
subplot(2,1,2);
plot(frange,abs(Y));
title("Frequency Domain");
xlabel("Frequency");
ylabel("Amplitude");
xlim([-50 50]);
suptitle("Frequency and Time Representation");


