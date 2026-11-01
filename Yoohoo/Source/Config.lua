Yoohoo.Config.Options = {
    SOUND_ID = "sound_id"
}

Yoohoo.Config.Defaults = {
    [Yoohoo.Config.Options.SOUND_ID] = "alarm_clock_warning_3"
}

function Yoohoo.Config.Reset()
    YOOHOO_CONFIG = {};
    for option, value in pairs(Yoohoo.Config.Defaults) do
        YOOHOO_CONFIG[option] = value;
    end
end

function Yoohoo.Config.Initialize()
    if YOOHOO_CONFIG == nil then
        Yoohoo.Config.Reset();
    else
        for option, value in pairs(Yoohoo.Config.Defaults) do
            if YOOHOO_CONFIG[option] == nil then
                YOOHOO_CONFIG[option] = value;
            end
        end
    end
end

function Yoohoo.Config.IsValidOption(key)
    for _, options in pairs(Yoohoo.Config.Options) do
        if options == key then
            return true;
        end
    end

    return false;
end

function Yoohoo.Config.Get(key)
    if YOOHOO_CONFIG == nil then
        return Yoohoo.Config.Defaults[key];
    elseif not Yoohoo.Config.IsValidOption(key) then
        error("Invalid option.");
    else
        return YOOHOO_CONFIG[key];
    end
end

function Yoohoo.Config.Set(key, value)
    if YOOHOO_CONFIG == nil then
        error("Yoohoo config has not been initialized.");
    elseif not Yoohoo.Config.IsValidOption(key) then
        error("Invalid option.");
    else
        YOOHOO_CONFIG[key] = value;
    end
end