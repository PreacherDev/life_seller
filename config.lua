Config = {}

Config.Locale = 'de' 

Config.Webhooks = { -- colorlist in life_seller/webhookcolors.txt
    ['sold_weapon'] = {
        link = 'https://discord.com/api/webhooks/949974665001054218/t9XvCwUn8Oaq5C85ajePIjusymC27i2jADmF6HZTsyese-aYDXbV4a0TpLLa_d5ylceh',
        color =  3447003,
        message = ' is at the Seller.',
        weapon_name = '**WEAPON: **',
        message2 = 'PAYMENT:',
        payout_ = '**MONEY: **$',
        payoutB = '**BLACK MONEY: **$',
    },
    ['sold_item'] = {
        link = 'https://discord.com/api/webhooks/949974665001054218/t9XvCwUn8Oaq5C85ajePIjusymC27i2jADmF6HZTsyese-aYDXbV4a0TpLLa_d5ylceh',
        color =  3447003,
        message = ' is at the Seller.',
        item_ = '**ITEM: **',
        amount_ = '**AMOUNT: **',
        message2 = 'PAYMENT:',
        payout_ = '**MONEY: **$',
        payoutB = '**BLACK MONEY: **$',
    },
}

Config.SellerPosition = {
    {
        type = 'legal_seller', 
        RequiredJob = '', -- leave blank if no job is required
        distance = 2.0,
        blipName = '~w~Legal Seller',
        enableBlip = true,
        blipShortRange = true,
        blipId = 1,
        blipSize = 0.8,
        blipColor = 0,
        openMenuText = 'Press ~INPUT_PICKUP~ to open the legal menu',
        location = {x = 120.0, y = 100.0,  z = 81.1, heading = 80.0},
        disableNPC = false,
        NPCModel = 'mp_m_shopkeep_01'
    },
    {
        type = 'illegal_seller',  
        RequiredJob = '',
        distance = 2.0,
        blipName = '~r~Illegal Seller',
        enableBlip = true,
        blipShortRange = true,
        blipId = 1,
        blipSize = 0.8,
        blipColor = 1,
        openMenuText = 'Press ~INPUT_PICKUP~ to open the illegal menu',
        location = {x = 1367.27, y = 1149.49, z = 113.76, heading = 80.0},
        disableNPC = false,
        NPCModel = 'mp_m_shopkeep_01'
    },
}

Config.Seller = {
    ['legal_seller'] = {
        -- sell item
        {label = 'Wood', name = 'wood', payout = 200, payoutBlack = 0}, -- payoutBlack means payout with black_money / payout means payout with money
        {label = 'Bandage', name = 'bandage', payout = 0, payoutBlack = 200},
        -- sell weapon
        {type = 'weapon', label = 'Pistol', name = 'WEAPON_PISTOL', payout = 200, payoutBlack = 0},
        {type = 'weapon', label = 'Combat Pistol', name = 'WEAPON_COMBATPISTOL', payout = 200, payoutBlack = 0},
    },
    ['illegal_seller'] = {
        
        {label = 'Wood', name = 'wood', payout = 200, payoutBlack = 0},
        {label = 'Bandage', name = 'bandage', payout = 0, payoutBlack = 200},
        
        {type = 'weapon', label = 'Pistol', name = 'WEAPON_PISTOL', payout = 0, payoutBlack = 100},
        {type = 'weapon', label = 'Combat Pistol', name = 'WEAPON_COMBATPISTOL', payout = 0, payoutBlack = 100},
    },
}

-- ↓ local menu colors ↓
local red = '~r~'
local green = '~g~'
local blue = '~b~'
local yellow = '~y~'
local purple = '~p~'
local grey = '~c~'
local dark_grey = '~m~'
local orange = '~o~'
local standardcolor = '' -- no color/standard NativeUI color (needs to be non colored)
-- ↓ menu color from local menu colors ↓
Config.MenuColor = green

Translation = {
    ['de'] = {
        ['item_submenu'] = 'Gegenstände',
        ['item_submenu_desc'] = 'Gegenstände verkaufen',
        ['weapon_submenu'] = 'Waffen',
        ['weapon_submenu_desc'] = 'Waffen verkaufen',
        ['currency_label'] = '$',
        ['seller_header_desc'] = 'Verkaufsmenü',
        ['submenu_rightlabel'] = '→→→',
        ['item_desc'] = 'Verkaufe ',
        ['item_desc_2'] = ' an den Typen',
        ['amount'] = 'Wie viele ',
        ['amount_2'] = '\'s~w~ willst du verkaufen?',
        ['notification_success'] = 'Erfolgreich verkauft',
        ['notification_error'] = 'Verkauf fehlgeschlagen',
        ['money'] = ' Bargeld',
        ['black_money'] = ' Schwarzgeld',
        ['payout'] = 'Erhalten:',
        
    },
    ['en'] = {
        ['item_submenu'] = 'Items',
        ['item_submenu_desc'] = 'Sell Items',
        ['weapon_submenu'] = 'Weapons',
        ['weapon_submenu_desc'] = 'Sell Weapons',
        ['currency_label'] = '$',
        ['seller_header_desc'] = 'Seller Menu',
        ['submenu_rightlabel'] = '→→→',
        ['item_desc'] = 'Sell ',
        ['item_desc_2'] = ' to the Guy',
        ['amount'] = 'How many ',
        ['amount_2'] = '\'s~w~ do you want to sell?',
        ['notification_success'] = 'Sold successfully',
        ['notification_error'] = 'Selling failed',
        ['money'] = ' Cash',
        ['black_money'] = ' Black Money',
        ['payout'] = 'You got:',
    },
}
