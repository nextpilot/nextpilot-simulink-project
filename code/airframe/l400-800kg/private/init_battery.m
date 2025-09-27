function battery = init_battery()
% 电池输出电压与电量和放电电流有关。电池额定电压310V，总容量12kwh，允许使用的最大电量是9kwh，最后3kwh不用。对应截止电压是288V。
% 在仿真中，需考虑不同电压对电机转速的影响，相同油门下转速随着电压等比变化。
% 放电曲线是按照50A放电获取的，如果实际电流大于50A，则内阻分压会进一步降低输出电压。单块电池内阻为67.2mΩ，考虑线材，需按照100mΩ考虑。总输出电压应该为放电曲线中电压-（实际电流-50A）/2*0.1Ω。


% 额定电压310V
battery.nominal_voltage = 310;
% 截止电压是288V
battery.cutoff_voltage = 288;
% 总容量12kwh，允许使用的最大电量是9kwh，最后3kwh不用
battery.capacity = 12;
% 最大使用电量
battery.max_discharge = 9;
% 50A放电曲线多项式
% y = @(x)0.2124*x.^2 + 2.9181*x +281.27;
battery.discharge_curve = [0.2124, 2.9181,281.27];

% 设备的大概功耗大概2-3kw
battery.other_power = 2.5e3;
