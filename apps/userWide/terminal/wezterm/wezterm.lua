local utils = require("utils")
local appearance = require("appearance")
local keymap = require("keymap")

appearance = utils.merge_tables(appearance, keymap)

-- return utils.merge_tables(appearance, keymap)
return appearance
