
-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

-- @GetTableLength returns the length of a table.
GetTableLength = function(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- @HasAllowlistedDiscordRole returns if the player is allowlisted / not.
HasAllowlistedDiscordRole = function(userRoles)
    local userRolesLength = GetTableLength(userRoles)

    if userRolesLength <= 0 then
        return false
    end

    for _, role in pairs (Config.Settings.AllowlistedRoles) do

        for _, userRole in pairs (userRoles) do
        
            if tonumber(userRole) == tonumber(role) then
                print("exists")
                return true
            end

        end
    end

    return false
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

-- The following event is triggered when player is connecting in order to check the user's discord roles.
AddEventHandler('playerConnecting', function(name, setKickReason, defer) 
    local _source   = source

	defer.defer();

	local userRoles = GetDiscordRoles(_source, Config.Settings.DiscordServerID)

    if not userRoles or userRoles == nil then
        defer.done(Locales['CODE_200'])
        return
    end

    local hasRequiredRole = HasAllowlistedDiscordRole(userRoles)

    if ( not hasRequiredRole ) then
        defer.done(Locales['NOT_WHITELISTED'])
        return
    end

	defer.done();

end)