Config = {}

-- cambiar posicion del menu
Config.MenuAlign = "top-left"

-- cambiar articulos para vender | item_ name = price
Config.MercadoNegroItems = {
	dragon_scales = 2500,
	bones = 120,
	nuts_and_bolts = 80,
	gold_ring = 1250,
	metalscrap = 50,
}

Config.GiveBlack = true -- dar dinero negro a cambio? pon "false" para dar dinero limpio

Config.MercadoNegroLocation =  {x = 182.07, y = -1319.06, z = 29.32} --coordenadas  donde estara ubicado el mercado negro

-- MercadoNegro blip
Config.MercadoNegroBlipText = "Mercado negro"
Config.MercadoNegroBlipColor = 5
Config.MercadoNegroBlipSprite = 272

-- Opening hours
Config.EnableOpeningHours = false -- habilitar horarios? para roles que solo se pueda vender en ciertas horas, (como en la madrugada)
Config.OpenHour = 9 -- desde que hora esta abierto el mercado negro?
Config.CloseHour = 18 -- hasta que hora estara abierto el mercado negro?