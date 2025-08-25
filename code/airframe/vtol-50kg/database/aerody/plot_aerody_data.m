clc
clear
close all


cwd = fileparts([mfilename('fullpath'),'.m']);

if ~exist(fullfile(cwd, 'aerody.mat'),'file')
    process_aerody_data();
end


load('aerody.mat');

%%

subplot(311)
hold on
grid on
for i = 1:length(aerody.basic.cll.beta)
    plot(aerody.basic.cll.alpha, aerody.basic.cll.coeff(:, i))
end

%%