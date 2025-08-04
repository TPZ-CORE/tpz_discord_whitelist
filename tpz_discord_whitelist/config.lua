Config = {}

-----------------------------------------------------------
--[[ Queue Priorities ]]--
-----------------------------------------------------------

Config.sv_maxclients   = 48 -- YOUR SERVER sv_maxclients ?

Config.DefaultPriority = 4 -- Lowest priority?

Config.Priorities = {
    ['steam:xxxxxxxxxxxxxxx'] = 1, -- highest priority
    ['steam:xxxxxxxxxxxxxxx'] = 2, -- second highest priority.
    ['steam:xxxxxxxxxxxxxxx'] = 3, -- third highest priority.
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
