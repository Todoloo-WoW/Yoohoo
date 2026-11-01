local addonName, _ = ...

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    if Yoohoo.isInitialized then
        return;
    end

    Yoohoo.Config.Initialize();
    Yoohoo.Audio.Initialize();

    Yoohoo.Options.Initialize();

    Yoohoo.isInitialized = true;
end)