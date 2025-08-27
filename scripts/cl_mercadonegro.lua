ESX = nil
local menuOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if GetDistanceBetweenCoords(coords, vector3(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z), true) < 1.5 then
			if Config.EnableOpeningHours then
				local ClockTime = GetClockHours()
				if Config.CloseHour < Config.OpenHour then
					if (ClockTime >= Config.OpenHour and ClockTime < 24) or (ClockTime <= Config.CloseHour -1 and ClockTime > 0) then
						if not menuOpen then
							Draw3DText(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z, "~g~E~w~ - Para abrir La Casa de Empeño")
							if IsControlJustReleased(0, 38) then
								OpenMercadoNegro()
							end
						else
								Citizen.Wait(500)
						end
					else
						Draw3DText(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z, "La Casa de Empeño esta Cerrado, abre a las ~r~" .. Config.OpenHour ..":00")
					end
				else
					if ClockTime >= Config.OpenHour and ClockTime <= Config.CloseHour - 1 then
						if not menuOpen then
							Draw3DText(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z, "~g~E~w~ - Para abrir La Casa de Empeño")
							if IsControlJustReleased(0, 38) then
								OpenMercadoNegro()
							end
						else
								Citizen.Wait(500)
						end
					else
						Draw3DText(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z, "La Casa de Empeño esta Cerrado, abre a las ~r~" .. Config.OpenHour ..":00")
					end
				end
			else
				if not menuOpen then
					Draw3DText(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z, "~g~E~w~ - Para abrir la casa de Empeño")
					if IsControlJustReleased(0, 38) then
						OpenMercadoNegro()
					end
				else
						Citizen.Wait(500)
				end
			end
		else
			if menuOpen then
				menuOpen = false
				ESX.UI.Menu.CloseAll()
			end

			Citizen.Wait(500)
		end
	end
end)

function OpenMercadoNegro()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.MercadoNegroItems[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, "$" .. ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MercadoNegro', {
		title    = "La Casa de Empeño",
		align    = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('r3_prospecting:sellItem', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

function CreateBlipCircle(coords, text, color, sprite)
	blip = AddBlipForCoord(coords)

	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	CreateBlipCircle(vector3(Config.MercadoNegroLocation.x, Config.MercadoNegroLocation.y, Config.MercadoNegroLocation.z), Config.MercadoNegroBlipText, Config.MercadoNegroBlipColor, Config.MercadoNegroBlipSprite)
end)

function Draw3DText(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
