close all;
clear all;
clc

%% Plot Stapes Displacement given one pressure
[time, state] = EarModel.simulateEar(0.632455532, 'normal');
plot(time, state(:,2));
title('Stapes Displacement over time at 90dB (pressure)');
ylabel('Stapes Displacement (m)');
xlabel('Time (s)');

%% Model normal ear, mild otosclerosis, moderate otosclerosis, severe otosclerosis

% Range of frequency
frequencyArray = [250:10:16000];

% Nomal Ear Stapes Displacement over Frequency of Sound
normalStapesDisplacement = EarModel.getStapesDisplacementArray('normal', frequencyArray);
figure;
plot(frequencyArray, normalStapesDisplacement, 'k');
title ('Stapes Displacement over Frequency of Sound of Normal Ear');
xlabel('Frequency (Hz)');
ylabel('Stapes Displacement (m)');

% Mild Otosclerosis Stapes Displacement over Frequency of Sound
mildOtoStapesDisplacement = EarModel.getStapesDisplacementArray('otoMild', frequencyArray);
figure;
plot(frequencyArray, mildOtoStapesDisplacement, 'b');
title ('Stapes Displacement over Frequency of Sound of Ear with Mild Otosclerosis');
xlabel('Frequency (Hz)');
ylabel('Stapes Displacement (m)');

% Moderate Ostosclerosis Stapes Displacement over Frequency of Sound
moderateOtoStapesDisplacement = EarModel.getStapesDisplacementArray('otoModerate', frequencyArray);
figure;
plot(frequencyArray, moderateOtoStapesDisplacement, 'm');
title ('Stapes Displacement over Frequency of Sound of Ear with Moderate Otosclerosis');
xlabel('Frequency (Hz)');
ylabel('Stapes Displacement (m)');

% Severe Ostosclerosis Stapes Displacement over Frequency of Sound
severeOtoStapesDisplacement = EarModel.getStapesDisplacementArray('otoSevere', frequencyArray);
figure;
plot(frequencyArray, severeOtoStapesDisplacement, 'r');
title ('Stapes Displacement over Frequency of Sound of Ear with Severe Otosclerosis');
xlabel('Frequency (Hz)');
ylabel('Stapes Displacement (m)');

% Plot Stapes Displacement Comparisons
% Comparison of Stapes Displacement over Frequency of Sound
figure;
plot(frequencyArray, normalStapesDisplacement, 'k');
hold on;
plot(frequencyArray, mildOtoStapesDisplacement, 'b');
hold on;
plot(frequencyArray, moderateOtoStapesDisplacement, 'm');
hold on;
plot(frequencyArray, severeOtoStapesDisplacement, 'r');

title('Comparison of Stapes Displacements');
legend('Normal Ear', 'Mild Otosclerosis', 'Moderate Otosclerosis', 'Severe Otosclerosis');
xlabel('Frequency (Hz)');
ylabel('Stapes Displacement (m)');

%% Obtain peak stapes displacement values & frequency of occurrence

% Normal ear
[peakStapesDispNormal, indexNormal] = max(normalStapesDisplacement);
peakFrequencyNormal = frequencyArray(indexNormal);

% Mild otosclerotic ear
[peakStapesDispMild, indexMild] = max(mildOtoStapesDisplacement);
peakFrequencyMild = frequencyArray(indexMild);

% Moderate otosclerotic ear
[peakStapesDispMod, indexMod] = max(moderateOtoStapesDisplacement);
peakFrequencyMod = frequencyArray(indexMod);

% Severe otosclerotic ear
[peakStapesDispSevere, indexSevere] = max(severeOtoStapesDisplacement);
peakFrequencySevere = frequencyArray(indexSevere);
