local addonName, _ = ...

function Yoohoo.Config.Show()
    Settings.OpenToCategory(Yoohoo.Config.Category:GetID());
end

function Yoohoo.Options.Initialize()
    local category, layout = Settings.RegisterVerticalLayoutCategory("Yoohoo");
    Yoohoo.Config.Category = category;

    -- Audio section
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Audio"));
    do
        local setting = Settings.RegisterAddOnSetting(
            category,
            "SOUND_ID",
            Yoohoo.Config.Options.SOUND_ID,
            YOOHOO_CONFIG,
            Settings.VarType.String,
            "Notification Sound",
            "alarm_clock_warning_3"
        );

        local function GetSoundOptions()
            local container = Settings.CreateControlTextContainer();

            for _, choice in ipairs(Yoohoo.Audio.SoundLibrary) do
                container:Add(choice.key,  choice.displayName);
            end

            return container:GetData()
        end

        Settings.CreateDropdown(
            category,
            setting,
            GetSoundOptions,
            "Pick the sound that will play whenever a guild message is received."
        );

        layout:AddInitializer(CreateSettingsButtonInitializer(
            "Preview notification sound",
            "Preview",
            function()
                Yoohoo.Audio.PlaySound(true);
            end,
            "Tooltip",
            true
        ));
    end

    Settings.RegisterAddOnCategory(category);
end