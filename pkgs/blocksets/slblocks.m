function blkStruct = slblocks
% SLBLOCKS Defines the block library，并添加到库浏览器

% 将 EnableLBRepository 库属性设置为 'on'，库才会出现在库浏览器中。
% set_param(gcs,'EnableLBRepository','on');

%blkStruct.Name = sprintf('ARM Cortex-M');
%blkStruct.OpenFcn = 'armcortexmlib';
%blkStruct.MaskInitialization = '';
%blkStruct.MaskDisplay = 'disp(''ARM Cortex-M'')';

Browser.Library = 'nplib';
Browser.Name    = 'Nextpilot Aerospace Blockset';
Browser.IsFlat  = 0; % Is this library "flat" (i.e. no subsystems)?

blkStruct.Browser = Browser;

% Define information for model updater
%blkStruct.ModelUpdaterMethods.fhSeparatedChecks = @ecblksUpdateModel;
