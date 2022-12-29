require('colorizer').setup()

local notify = require('notify')
notify.setup({ background_colour = '#000000' })
vim.notify = notify

require('numb').setup()
require('aerial').setup()
