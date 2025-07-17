close all;
clear all;
clc;

gravity = 9.8;
body = [30, 4, gravity];

body_unit = body / norm(body);
world_unit = [0, 0, 1];

dot_product_unit = [0, 0, dot(body_unit, world_unit)];
angle = acos(dot_product_unit(3));
% 最大倾角1rad，约等于57.3度
limit_angele = min(angle, 1.0);
sprintf("angle is %f degree; \r limited_angle is %f degree;\r", rad2deg(angle), rad2deg(limit_angele));

rejection = body_unit - dot_product_unit(3) * world_unit;
if (norm(rejection) < eps)
    sprintf("rejection norm is small than eps")
    rejection(1) = 1.0;
end

final_body_unit = cos(limit_angele) * world_unit + sin(limit_angele) * (rejection / norm(rejection));
% final_body_unit - body_unit

figure
quiver3(0, 0, 0, world_unit(1), world_unit(2), world_unit(3), 0, 'LineWidth',2.0);
hold on;
quiver3(0, 0, 0, body_unit(1), body_unit(2), body_unit(3), 0, 'LineWidth',2.0);
quiver3(0, 0, 0, dot_product_unit(1), dot_product_unit(2), dot_product_unit(3), 0, 'LineWidth',2.0);
quiver3(dot_product_unit(1), dot_product_unit(2), dot_product_unit(3), rejection(1), rejection(2), rejection(3), 0, 'LineWidth',2.0);
quiver3(0, 0, 0, final_body_unit(1), final_body_unit(2), final_body_unit(3), 0, '--', 'LineWidth',2.0);
axis([-Inf, Inf, -Inf, Inf]);
axis equal;
legend("world\_unit", "body\_unit", "dot\_product\_unit", "rejection", "final\_body\_unit")
grid on;
xlabel("x-axis")
ylabel("y-axis")
zlabel("z-axis")