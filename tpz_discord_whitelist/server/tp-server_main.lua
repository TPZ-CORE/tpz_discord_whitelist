local TIMEOUT = 60 -- 1 minute as default for timeout if something goes wrong.

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

-- The following event is triggered when player is connecting in order to check the user's discord roles.
AddEventHandler('playerConnecting', function(name, setKickReason, defer) 
    local _source      = source
    local currentTime  = 0

	defer.defer();

    -- The specified API function checks for Discord Roles and Groups
    -- In our case since the player has not selected any character yet,
    -- Group is null, we check only for Discord Roles.
    local hasPermissions = exports.tpz_core:getCoreAPI().hasAdministratorPermissions(_source, Config.AdministratorGroups, Config.DiscordAdministratorRoles)

    while hasPermissions == nil do 
        Wait(1000)

        currentTime = currentTime + 1
        
        if currentTime >= TIMEOUT then
            defer.done(Locales['TIMEOUT'])
            break
        end 

    end 

    -- In case when the while loop breaks to make sure it will not run
    -- any of the rest of the code since TIMEOUT. 
    if currentTime >= TIMEOUT then
        defer.done(Locales['TIMEOUT'])
        return
    end 

    if ( not hasPermissions ) then
        defer.done(Locales['NOT_WHITELISTED'])
        return
    end

	defer.done();

end)
