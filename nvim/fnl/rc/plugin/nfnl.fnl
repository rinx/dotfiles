(fn compile-all-files []
  (let [nfnl (require :nfnl.api)]
    (nfnl.compile-all-files)))

(vim.api.nvim_create_user_command :NfnlCompileAllFiles compile-all-files {})
