% 读取静态气动力数据库-低速通用

function db = read_aerody_database(name)

disp('读取静态气动力数据库');
disp(name);
fid = fopen(name,'rt');

%%%%%%%%%%    读取vector    %%%%%%%%%%%%%%%
while feof(fid) == 0
    line = fgetl(fid);
    if strcmp(line,'==========  begin longitudinal part')     % 开始读取data则跳出
        break;
    end
    sign = '';
    while (any(line))
        [chopped,line] = strtok(line);                        % 将一行字符串按空格分隔成多个字符串
        sign = strvcat(sign,chopped);
    end
    n_sign = size(sign);
    if (n_sign(1) == 2)  && (strcmp(sign(2,:),'VECTOR'))      % 第二个字符串为'VECTOR'则开始读取数据
        nn = fscanf(fid,'%d',[1,1]);
        vv = fscanf(fid,'%f',[nn,1])';
        eval(['db.N' sign(1,:) '= nn;'])
        eval(['db.V' sign(1,:) '= vv;'])
    end
end

%%%%%%%%%%    读取data    %%%%%%%%%%%%%%%
while feof(fid) == 0
    line = fgetl(fid);
    if strcmp(line,'==========  end of directional part')     % 读取data完毕则跳出
        break;
    end
    sign = '';
    while (any(line))
        [chopped,line] = strtok(line);                        % 将一行字符串按空格分隔成多个字符串
        sign = strvcat(sign,chopped);
    end
    n_sign = size(sign);
    if (n_sign(1) == 5) && (strcmp(sign(3,1),'-'))            % 第三个字符串为'-'则开始读取数据
        a = sign(4,:);
        vector = '';
        while (any(a))
            [chopped,a] = strtok(a,',');                      % 将第四个字符串按','分隔，得到vector名
            vector = strvcat(vector,chopped);
        end
        n_vector = size(vector);
        b = sign(2,:);
        name = '';
        while (any(b))
            [chopped,b] = strtok(b,'-');                      % 将第二个字符串去掉'-',得到data名
            name = strcat(name,chopped);
        end
        
        if n_vector(1) == 1                                  % 一维数组读取
            eval(['v = db.N' vector(1,:) ';'])
            c = fscanf(fid,'%f',[v,1])';
            eval(['db.' name ' = c;'])
        end
        
        if n_vector(1) == 2                                  % 二维数组读取
            eval(['v1 = db.N' vector(1,:) ';'])
            eval(['v2 = db.N' vector(2,:) ';'])
            c = fscanf(fid,'%f',[v2,v1])';
            eval(['db.' name ' = c;'])
        end
        
        if n_vector(1) == 3                                  % 三维数组读取
            eval(['v1 = db.N' vector(1,:) ';'])
            eval(['v2 = db.N' vector(2,:) ';'])
            eval(['v3 = db.N' vector(3,:) ';'])
            for j = 1:v3
                line = fgetl(fid);
                c = fscanf(fid,'%f',[v2,v1])';
                eval(['db.' name '(:,:,j) = c;'])
                line = fgetl(fid);
            end
        end
        
        if n_vector(1) == 4                                  % 四维数组读取
            eval(['v1 = db.N' vector(1,:) ';'])
            eval(['v2 = db.N' vector(2,:) ';'])
            eval(['v3 = db.N' vector(3,:) ';'])
            eval(['v4 = db.N' vector(4,:) ';'])
            for k = 1:v4
                for j = 1:v3
                    line = fgetl(fid);
                    c = fscanf(fid,'%f',[v2,v1])';
                    eval(['db.' name '(:,:,j,k) = c;'])
                    line = fgetl(fid);
                end
            end
        end
    end
end

disp('Done!');
fclose(fid);

end