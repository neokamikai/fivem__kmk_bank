fx_version 'cerulean'
games { 'gta5' }

author 'Kamikai <kamikai@gmail.com>'
description 'Example resource'
version '0.0.1'

shared_scripts {
  '@es_extended/imports.lua', '@es_extended/locale.lua',
  'shared/**.lua'
}

client_scripts { 
  'client/**.lua',
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@esx_society/server/main.lua',
  'server/**.lua',
}


files {
  'web/**.*'
}

ui_page 'web/index.html'

dependency 'es_extended'
