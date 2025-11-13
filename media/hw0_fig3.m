%#ok<*CLALL>; hw0_fig3.m 
clear all; close all; clc

x       = linspace(-13.6, 0, 2400);
k       = sqrt(-2 * x);
lambda  = [k + k .* tanh(k/2); k + k .* coth(k/2)];

figure('Visible', 'off');
set(gca, 'Color',  '#fffff9', 'GridColor', 'black', ...
         'XColor', '#1f1f1f', 'YColor', '#1f1f1f');
box on; grid on; hold on; axis equal;
plot(lambda(1,:), x, 'LineWidth', 3);
plot(lambda(2,:), x, 'LineWidth', 3);
fontsize(32, "points");
lh = legend({' Odd Parity', ' Even Parity'}, 'Color', 'white', ...
             'TextColor', 'k', 'BackgroundAlpha', .8, 'FontSize', 16);
lh.IconColumnWidth = 50;
xlim([0, 10]);  xticks([0 3 6 9]); ylim([-12, 0]); yticks([-12 -9 -6 -3 0]);
hold off;
exportgraphics(gcf, 'hw0_fig3.pdf', 'ContentType', 'vector', ...
               'BackgroundColor', 'none');
close(gcf);