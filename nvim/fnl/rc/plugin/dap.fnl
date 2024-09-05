(local {: autoload} (require :nfnl.module))

(local dap (require :dap))
(local dapui (require :dapui))

(local color (autoload :rc.color))
(local icon (autoload :rc.icon))
(import-macros {: map! : hi!} :rc.macros)

(local colors color.colors)
(local icontab icon.tab)

;; rego
(set dap.adapters.rego
     {:name :regal-debug
      :type :executable
      :command :regal
      :args [:debug]})
(set dap.configurations.rego
     [{:type :rego
       :name "Debug Workspace"
       :request :launch
       :command :eval
       :query :data
       :dataPaths ["${file}"]
       :enablePrint true
       :logLevel :info}
      {:type :rego
       :name "Launch Rego Workspace"
       :request :launch
       :command :eval
       :query :data
       :enablePrint true
       :logLevel :info
       :inputPath "${workspaceFolder}/input.json"
       :dataPaths ["${file}"]}])

(dapui.setup {:icons
              {:expanded icontab.fold-open
               :collapsed icontab.fold-closed}})

(hi! :DapBreakpoint {:ctermfg :red :guifg colors.error})
(hi! :DapLogPoint {:ctermfg :yellow :guifg colors.warn})
(hi! :DapStopped {:ctermfg :blue :guifg colors.hint})

(vim.fn.sign_define :DapBreakpoint
                     {:text icontab.circle
                      :texthl :DapBreakpoint})
(vim.fn.sign_define :DapLogPoint
                     {:text icontab.comment
                      :texthl :DapLogPoint})
(vim.fn.sign_define :DapStopped
                     {:text icontab.arrow-r
                      :texthl :DapStopped})
(vim.fn.sign_define :DapBreakpointRejected
                     {:text icontab.times
                      :texthl :DapBreakpoint})

(vim.api.nvim_create_user_command
  :DapToggleBreakpoint "lua require('dap').toggle_breakpoint()" {})
(vim.api.nvim_create_user_command
  :DapListBreakpoints "lua require('dap').list_breakpoints()" {})
(vim.api.nvim_create_user_command
  :DapContinue "lua require('dap').continue()" {})
(vim.api.nvim_create_user_command
  :DapStepOver "lua require('dap').step_over()" {})
(vim.api.nvim_create_user_command
  :DapStepInto "lua require('dap').step_into()" {})
(vim.api.nvim_create_user_command
  :DapStepOut "lua require('dap').step_out()" {})
(vim.api.nvim_create_user_command
  :DapUIOpen "lua require('dapui').open()" {})
(vim.api.nvim_create_user_command
  :DapUIClose "lua require('dapui').close()" {})
(vim.api.nvim_create_user_command
  :DapUIToggle "lua require('dapui').toggle()" {})

(map! [:n] "<F5>" ":<C-u>DapContinue<CR>" {:silent true})
(map! [:n] "<F9>" ":<C-u>DapToggleBreakpoint<CR>" {:silent true})
(map! [:n] "<F10>" ":<C-u>DapStepOver<CR>" {:silent true})
(map! [:n] "<F11>" ":<C-u>DapStepInto<CR>" {:silent true})
(map! [:n] "<F12>" ":<C-u>DapStepOut<CR>" {:silent true})
