(local {: autoload} (require :nfnl.module))

(local dap (require :dap))
(local dap-ext-vscode (require :dap.ext.vscode))
(local dapui (require :dapui))

(local color (autoload :rc.color))
(local icon (autoload :rc.icon))
(import-macros {: map! : hi!} :rc.macros)

(local colors color.colors)
(local icontab icon.tab)

(local adapters-dir (.. (vim.fn.stdpath :data) :/dap))
(when (not (= (vim.fn.isdirectory adapters-dir) 1))
  (vim.fn.mkdir adapters-dir :p))

;; go
(when (= (vim.fn.executable :dlv) 1)
  (let [dlv-path (vim.fn.exepath :dlv)
        vscode-go-path (.. adapters-dir :/vscode-go)
        debug-adapter-path (.. vscode-go-path :/dist/debugAdapter.js)]

    (fn dap-sync-go-adapter []
      (if (vim.fn.empty (vim.fn.glob vscode-go-path))
        (do
          (vim.cmd
            (string.format
              (.. "!git clone --depth 1 "
                  "http://github.com/golang/vscode-go %s; "
                  "cd %s; "
                  "npm install; "
                  "npm run compile")
              vscode-go-path
              vscode-go-path))
          (vim.notify
            "finished to install Go adapter."
            vim.lsp.log_levels.INFO
            {:title :dap-sync-go-adapter}))
        (do
          (vim.cmd
            (string.format
              (.. "!cd %s; "
                  "git pull origin master; "
                  "npm install; "
                  "npm run compile")
              vscode-go-path))
          (vim.notify
            "finished to update Go adapter."
            vim.lsp.log_levels.WARN
            {:title :dap-sync-go-adapter}))))
    (vim.api.nvim_create_user_command :DapSyncGoAdapter dap-sync-go-adapter {})

    (set dap.adapters.go
         {:name :dlv
          :type :executable
          :command :node
          :args [debug-adapter-path]})
    (set dap.configurations.go
         [{:type :go
           :name "Launch file"
           :request :launch
           :showLog true
           :program "${file}"
           :dlvToolPath dlv-path}
          {:type :go
           :name "Launch test file"
           :request :launch
           :mode :test
           :showLog true
           :program "${file}"
           :args ["-test.v"]
           :dlvToolPath dlv-path}])))

;; lldb
(let [adapter-path (.. adapters-dir :/codelldb)
      codelldb-path (.. adapter-path :/extension/adapter/codelldb)
      codelldb-url (if (= (vim.fn.has :unix) 1)
                     "https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-linux.vsix"
                     "https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-darwin.vsix")]
  (fn dap-sync-lldb-adapter []
    (if (vim.fn.empty (vim.fn.glob adapter-path))
      (do
        (vim.cmd
          (string.format
            (.. "!curl -L %s --output /tmp/codelldb.zip; "
                "unzip /tmp/codelldb.zip -d %s; "
                "rm -rf /tmp/codelldb.zip")
            codelldb-url
            adapter-path))
        (vim.notify
          "finished to install codelldb."
          vim.lsp.log_levels.INFO
          {:title :dap-sync-lldb-adapter}))
      (do
        (vim.notify
          "codelldb already installed."
          vim.lsp.log_levels.WARN
          {:title :dap-sync-lldb-adapter}))))
  (vim.api.nvim_create_user_command :DapSyncLLDBAdapter dap-sync-lldb-adapter {})
  (set dap.adapters.rust
       (fn [callback config]
         (let [port (math.random 30000 40000)
               (handle pid-or-err)
               (vim.loop.spawn
                 codelldb-path
                 {:args ["--port" (string.format "%d" port)]
                  :detached true}
                 (fn [code]
                   (handle:close)
                   (vim.notify
                     (.. "codelldb exited with code: " code)
                     vim.lsp.log_levels.ERROR
                     {:title :dap-adapters-rust})))]
           (vim.defer_fn
             (fn []
               (callback {:type :server
                          :host "127.0.0.1"
                          :port port}))
             500))))
  (set dap.configurations.rust
       (let [cwd (vim.fn.getcwd)
             pkg-name (vim.fn.fnamemodify (vim.fn.getcwd) ":t")]
         [{:type :rust
           :name "Debug executable"
           :request :launch
           :args []
           :cwd cwd
           :program (.. :target/debug/ pkg-name)}])))

;; kotlin
(let [adapter-path (.. adapters-dir :/kotlin)
      bin-path (.. adapter-path
                   :/adapter/build/install/adapter/bin/kotlin-debug-adapter)]
  (fn dap-sync-kotlin-adapter []
    (if (vim.fn.empty (vim.fn.glob adapter-path))
      (do
        (vim.cmd
          (string.format
            (.. "!git clone --depth 1 "
                "https://github.com/fwcd/kotlin-debug-adapter %s; "
                "cd %s; "
                "./gradlew :adapter:installDist")
            adapter-path
            adapter-path))
        (vim.notify
          "finished to install kotlin-debug-adapter"
          vim.lsp.log_levels.INFO
          {:title :dap-sync-kotlin-adapter}))
      (do
        (vim.notify
          "kotlin-debug-adapter already installed."
          vim.lsp.log_levels.WARN
          {:title :dap-sync-kotlin-adapter}))))
  (vim.api.nvim_create_user_command :DapSyncKotlinAdapter dap-sync-kotlin-adapter {})
  (set dap.adapters.kotlin
       {:name :kotlin-debug-adapter
        :type :executable
        :command bin-path}))

;; loading .vscode/launch.json
(fn load-launch-js []
  (let [cwd (vim.fn.getcwd)
        path (.. cwd :/.vscode/launch.json)]
    (when (vim.loop.fs_stat path)
      (vim.notify
        "loading .vscode/launch.json..."
        vim.lsp.log_levels.INFO
        {:title :dap-load-launch-js})
      (pcall dap-ext-vscode.load_launchjs)
      (vim.notify
        "finished to load .vscode/launch.json."
        vim.lsp.log_levels.INFO
        {:title :dap-load-launch-js}))))
(vim.api.nvim_create_user_command :DapLoadLaunchJSON load-launch-js {})

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
