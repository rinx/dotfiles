(module rc.plugin.dap
  {autoload {nvim aniseed.nvim
             color rc.color
             icon rc.icon
             util rc.util
             dap dap
             dap-ext-vscode dap.ext.vscode
             dapui dapui}
   require-macros [rc.macros]})

(def- colors color.colors)
(def- icontab icon.tab)
(def- hi util.hi)
(def- nnoremap-silent util.nnoremap-silent)

(def- adapters-dir (.. (vim.fn.stdpath :data) :/dap))
(when (not (= (nvim.fn.isdirectory adapters-dir) 1))
  (nvim.fn.mkdir adapters-dir :p))

;; go
(when (= (nvim.fn.executable :dlv) 1)
  (let [dlv-path (vim.fn.exepath :dlv)
        vscode-go-path (.. adapters-dir :/vscode-go)
        debug-adapter-path (.. vscode-go-path :/dist/debugAdapter.js)]

    (defn dap-sync-go-adapter []
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
          (print "finished to install Go adapter."))
        (do
          (vim.cmd
            (string.format
              (.. "!cd %s; "
                  "git pull origin master; "
                  "npm install; "
                  "npm run compile")
              vscode-go-path))
          (print "finished to update Go adapter."))))
    (nvim.ex.command_ :DapSyncGoAdapter (->viml :dap-sync-go-adapter))

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
  (defn dap-sync-lldb-adapter []
    (if (vim.fn.empty (vim.fn.glob adapter-path))
      (do
        (vim.cmd
          (string.format
            (.. "!curl -L %s --output /tmp/codelldb.zip; "
                "unzip /tmp/codelldb.zip -d %s; "
                "rm -rf /tmp/codelldb.zip")
            codelldb-url
            adapter-path))
        (print "finished to install codelldb."))
      (do
        (print "codelldb already installed."))))
  (nvim.ex.command_ :DapSyncLLDBAdapter (->viml :dap-sync-lldb-adapter))
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
                   (print "codelldb exited with code: " code)))]
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
  (defn dap-sync-kotlin-adapter []
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
        (print "finished to install kotlin-debug-adapter"))
      (do
        (print "kotlin-debug-adapter already installed."))))
  (nvim.ex.command_ :DapSyncKotlinAdapter (->viml :dap-sync-kotlin-adapter))
  (set dap.adapters.kotlin
       {:name :kotlin-debug-adapter
        :type :executable
        :command bin-path}))

;; loading .vscode/launch.js
(pcall dap-ext-vscode.load_launchjs)

(dapui.setup {:icons
              {:expanded icontab.fold-open
               :collapsed icontab.fold-closed}})

(hi :DapBreakpoint {:others (.. "ctermfg=red guifg=" colors.error)})
(hi :DapLogPoint {:others (.. "ctermfg=yellow guifg=" colors.warn)})
(hi :DapStopped {:others (.. "ctermfg=blue guifg=" colors.hint)})

(nvim.fn.sign_define :DapBreakpoint
                     {:text icontab.circle
                      :texthl :DapBreakpoint})
(nvim.fn.sign_define :DapLogPoint
                     {:text icontab.comment
                      :texthl :DapLogPoint})
(nvim.fn.sign_define :DapStopped
                     {:text icontab.arrow-r
                      :texthl :DapStopped})

(nvim.ex.command_ :DapToggleBreakpoint "lua require('dap').toggle_breakpoint()")
(nvim.ex.command_ :DapListBreakpoints "lua require('dap').list_breakpoints()")
(nvim.ex.command_ :DapContinue "lua require('dap').continue()")
(nvim.ex.command_ :DapStepOver "lua require('dap').step_over()")
(nvim.ex.command_ :DapStepInto "lua require('dap').step_into()")
(nvim.ex.command_ :DapStepOut "lua require('dap').step_out()")
(nvim.ex.command_ :DapUIOpen "lua require('dapui').open()")
(nvim.ex.command_ :DapUIClose "lua require('dapui').close()")
(nvim.ex.command_ :DapUIToggle "lua require('dapui').toggle()")

(nnoremap-silent "<F5>" ":<C-u>DapContinue<CR>")
(nnoremap-silent "<F9>" ":<C-u>DapToggleBreakpoint<CR>")
(nnoremap-silent "<F10>" ":<C-u>DapStepOver<CR>")
(nnoremap-silent "<F11>" ":<C-u>DapStepInto<CR>")
(nnoremap-silent "<F12>" ":<C-u>DapStepOut<CR>")
