(local project (require :project_nvim))

(project.setup
  {:ignore_lsp
   [:ast_grep
    :efm
    :herper_ls]
   :silent_chdir false
   :patterns
   [".git"
    "_darcs"
    ".hg"
    ".bzr"
    ".svn"
    "Makefile"
    "package.json"
    ".nfnl.fnl"]})
