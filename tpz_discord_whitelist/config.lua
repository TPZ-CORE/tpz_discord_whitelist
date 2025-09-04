Config = {}

-----------------------------------------------------------
--[[ Queue Priorities ]]--
-----------------------------------------------------------

Config.sv_maxclients = 48 -- YOUR SERVER sv_maxclients ?

Config.DefaultPriority = 4 -- Lowest priority?

-- Display on the server console the players who attempted to join without whitelist access?
Config.DisplayNotWhitelistedJoinAttempts = true

-- Set to false if you don't want the system to print when a player connects to the server (only for allowlisted users).
Config.DisplayWhitelistedOnConnecting = true 

Config.Priorities = {

    -- Steam identifier priorities
    SteamIdentifiers = {
        ['steam:xxxxxxxxxxxxxxx'] = 1, -- highest priority
        ['steam:xxxxxxxxxxxxxxx'] = 2, -- second highest priority.
        ['steam:xxxxxxxxxxxxxxx'] = 3, -- third highest priority.
    },

    -- Requires the discord role Id's. 
    DiscordRoles = {
        [11111111111111111111111] = 1, -- highest priority
        [22222222222222222222222] = 2, -- second highest priority.
        [33333333333333333333333] = 3, -- third highest priority.
    },

}

---------------------------------------------------------------
--[[ Discord API Configurations ]]--
---------------------------------------------------------------

-- The specified discord roles will be considered as administrators and will be used in many scripts.
-- local hasPermissions = xPlayer.hasAdministratorPermissions() The specified export is used for those permissions.
Config.DiscordAdministratorRoles  = { 1111111111111111, 222222222222222222 }

-- The specified discord group names will be considered as administrators and will be used in many scripts.
-- local hasPermissions = xPlayer.hasAdministratorPermissions(group, discordRoles) The specified export is used for those permissions.
Config.AdministratorGroups = { 'admin' }
