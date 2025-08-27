name "z4-mercado"
author "z4tomic"
contact "instagram.com/z4tomic"

fx_version "adamant"
game "gta5"

description "un simple sistema para vender articulos en el mercado negro, a base de un script de casa de empeño"

dependencies {"r3_notifications"} --https://forum.cfx.re/t/release-r3-notifications/1363540 

client_script "scripts/cl_*.lua"
server_script "scripts/sv_*.lua"

client_script "config.lua"
server_script "config.lua"
