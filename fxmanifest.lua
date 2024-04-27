fx_version 'cerulean'
games { 
    'rdr3',
    'gta5' 
}
lua54 'yes'
author 'MSperoni5 <https://github.com/MSperoni5>'
description 'Lua script to manage a database using JSON files as a data store.'
version '1.0.0'
server_only 'yes'
server_scripts { 
    'server/ErrorsHandler.lua',
    'server/FileManager.lua',
    'server/Exports.lua',
    'server/Demo.lua'
}