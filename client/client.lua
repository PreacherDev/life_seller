ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
        Citizen.Wait(0)
        
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

-- RegisterNetEvent('esx:setJob')
-- AddEventHandler('esx:setJob', function(job)
-- 	ESX.PlayerData.job = job
-- end)
local PlayerData = {}
_menuPool = NativeUI.CreatePool()
local isPedLoaded = false
local isNearSeller = false
local isAtSeller = false
local npc = nil
local currentSeller = nil

Citizen.CreateThread(function()
    for k, seller in pairs(Config.SellerPosition) do
        if seller.enableBlip == true then
            local blip = AddBlipForCoord(seller.location.x, seller.location.y, seller.location.z)
            SetBlipSprite (blip, seller.blipId)
            SetBlipScale  (blip, seller.blipSize)
            SetBlipDisplay(blip, 4)
            SetBlipColour (blip, seller.blipColor)
            SetBlipAsShortRange(blip, seller.blipShortRange)
            BeginTextCommandSetBlipName('STRING') 
            AddTextComponentString(seller.blipName)
            EndTextCommandSetBlipName(blip)  
        end
    end
end)

Citizen.CreateThread(function()
	while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        isNearSeller = false
        isAtSeller = false
		
        for k, v in pairs(Config.SellerPosition) do
            local distance = Vdist(playerCoords, v.location.x, v.location.y, v.location.z)
            local press_e = v.openMenuText
            headerName = v.blipName 

            if distance < v.distance then
                isNearSeller = true
                isAtSeller = true 
                currentseller = v 
               
            elseif distance < v.distance + 10 then
                isNearSeller = true
                currentseller = v
                
                if _menuPool:IsAnyMenuOpen() then
                    _menuPool:CloseAllMenus()
                end
                if not isPedLoaded then
                    if not v.disableNPC then
                        RequestModel(GetHashKey(v.NPCModel))
                        while not HasModelLoaded(GetHashKey(v.NPCModel)) do
                            Wait(1)
                        end
                        npc = CreatePed(4, GetHashKey(v.NPCModel), v.location.x, v.location.y, v.location.z - 1.0, v.location.heading, false, true)
                        FreezeEntityPosition(npc, true)	
                        SetEntityHeading(npc, v.location.heading)
                        SetEntityInvincible(npc, true)
                        SetBlockingOfNonTemporaryEvents(npc, true)                    
                        isPedLoaded = true
                    end
                end
            end
        end
        if (isPedLoaded and not isNearSeller) then
            DeleteEntity(npc)
			SetModelAsNoLongerNeeded(GetHashKey(ped))
			isPedLoaded = false
		end
        Citizen.Wait(350)
	end
end)

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

Citizen.CreateThread(function()
    while true do

        if _menuPool:IsAnyMenuOpen() then 
            _menuPool:ProcessMenus()
        end

		if isNearSeller then
			DrawMarker(27, currentseller.x, currentseller.y, currentseller.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*1.5, 1.0*1.5, 1.0, 0, 255, 0, 50, false, false, 2, false, false, false, false)
        else 
            Citizen.Wait(350)
        end
        if isAtSeller then
            
            -- print(currentseller.RequiredJob)
            showInfobar(currentseller.openMenuText)
            if IsControlJustReleased(0, 38) and not _menuPool:IsAnyMenuOpen() then
                if (ESX.PlayerData.job and ESX.PlayerData.job.name == currentseller.RequiredJob) or currentseller.RequiredJob == '' then
                    openMenu()
                else 
                    print(ESX.PlayerData.job.name)
                    print('no')
                end
            end
        end
        Citizen.Wait(1)
    end
end)

function openMenu()

	mainMenu = NativeUI.CreateMenu(headerName, Translation[Config.Locale]['seller_header_desc'])
	_menuPool:Add(mainMenu)

    itemSubmenu = _menuPool:AddSubMenu(mainMenu, Translation[Config.Locale]['item_submenu'], Config.MenuColor..Translation[Config.Locale]['item_submenu_desc'])
    weaponSubmenu = _menuPool:AddSubMenu(mainMenu, Translation[Config.Locale]['weapon_submenu'], Config.MenuColor..Translation[Config.Locale]['weapon_submenu_desc'])
    
    for k, v in pairs(Config.Seller[currentseller.type]) do
		if v.type ~= nil and v.type == 'weapon' then

			weaponSubmenu.ParentItem:RightLabel(Config.MenuColor..Translation[Config.Locale]['submenu_rightlabel'])
			
			local sellItem = NativeUI.CreateItem(v.label, Config.MenuColor..Translation[Config.Locale]['item_desc']..v.label..Translation[Config.Locale]['item_desc_2'])
			weaponSubmenu:AddItem(sellItem)
			if v.payoutBlack < v.payout then 
			    sellItem:RightLabel(Config.MenuColor..Translation[Config.Locale]['currency_label'] .. v.payout)
            elseif v.payoutBlack > v.payout then 
                sellItem:RightLabel(Config.MenuColor..Translation[Config.Locale]['currency_label'] .. v.payoutBlack)
            end

			sellItem.Activated = function(sender, index)
                TriggerServerEvent('life_seller:removeWeapon',  v.name, v.payout, v.payoutBlack)
            end
        else
			
            itemSubmenu.ParentItem:RightLabel(Config.MenuColor..Translation[Config.Locale]['submenu_rightlabel'])

			local sellItem = NativeUI.CreateItem(v.label, Config.MenuColor..Translation[Config.Locale]['item_desc']..v.label..Translation[Config.Locale]['item_desc_2'])
			itemSubmenu:AddItem(sellItem)

			sellItem.Activated = function(sender, index)
				local display = CreateDialog(Translation[Config.Locale]['amount']..Config.MenuColor..v.label..Translation[Config.Locale]['amount_2'])
				if (display ~= nil) then
                    displayAmount = tonumber(display)
					if displayAmount and displayAmount > 0 then
						TriggerServerEvent('life_seller:removeItem', v.name, displayAmount, v.payout*displayAmount, v.payoutBlack*displayAmount)
                        print(v.name)
                        name = v.name 
                        payout = v.payout 
                        payoutBlack = v.payoutBlack
					end
				end
			end
        end
        
    end
      
    mainMenu:Visible(true)
	_menuPool:RefreshIndex()
	_menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(false)
end

function CreateDialog(DisplayTitle)
	AddTextEntry(DisplayTitle, DisplayTitle)
	DisplayOnscreenKeyboard(1, DisplayTitle, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local displayResult = GetOnscreenKeyboardResult()
		return displayResult
	end
end

AddEventHandler('onResourceStop', function(life_seller)
	if (GetCurrentResourceName() ~= life_seller) then
		return
	end
	print("stopped life_seller")
	SetEntityAsNoLongerNeeded(ped_hash)
	SetEntityAsNoLongerNeeded(npc)
end)

AddEventHandler('onResourceStart', function(life_seller)
	if (GetCurrentResourceName() ~= life_seller) then
		return
	end
	print("started life_seller")
end)

function ShowNotification(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, false)
end

RegisterNetEvent('life_seller:Notification')
AddEventHandler('life_seller:Notification', function(msg)
	ShowNotification(msg)
end)
