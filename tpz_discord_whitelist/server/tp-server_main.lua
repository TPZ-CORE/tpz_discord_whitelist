local TPZ = exports.tpz_core:getCoreAPI()

local TIMEOUT = 60 -- 1 minute as default for timeout if something goes wrong.

local Queue = {}

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local GetSteamID = function(src)
    local sid = GetPlayerIdentifiers(src)[1] or false

    if (sid == false or sid:sub(1,5) ~= "steam") then
        return false
    end

    return sid
end

local function RemovePlayerFromQueue(_source)
    local leavingPosition = Queue[_source] and Queue[_source].position
    Queue[_source] = nil
    
    if leavingPosition then
        
        for _, user in pairs(Queue) do
            if user.position > leavingPosition then
                user.position = user.position - 1
            end
        end
    end
end

local function GetPlayerPriority(source, identifier)
    local _source       = source
    local priority      = Config.DefaultPriority
    local discordRoles  = TPZ.GetPlayer(_source).getDiscordRoles()

    for _, role in pairs (discordRoles) do

        if Config.Priorities.DiscordRoles[tonumber(role)] then
            priority = Config.Priorities.DiscordRoles[tonumber(role)]
            break
        end

    end

    -- Steam Hex overriding the discord role priority. 
    if Config.Priorities.SteamIdentifiers[identifier] then
        priority = Config.Priorities.SteamIdentifiers[identifier]
    end

    return priority
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

-- The following event is triggered when player is connecting in order to check the user's discord roles.
AddEventHandler('playerConnecting', function(name, setKickReason, defer) 
    local _source      = source
    local currentTime  = 0

	defer.defer();

    local steamIdentifier

    -- mandatory wait!
    Wait(0) 

    steamIdentifier = GetSteamID(_source)
    -- mandatory wait!
    Wait(0)

    local xPlayer = TPZ.GetPlayer(_source)

    -- Checking ace permissions.
    local hasPermissionsByAce = xPlayer.hasPermissionsByAce("tpzcore.discord_whitelist.allow")

    local hasPermissions      = hasPermissionsByAce

    -- The specified API function checks for Discord Roles and Groups
    -- In our case since the player has not selected any character yet,
    -- Group is null, we check only for Discord Roles.
    if not hasPermissions then
        hasPermissions = xPlayer.hasAdministratorPermissions(Config.AdministratorGroups, Config.DiscordAdministratorRoles)
    end

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

    local insertPosition = 1
    local now = os.time()

    local priority = GetPlayerPriority(_source, steamIdentifier)

    for _, user in pairs(Queue) do
        if priority > user.priority then
            insertPosition = math.max(insertPosition, user.position + 1)

        elseif priority == user.priority and now > (user.joinedAt or now) then
            insertPosition = math.max(insertPosition, user.position + 1)
        end
    end

    -- Shift others down
    for _, user in pairs(Queue) do
        if user.position >= insertPosition then
            user.position = user.position + 1
        end
    end

    -- Add to queue
    Queue[_source] = {
        source   = _source,
        position = insertPosition,
        priority = priority,
        joinedAt = now,
        waiting  = 0,
        defer    = defer
    }

end)

-----------------------------------------------------------
--[[ Threads ]]--
-----------------------------------------------------------

Citizen.CreateThread(function() 

    while true do

        Wait(1000)

        local length = TPZ.GetTableLength(Queue)

        if length > 0 then

            local maxPlayers     = Config.sv_maxclients
            local currentPlayers = TPZ.GetTableLength(GetPlayers())

            for _, user in pairs (Queue) do

                user.waiting = user.waiting + 1

                user.defer.update(string.format(Locales['CHECKING_PRIORITY_POSITION'], user.position, length, user.waiting))

                if currentPlayers < maxPlayers and user.position <= 1 then
                    RemovePlayerFromQueue(user.source)
                    user.defer.done();
                end

                if GetPlayerName(user.source) == nil then
                    RemovePlayerFromQueue(user.source)
                end

            end

        end
    end

end)
