local utils = {}

function utils.file_exists(file)
  -- some error codes:
  -- 13 : EACCES - Permission denied
  -- 17 : EEXIST - File exists
  -- 20	: ENOTDIR - Not a directory
  -- 21	: EISDIR - Is a directory
  --
  local isok, errstr, errcode = os.rename(file, file)
  if isok == nil then
     if errcode == 13 then 
        -- Permission denied, but it exists
        return true
     end
     return false
  end
  return true
end

function utils.dir_exists(path)
    return file_exists(path .. "/")
end

function utils.is_windows()
    if jit then
        return jit.os
    end
    local fn,err = assert(io.popen("uname>/dev/null"), "r")
    if fn then
        return false
    else
        return true
    end
end

function utils.get_home()
    if utils.is_windows() then
        utils.home = os.getenv("HOMEDRIVE") or "C:"
        utils.home = utils.home .. ( os.getenv("HOMEPTH") or "\\" )
    else
        utils.home = os.getenv("HOME") or "."
    end
end

function utils.set_opt(key, value)
    vim.api.nvim_set_option(key, value)
end

return utils
