%#ok<*CLALL>; hw0_fig2.m
clear all; close all; clc

eV = 1.6022e-19; m = 9.1093837e-31; hbar = 1.054571817e-34; au = 1e-10;
V0 = 6.8*eV; L = 4*au; a = L/2; x = linspace(-10*au, 10*au, 1e4);
E = [13.6 3.4 V0*(1+eps)/eV]*eV;
u = @(E) sqrt(2 * m * E) / hbar;        p = @(E) 1i * u(E) * a;
v = @(E) sqrt(2 * m * (E - V0)) / hbar; q = @(E) 1i * v(E) * a;
r = @(E) exp(-2*p(E)) * (u(E)^2 - v(E)^2) * (1 - exp(4*q(E))) / ...
         ((u(E) + v(E))^2 - (u(E) - v(E))^2 * exp(4*q(E)));
t = @(E) 4 * u(E) * v(E) * exp(-2*(p(E)-q(E))) / ...
         (u(E) * (1 - exp(2*q(E))) + v(E) * (1 + exp(2*q(E))))/ ...
         (u(E) * (1 + exp(2*q(E))) + v(E) * (1 - exp(2*q(E))));
c = @(E) t(E) * (u(E) + v(E)) * exp(p(E) - q(E)) / 2 / v(E);
d = @(E) -c(E) * exp(2*q(E)) * (u(E) - v(E)) / (u(E) + v(E));
psi = @(E,x) arrayfun(@(xi) ...
  (xi < -a)      .* (exp(1i*u(E)*xi) + r(E) * exp(-1i*u(E)*xi)) + ...
  (abs(xi) <= a) .* (c(E) * exp(1i*v(E)*xi) + d(E) * exp(-1i*v(E)*xi)) + ...
  (xi > a)       .* (t(E) * exp(1i*u(E)*xi)), x);

for i = 1:3
  PSI = psi(E(i),x);
  figure('Visible','off');
  set(gca, 'Color',  '#fffff9', 'GridColor', 'black', ...
           'XColor', '#1f1f1f', 'YColor', '#1f1f1f');
  box on; grid on; hold on; fontsize(33, "points");
  plot(x, abs(PSI).^2,     'LineWidth', 3, 'Color', [.1, .1, .1]);
  plot(x, real(PSI), '-.', 'LineWidth', 2, 'Color', [.9, .1, .1, .75]);
  plot(x, imag(PSI), '-.', 'LineWidth', 2, 'Color', [.1, .9, .1, .75]);
  xticks([-a a]); xline([-a a], 'r--', 'LineWidth', 2, 'Alpha', 0.7);
  yticks([]);     yline(0, 'k-', 'Alpha', .3);
  xticklabels({'-L/2' 'L/2'}); ylim([-5, 5]);
  legend('\ $|\psi(x)|^2$', '\ $\Re[\psi(x)]$', '\ $\Im[\psi(x)]$',...
         'Interpreter', 'latex', 'IconColumnWidth', 75, ...
         'BackgroundAlpha', .5, 'Color', 'w', 'TextColor', 'k');
  hold off;
  exportgraphics(gcf, 'hw0_fig2.pdf', 'ContentType', 'vector', ...
                 'BackgroundColor', 'none', 'Append', i > 1);
  close(gcf);
end