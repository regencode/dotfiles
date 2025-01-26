require('options') -- Vim Options
require('config.lazy') -- load lazy config

if vim.g.vscode then
    require('vs_plugins')
else
    require('plugins') -- Lazy Plugins
end
require('user_commands')







































