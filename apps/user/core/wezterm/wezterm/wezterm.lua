require("tab-bar")
local utils = require("utils")
local appearance = require("appearance")
local keymap = require("keymap")

appearance = utils.merge_tables(appearance, keymap)

local ok, ssh_config = pcall(require, "ssh")
if ok then
    appearance = utils.merge_tables(appearance, ssh_config)
end

-- return utils.merge_tables(appearance, keymap)
return appearance
