local vim = vim
local g, o, fn, api = vim.g, vim.o, vim.fn, vim.api
local config = {}


function config.dap()
    local icons = { dap = require("modules.ui.icons").get("dap") }

    vim.api.nvim_command([[packadd nvim-dap-ui]])
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ABE9B3" })

    vim.fn.sign_define(
        "DapBreakpoint",
        { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
    vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

    dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb",
    }
    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},

            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            runInTerminal = false,
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    dap.adapters.go = function(callback, _)
        local stdout = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
            stdio = { nil, stdout },
            args = { "dap", "-l", "127.0.0.1:" .. port },
            detached = true,
        }
        handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
            stdout:close()
            handle:close()
            if code ~= 0 then
                vim.notify(
                    string.format('"dlv" exited with code: %d, please check your configs for correctness.', code),
                    vim.log.levels.WARN,
                    { title = "[go] DAP Warning!" }
                )
            end
        end)
        assert(handle, "Error running dlv: " .. tostring(pid_or_err))
        stdout:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require("dap.repl").append(chunk)
                end)
            end
        end)
        -- Wait for delve to start
        vim.defer_fn(function()
            callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
    end
end


function config.dapui()
    local icons = {
        ui = require("modules.ui.icons").get("ui"),
        dap = require("modules.ui.icons").get("dap"),
    }
    local opts = {
        icons = { expanded = icons.ui.ArrowOpen, collapsed = icons.ui.ArrowClosed, current_frame = icons.ui.Indicator },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
        },
        layouts = {
            {
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.25, -- Can be float or integer > 1
                    },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks", size = 0.25 },
                    { id = "watches", size = 0.25 },
                },
                size = 40,
                position = "left",
            },
            { elements = { "repl" }, size = 10, position = "bottom" },
        },
        -- Requires Nvim version >= 0.8
        controls = {
            enabled = true,
            -- Display controls in this session
            element = "repl",
            icons = {
                pause = icons.dap.Pause,
                play = icons.dap.Play,
                step_into = icons.dap.StepInto,
                step_over = icons.dap.StepOver,
                step_out = icons.dap.StepOut,
                step_back = icons.dap.StepBack,
                run_last = icons.dap.RunLast,
                terminate = icons.dap.Terminate,
            },
        },
        floating = {
            max_height = nil,
            max_width = nil,
            mappings = { close = { "q", "<Esc>" } },
        },
        windows = { indent = 1 },
    }

    require("dapui").setup(opts)
end


return config
