local debug = {}
local conf = require("modules.debug.config")


debug["mfussenegger/nvim-dap"] = {
    opt = true,
    cmd = {
        "DapSetLogLevel",
        "DapShowLog",
        "DapContinue",
        "DapToggleBreakpoint",
        "DapToggleRepl",
        "DapStepOver",
        "DapStepInto",
        "DapStepOut",
        "DapTerminate",
    },
    module = "dap",
    config = conf.dap
}

debug["rcarriga/nvim-dap-ui"] = {
    opt = true,
    after = "nvim-dap",
    config = conf.dapui
}


return debug

