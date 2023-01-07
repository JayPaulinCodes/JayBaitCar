fx_version "cerulean"
games { "gta5" }

author "JayPaulinCodes (https://github.com/JayPaulinCodes)"
description "Bait Car script"

version "0.0.1"

files {
    "html/index.html",
    "html/css/JayBaitCar.css"
}

shared_scripts{
    "common/locales.lua",
    "locales/*.lua",
    "common/config.lua",
    "common/commands.lua",
    "common/chatTemplates.lua",
    "common/controls.lua",
}

client_scripts {
    "client/main.lua",
    "client/functions.lua",
    "client/events.lua",
} 

server_scripts {
    -- "server/VersionCheck.lua",
    "server/main.lua",
    "server/functions.lua",
    "server/events.lua",
} 