%#ok<*CLALL>; hw0_fig1.m 
clear all; close all; clc

x = linspace(-4.8, 4.8, 2400); n = 3; c = lines(2*n);

for i = 0:n - 1
  figure('Visible', 'off');
  set(gca, 'Color',  '#fffff9', 'GridColor', 'black', ...
           'XColor', '#1f1f1f', 'YColor', '#1f1f1f');
  box on; grid on; hold on; fontsize(33, "points");
  psi = sqrt(1/(sqrt(pi) * 2^i * factorial(i))) ... normalization const.
      * hermiteH(i, x) .* exp(-x.^2/2);
  plot(x, psi, 'LineWidth', 3, 'Color', c(i + floor(i/2) + 1, :));
  xlim([-5, 5]); xticks([-4 -2 0 2 4]); ylim([-1, 1]); yticks([-1 -.5 0 .5 1]);
  hold off;
  exportgraphics(gcf, 'hw0_fig1.pdf', 'ContentType', 'vector', ...
                 'BackgroundColor', 'none', 'Append', i > 0);
  close(gcf);
end