local function split(str, delim)
    if str:find(delim) == nil then
        return { str }
    end
    local result = {}
    local pat = "(.-)" .. delim .."()"
    local last_pos
    for part,pos in str:gmatch(pat) do
        table.insert(result, part)
        last_pos = pos
    end
    table.insert(result, str:sub(last_pos))

    return result
end


s = "n,v"
key = "n,v|ab"
local mode, keymap = key:match("([^|]*)|?(.*)")
local mode = split(mode, ",")
for k,v in pairs(mode) do
    print(v)
end
print(mode)
