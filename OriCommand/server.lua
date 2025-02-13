local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Commands.Add(Config.Command, "Get free items", {}, false, function(source, args)
    local playerId = source
    local player = QBCore.Functions.GetPlayer(playerId)
    local identifier = player.PlayerData.citizenid


    MySQL.query("SELECT has_used FROM used_commands WHERE identifier = ?", { identifier }, function(result)
        if result[1] and result[1].has_used then
            TriggerClientEvent('ox_lib:notify', playerId, { description = "You have already received your items.", type = "error" })
            return
        end


        for _, item in ipairs(Config.ItemsToGive) do
            player.Functions.AddItem(item.name, item.count)
        end


        MySQL.query("INSERT INTO used_commands (identifier, has_used) VALUES (?, ?) ON DUPLICATE KEY UPDATE has_used = ?", 
        { identifier, true, true })


        TriggerClientEvent('ox_lib:notify', playerId, { description = "You have received your items!", type = "success" })
    end)
end, false)


RegisterCommand("resetItems", function(source)
    MySQL.query("UPDATE used_commands SET has_used = false")
    TriggerClientEvent('ox_lib:notify', source, { description = "Command usage has been reset for all players.", type = "success" })
end, true)
