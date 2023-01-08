fx_version "cerulean"
games { "gta5" }

name "JayBaitCar"
description "A easy bait car script"
version "0.0.1"
author "JayPaulinCodes (https://github.com/JayPaulinCodes)"

github_link "JayPaulinCodes/JayBaitCar"

locale "en"

ui_page "html/index.html"

shared_scripts {
    "common/locales.lua",
    "locales/*.lua",
    "objects/*.lua",
    "common/config.lua",
    "common/commands.lua",
    "common/chatTemplates.lua",
}

server_scripts {
    "server/VersionCheck.lua",
}

client_scripts {
    "client/functions.lua",
    "client/events.lua",
    "client/main.lua",
}

files {
    "html/imgs/*.png",
    "html/index.html",
    "html/css/JayBaitCar.css",
    "html/css/JayBaitCar.js",
}