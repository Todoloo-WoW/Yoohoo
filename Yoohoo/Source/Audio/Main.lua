Yoohoo.Audio.SoundLibrary = {
    {
        id = 12889,
        key = "alarm_clock_warning_3",
        displayName = "Alarm Clock Warning 3"
    },
    {
        id = 7355,
        key = "tutorial_popup",
        displayName = "Tutorial Popup"
    },
    {
        id = 18019,
        key = "bnet_notification",
        displayName = "Battle.net Notification"
    },
    {
        id = 3175,
        key = "map_ping",
        displayName = "Map Ping"
    },
    {
        id = 38326,
        key = "archaeology_dig_site_complete",
        displayName = "Archaeology Dig Site Complete"
    },
    {
        id = 193459,
        key = "cypher_research_complete",
        displayName = "Cypher Research Complete"
    },
    {
        id = 3081,
        key = "tell_message",
        displayName = "Tell Message"
    }
};

table.sort(Yoohoo.Audio.SoundLibrary, function(a, b)
    return strcmputf8i(a.displayName, b.displayName) < 0;
end);

local notificationSoundsByKey = {}
for _, choice in ipairs(Yoohoo.Audio.SoundLibrary) do
    notificationSoundsByKey[choice.key] = choice;
end

local frame;

function Yoohoo.Audio.Initialize()
    frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_GUILD")

    frame:SetScript("OnEvent", function(self, event, ...)
        local senderGuid = select(12, ...)

        if senderGuid == UnitGUID("player") then
            return
        end

        Yoohoo.Audio.PlaySound();
    end)
end

local lastNotificationplaybackTime;
local activeSoundHandle;

function Yoohoo.Audio.PlaySound(isPreview)
    local key = Yoohoo.Config.Get(Yoohoo.Config.Options.SOUND_ID);

    local choice = notificationSoundsByKey[key];
    if not choice or not choice.id then
        return;
    end

    local now = GetTime();

    if not isPreview and lastNotificationplaybackTime and now - lastNotificationplaybackTime < 0.5 then
        return;
    end

    if activeSoundHandle then
        StopSound(activeSoundHandle);
        activeSoundHandle = nil;
    end

    local played, handle = PlaySound(choice.id, "Master");

    if played then
        activeSoundHandle = handle;

        if not isPreview then
            lastNotificationplaybackTime = now;
        end
    end
end