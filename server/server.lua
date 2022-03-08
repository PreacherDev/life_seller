ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('life_seller:removeItem')
AddEventHandler('life_seller:removeItem', function(item, amount, payout, payoutBlack)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name_title = GetPlayerName(source)
    if xPlayer.getInventoryItem(item).count >= amount and amount > 0 then
        xPlayer.removeInventoryItem(item, amount)
        xPlayer.addMoney(payout)
        xPlayer.addAccountMoney('black_money', payoutBlack)
        if payoutBlack < payout then 
            TriggerClientEvent('life_seller:Notification', source, Translation[Config.Locale]['notification_success']..'\n'..Translation[Config.Locale]['payout']..'\n'..Translation[Config.Locale]['currency_label']..payout..Translation[Config.Locale]['money'])
        elseif payout < payoutBlack then
            TriggerClientEvent('life_seller:Notification', source, Translation[Config.Locale]['notification_success']..'\n'..Translation[Config.Locale]['payout']..'\n'..Translation[Config.Locale]['currency_label']..payoutBlack..Translation[Config.Locale]['black_money'])
        end
        generalWH(Config.Webhooks['sold_item'].link, Config.Webhooks['sold_item'].color, '**LIFE SELLER**',name_title..Config.Webhooks['sold_item'].message..'\n\n'..Config.Webhooks['sold_item'].item_..item..'\n'..Config.Webhooks['sold_item'].amount_..amount..'x\n\n'..Config.Webhooks['sold_item'].message2..'\n'..Config.Webhooks['sold_item'].payout_..payout..'\n'..Config.Webhooks['sold_item'].payoutB..payoutBlack, "by Preacher#6392 & Alpha#7721")
    else 
        TriggerClientEvent('life_seller:Notification', source, Translation[Config.Locale]['notification_error'])
    end
end)

RegisterNetEvent('life_seller:removeWeapon')
AddEventHandler('life_seller:removeWeapon', function(weapon, payout, payoutBlack)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name_title = GetPlayerName(source)

    if xPlayer.hasWeapon(weapon) then
        xPlayer.removeWeapon(weapon)
        xPlayer.addMoney(payout)
        xPlayer.addAccountMoney('black_money', payoutBlack)
        if payoutBlack < payout then 
            TriggerClientEvent('life_seller:Notification', source, Translation[Config.Locale]['notification_success']..'\n'..Translation[Config.Locale]['payout']..'\n'..Translation[Config.Locale]['currency_label']..payout..Translation[Config.Locale]['money'])
        elseif payout < payoutBlack then
            TriggerClientEvent('life_seller:Notification', source, Translation[Config.Locale]['notification_success']..'\n'..Translation[Config.Locale]['payout']..'\n'..Translation[Config.Locale]['currency_label']..payoutBlack..Translation[Config.Locale]['black_money'])
        end
        generalWH(Config.Webhooks['sold_weapon'].link, Config.Webhooks['sold_weapon'].color, '**LIFE SELLER**',name_title..Config.Webhooks['sold_weapon'].message..'\n\n'..Config.Webhooks['sold_weapon'].weapon_name..weapon..'\n\n'..Config.Webhooks['sold_weapon'].message2..'\n'..Config.Webhooks['sold_weapon'].payout_..payout..'\n'..Config.Webhooks['sold_weapon'].payoutB..payoutBlack, "by Preacher#6392 & Alpha#7721")
    elseif not xPlayer.hasWeapon(weapon) then
        TriggerClientEvent('life_seller:Notification', source, Translation[Config.Locale]['notification_error'])
    end
end)

function generalWH(ConfigWebhookLink, color, name_title, message, footer)
    local embed = {
    
        {
            ["color"] = color,
            ["title"] = "**".. name_title .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer,
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/939061526931832883/941277046426992690/life_services_edged.png',
            },
        }   
    }
    PerformHttpRequest(ConfigWebhookLink, function(err, text, headers) end, 'POST', json.encode({username = name_title, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
