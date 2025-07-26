% 气动库
db.aerody = read_aerody_database('database/L400气动力数据库.V2a.20250721.txt');
% 动导数
db.dds = read_aerody_database('database/L400动导数数据库.V2.20250711.txt');
% 铰链力矩
db.hingle = read_aerody_database('database/L400铰链力矩系数数据库.V2.20250707.txt');


% 气动力系数参考面积为11.1m2，纵向参考长度1m，横航向参考长度11.5m，力矩参考点（2.1876m，0m，0.1386m）。
db.aerody.Sref = 11.1;
db.aerody.Cref = 1;
db.aerody.Bref = 11.5;

% 参考长度
db.aerody.Lref = [db.aerody.Bref,db.aerody.Cref, db.aerody.Bref];

% 构型坐标系，后右上为正，机体坐标系是前右下为正
db.aerody.COP = [2.308,0,-0.065].*[-1,1,-1];