function convert_params_to_mfile(varargin)

if nargin == 0
    [filename, pathname] = uigetfile({'*.c', 'Param Define Files (*.c)'},'Param Define Files');
    if isequal(pathname, 0)
        return;
    else
        cfile = fullfile(pathname, filename);
    end
end

if nargin < 2
    [~, filename] =fileparts(cfile);
    mfile =  [filename,'.m'];

end


cfid = fopen(cfile);
mfid = fopen(mfile, 'w');

flag = 1;

while ~feof(cfid)
    tline = strtrim(fgetl(cfid));
    if isempty(tline)
        continue;
    end

    switch flag
        case 1
            if strcmpi(tline, '/**')
                fprintf(mfid, '%%{\n');
                flag = 2;
            end
        case 2
            if strcmpi(tline, '*/')
                fprintf(mfid, '%%}\n');
                flag = 3;
            else
                fprintf(mfid, '%s\n', tline);
            end
        case 3
            % PARAM_DEFINE_FLOAT(FW_L1_PERIOD, 20.0f);
            if startsWith(tline, 'PARAM_DEFINE_')
                tline = regexprep(tline, {'f', '\(\s*', '\s*,'}, {'', '\(''', ''',',});
                fprintf(mfid, '%s\n\n', tline);
                flag = 1;
            end
    end
end

fclose(cfid);
fclose(mfid);