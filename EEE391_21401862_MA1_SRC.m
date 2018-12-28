%{
% Part 1
recObj = audiorecorder(16000, 8, 1);
disp('Start recording.');
T = 3;
recordblocking(recObj, T);
disp('End of recording.');
play(recObj);
%}

% Part 2 
load('recObj.mat');
soundArray = getaudiodata(recObj);
soundArray = soundArray.';
y = fft(soundArray);
fs = 16000;
ts = 1/fs;
n = length(soundArray);
 
y0 = fftshift(y);
f0 = (-n/2:n/2-1)*(fs/n); 
power0 = abs(y0).^2/n;
 
plot(f0,power0)
xlabel('Frequency')
ylabel('Power')

f0 = 446.3;
t0 = 1/f0;

t=linspace(0,3,length(soundArray));
plot(t, soundArray);
xlabel('Time (sec)')
ylabel('Recorded Signal')

numOfPeriods = 100;
numOfSamples = int64(numOfPeriods * fs / f0);
startingPoint = int64(1001);
endPoint = startingPoint + numOfSamples;
partOfSoundArray = soundArray(startingPoint:endPoint);
t = linspace(0, 100*t0, length(partOfSoundArray));
plot(t, partOfSoundArray);
xlabel('Time (sec)')
ylabel('Recorded Signal')

% Part 3
firstPeriod = int64(fs/f0);
firstPeriodArray = partOfSoundArray(1:firstPeriod);
t = [0:length(firstPeriodArray)-1]*ts;
plot(t, firstPeriodArray);
xlabel('Time (sec)')
ylabel('Recorded Signal')

for k = 1:21
a(k) = f0 * trapz(t, firstPeriodArray .* exp(-1i*2*pi*f0*(k-11)*t));
end
k = -10:10;
plot(k, abs(a))
xlabel('k');
ylabel('k^t^h coefficient - a(k)');

% Part 4
synthesized_x = 0;
for k = -5:5
    synthesized_x = synthesized_x + a(k+11) .* exp(-1i*2*pi*f0*k*t);
end
plot(t, synthesized_x)
ylabel('Synthesized Signal');
xlabel('time (sec)');
synthesized_100_periods_of_x = repmat(synthesized_x, 1, 100);
t = [0:length(synthesized_100_periods_of_x)-1]*ts;
plot(t, synthesized_100_periods_of_x);
ylabel('Synthesized Signal');
xlabel('time (sec)');

% Part 5
filename = 'sytnhesized_signal_100_periods.wav';
audiowrite(filename, synthesized_100_periods_of_x, fs)

synthesized_1000_periods_of_x = repmat(synthesized_x, 1, 1000);
filename = 'sytnhesized_signal_1000_periods.wav';
audiowrite(filename, synthesized_1000_periods_of_x, fs)

% Part 6
t = [0:length(firstPeriodArray)-1]*ts;
synthesized_x = 0;
for k = -1:1
    synthesized_x = synthesized_x + a(k+11) .* exp(-1i*2*pi*f0*k*t);
end
plot(t, synthesized_x)
ylabel('Synthesized Signal -1:1');
xlabel('time (sec)');

t = [0:length(firstPeriodArray)-1]*ts;
synthesized_x = 0;
for k = -2:2
    synthesized_x = synthesized_x + a(k+11) .* exp(-1i*2*pi*f0*k*t);
end
plot(t, synthesized_x)
ylabel('Synthesized Signal -2:2');
xlabel('time (sec)');

t = [0:length(firstPeriodArray)-1]*ts;
synthesized_x = 0;
for k = -3:3
    synthesized_x = synthesized_x + a(k+11) .* exp(-1i*2*pi*f0*k*t);
end
plot(t, synthesized_x)
ylabel('Synthesized Signal -3:3');
xlabel('time (sec)');

t = [0:length(firstPeriodArray)-1]*ts;
synthesized_x = 0;
for k = -4:4
    synthesized_x = synthesized_x + a(k+11) .* exp(-1i*2*pi*f0*k*t);
end
plot(t, synthesized_x)
ylabel('Synthesized Signal -4:4');
xlabel('time (sec)');

t = [0:length(firstPeriodArray)-1]*ts;
synthesized_x = 0;
for k = -5:5
    synthesized_x = synthesized_x + a(k+11) .* exp(-1i*2*pi*f0*k*t);
end
plot(t, synthesized_x)
ylabel('Synthesized Signal -5:5');
xlabel('time (sec)');

% Part 7
b = a(6:16);
for k = 1:11
    b(k) = 1.*exp(1i*angle(b(k)));
end
b(6) = a(11);
synthesized_x = 0;
for k = -5:5
    synthesized_x = synthesized_x + b(k+6) .* exp(-1i*2*pi*f0*k*t);
end
synthesized_10_periods_of_x = repmat(synthesized_x, 1, 10);
t = [0:length(synthesized_10_periods_of_x)-1]*ts;
plot(t, synthesized_10_periods_of_x)
ylabel('Synthesized Signal');
xlabel('time (sec)');

% Part 8
c = a(6:16);
for k = 1:11
    c(k) = abs(c(k)).*exp(0);
end
c(6) = a(11);
synthesized_x = 0;
for k = -5:5
    synthesized_x = synthesized_x + c(k+6) .* exp(-1i*2*pi*f0*k*t);
end
synthesized_10_periods_of_x = repmat(synthesized_x, 1, 10);
t = [0:length(synthesized_10_periods_of_x)-1]*ts;
plot(t, synthesized_10_periods_of_x)
ylabel('Synthesized Signal');
xlabel('time (sec)');