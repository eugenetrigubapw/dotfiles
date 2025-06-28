-- debug.lua
--
-- Configures the DAP plugin to debug code.

---@class DapConfig
---@field name string Configuration name
---@field type string Debug adapter type
---@field request string Launch type ('launch' or 'attach')
---@field program function|string Path to executable or function returning path
---@field cwd string Working directory
---@field stopOnEntry boolean Whether to stop at entry point
---@field args table Command line arguments
---@field runInTerminal boolean Whether to run in terminal

---@class DapAdapter
---@field type string Adapter type ('server', 'executable', etc.)
---@field port string Port configuration
---@field executable table Executable configuration with command and args

-- Go debugging adapter setup
-- Configures delve debugger for Go with platform-specific settings
---@return nil
local function setup_go_adapter()
  require('dap-go').setup {
    delve = {
      -- On Windows delve must be run attached or it crashes
      detached = vim.fn.has 'win32' == 0,
    },
  }
end

-- Python debugging adapter setup
-- Configures Python debugger using python3 interpreter
---@return nil
local function setup_python_adapter()
  require('dap-python').setup 'python3'
end

-- CodeLLDB adapter setup
-- Configures LLDB-based debugger for native languages (C, C++, Rust, Zig)
---@param dap table # DAP module instance
---@return nil
local function setup_codelldb_adapter(dap)
  ---@type DapAdapter
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.exepath 'codelldb',
      args = { '--port', '${port}' },
    },
  }
end

-- Build and find the newly-built Zig executable by running
-- 'zig build' and attempting to locate the resulting executable.
-- If the executable is unable to be automatically found, the user
-- will be prompted to give the path to the executable.
--
---@return string|nil # Path to executable or nil if build the failed
local function build_and_find_zig_executable()
  local build_result = vim.fn.system 'zig build'
  if vim.v.shell_error ~= 0 then
    vim.notify('Build failed: ' .. build_result, vim.log.levels.ERROR)
    return nil
  end

  local exe_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  local possible_paths = { 'zig-out/bin/' .. exe_name }

  for _, path in ipairs(possible_paths) do
    local full_path = vim.fn.getcwd() .. '/' .. path
    if vim.fn.executable(full_path) == 1 then
      return full_path
    end
  end

  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
end

-- Build and find the Zig test executable by running
-- 'zig build test' and prompting the user for the test
-- executable location.
--
---@return string # Path to test executable
local function build_and_find_zig_test()
  vim.fn.system 'zig build test'
  return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/zig-cache/o/', 'file')
end

-- Zig debugging configuration
-- Sets up debugging configurations for Zig programs and tests
---@param dap table # DAP module instance
---@return nil
local function setup_zig_configuration(dap)
  ---@type DapConfig[]
  dap.configurations.zig = {
    {
      name = 'Build and Launch Zig Program',
      type = 'codelldb',
      request = 'launch',
      program = build_and_find_zig_executable,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
    {
      name = 'Launch Zig Test',
      type = 'codelldb',
      request = 'launch',
      program = build_and_find_zig_test,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
end

-- Language adapters and configurations
-- Sets up debugging support for all supported languages
---@param dap table # DAP module instance
---@return nil
local function setup_language_adapters(dap)
  setup_go_adapter()
  setup_python_adapter()
  setup_codelldb_adapter(dap)
  setup_zig_configuration(dap)
end

-- Key mappings setup
-- Configures function keys and leader key combinations for debugging actions
---@param dap table # DAP module instance
---@param dapui table # DAP UI module instance
---@return nil
local function setup_keymaps(dap, dapui)
  ---@type table<string, {[1]: function, [2]: string}>
  local keymaps = {
    ['<F5>'] = { dap.continue, 'Debug: Start/Continue' },
    ['<F1>'] = { dap.step_into, 'Debug: Step Into' },
    ['<F2>'] = { dap.step_over, 'Debug: Step Over' },
    ['<F3>'] = { dap.step_out, 'Debug: Step Out' },
    ['<F7>'] = { dapui.toggle, 'Debug: See last session result' },
    ['<leader>tb'] = { dap.toggle_breakpoint, 'Debug: Toggle Breakpoint' },
    ['<leader>B'] = {
      function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      'Debug: Set Breakpoint',
    },
  }

  for key, config in pairs(keymaps) do
    vim.keymap.set('n', key, config[1], { desc = config[2] })
  end
end

-- Event listeners setup
-- Configures automatic UI opening/closing based on debug session events
---@param dap table # DAP module instance
---@param dapui table # DAP UI module instance
---@return nil
local function setup_dap_listeners(dap, dapui)
  local dapui_config = 'dapui_config'
  dap.listeners.after.event_initialized[dapui_config] = dapui.open
  dap.listeners.before.event_terminated[dapui_config] = dapui.close
  dap.listeners.before.event_exited[dapui_config] = dapui.close
end

-- DAP UI configuration
-- Sets up the debugging user interface with custom icons and controls
---@param dapui table # DAP UI module instance
---@return nil
local function setup_dapui_config(dapui)
  dapui.setup {
    icons = {
      expanded = '▾',
      collapsed = '▸',
      current_frame = '*',
    },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }
end

-- Mason DAP configuration
-- Automatically installs and configures debug adapters through Mason
---@return nil
local function setup_mason_dap()
  require('mason-nvim-dap').setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = { 'delve', 'python', 'codelldb' },
  }
end

-- Main configuration orchestrator
-- Sets up all debugging components in the correct order
---@return nil
local function setup_dap()
  local dap = require 'dap'
  local dapui = require 'dapui'

  setup_mason_dap()
  setup_dapui_config(dapui)
  setup_dap_listeners(dap, dapui)
  setup_language_adapters(dap)
  setup_keymaps(dap, dapui)
end

-- Plugin specification
-- Configures nvim-dap with all necessary dependencies for debugging
---@return table # Plugin specification for lazy.nvim
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Beautiful debugger UI
    'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui
    'williamboman/mason.nvim', -- Package manager for debug adapters
    'jay-babu/mason-nvim-dap.nvim', -- Mason integration for DAP
    'leoluz/nvim-dap-go', -- Go debugging support
    'mfussenegger/nvim-dap-python', -- Python debugging support
  },
  config = function()
    setup_dap()
  end,
}
