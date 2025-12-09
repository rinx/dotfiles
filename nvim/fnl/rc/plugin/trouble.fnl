(local {: autoload} (require :nfnl.module))

(local trouble (require :trouble))

(import-macros {: augroup! : map!} :rc.macros)

(trouble.setup
  {:auto_close true})

(augroup!
  init-trouble-qf-open
  {:events [:QuickFixCmdPost]
   :callback (fn []
               (vim.cmd "Trouble qflist open"))})

(map! [:n]
      "<leader>xx"
      ":<C-u>Trouble diagnostics toggle<CR>"
      {:silent true
       :desc "Trouble: toggle diagnostics"})
(map! [:n]
      "<leader>xX"
      ":<C-u>Trouble diagnostics toggle filter.buf=0<CR>"
      {:silent true
       :desc "Trouble: toggle diagnostics for current buffer"})
(map! [:n]
      "<leader>xd"
      ":<C-u>Trouble lsp toggle focus=false win.position=right<CR>"
      {:silent true
       :desc "Trouble: toggle lsp sidebar"})
(map! [:n]
      "<leader>xq"
      ":<C-u>Trouble qflist toggle<CR>"
      {:silent true
       :desc "Trouble: toggle quickfix"})
(map! [:n]
      "<leader>xl"
      ":<C-u>Trouble loclist toggle<CR>"
      {:silent true
       :desc "Trouble: toggle loclist"})
(map! [:n]
      "<leader>xt"
      ":<C-u>Trouble todo toggle<CR>"
      {:silent true
       :desc "Trouble: toggle todo"})
