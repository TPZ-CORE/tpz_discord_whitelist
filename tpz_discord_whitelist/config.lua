Config = {}

---------------------------------------------------------------
--[[ Discord API Configurations ]]--
---------------------------------------------------------------

-- The specified discord roles will be considered as administrators and will be used in many scripts.
-- local hasPermissions = xPlayer.hasAdministratorPermissions() The specified export is used for those permissions.
Config.DiscordAdministratorRoles  = { 1111111111111111, 222222222222222222 }

-- The specified discord group names will be considered as administrators and will be used in many scripts.
-- local hasPermissions = xPlayer.hasAdministratorPermissions(group, discordRoles) The specified export is used for those permissions.
Config.AdministratorGroups = { 'admin' }
