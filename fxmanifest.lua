fx_version 'cerulean'
games { 'gta5' }

author 'Kamikai <kamikai@gmail.com>'
description 'Example resource'
version '0.0.1'

shared_scripts { 'shared/**' }
client_scripts { 
  '@esx_exntended/imports.lua',
  'client/**.lua',
}
server_scripts {
  'server/**.lua',
}

url_page 'web/index.html'

export 'SayHello'