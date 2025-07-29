function generate_flight_code

model = 'flightControlSystem';

isModelLoaded = bdIsLoaded(model);
isModelDirty = bdIsDirty(model);

if ~isModelLoaded
    load_system(model);
end

rtwbuild(model);

if ~isModelDirty
    % save_system(model);
end

if ~isModelLoaded
    bdclose(model);
end