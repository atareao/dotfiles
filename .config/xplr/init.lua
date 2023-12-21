version = '0.21.3'

local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path

require("dual-pane").setup()
require("command-mode").setup()
require("web-devicons").setup()
require("wl-clipboard").setup()
