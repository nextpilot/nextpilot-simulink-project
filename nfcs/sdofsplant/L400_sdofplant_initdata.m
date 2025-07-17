% 气动库
db.aerody = read_aerody_database('database/L400气动力数据库.V2.20250716.txt');
% 动导数
% db.dds = read_aerody_database('database/L400动导数数据库.V2.20250711.txt');
% 发动机
db.engine = read_aerody_database('database/L400螺旋桨数据库.V2a.20250714.txt');
% 铰链力矩
db.hingle = read_aerody_database('database/L400铰链力矩系数数据库.V2.20250707.txt');

% 气动力系数参考面积为11.1m2，纵向参考长度1m，横航向参考长度11.5m，力矩参考点（2.1876m，0m，0.1386m）。
db.Sref = 11.1;
db.Cref = 1;
db.Bref = 11.5;
% 构型坐标系，后右上为正，机体坐标系是前右下为正
db.COP = [2.1876, 0 0.1386].*[-1,1,-1];
db.COG = [2.1876, 0 0.1386].*[-1,1,-1];
% 飞机空重kg
db.Wempty = 400;
% 农药重量kg
db.Wpayload = 450;
% 喷药速度