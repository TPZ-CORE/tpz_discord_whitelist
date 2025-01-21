
-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

-- The following event is triggered when player is connecting in order to check the user's discord roles.
AddEventHandler('playerConnecting', function(name, setKickReason, defer) 
    local _source   = source

	defer.defer();

    -- The specified API function checks for Discord Roles and Groups
    -- In our case since the player has not selected any player yet,
    -- Group is null, we check only for Discord Roles.
    local hasPermissions = exports.tpz_core:hasAdministratorPermissions(_source)

    while hasPermissions == nil do 
        Wait(100)
    end 

    if ( not hasPermissions ) then
        defer.done(Locales['NOT_WHITELISTED'])
        return
    end

	defer.done();

end)
