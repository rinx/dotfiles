(local {: autoload} (require :nfnl.module))

(local dap-go (require :dap-go))

(import-macros {: map!} :rc.macros)

(dap-go.setup {})

(vim.api.nvim_create_user_command
  :DapGoTest "lua require('dap-go').debug_test()" {})

(vim.api.nvim_create_user_command
  :DapGoLastTest "lua require('dap-go').debug_last_test()" {})

(map! [:n] "<F6>" ":<C-u>DapGoTest<CR>" {:silent true})
(map! [:n] "<F7>" ":<C-u>DapGoLastTest<CR>" {:silent true})
