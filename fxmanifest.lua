fx_version('cerulean')
games({ 'gta5' })

author 'Galaxie Geek <Galaxie Geek#1486>'
description 'Job Gruppe 6'

shared_script({
    'config/config.lua',
    '@es_extended/imports.lua'
});

server_scripts({
    '@mysql-async/lib/MySQL.lua',
    "server/*.lua"
});

client_scripts({
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client/*.lua"
});