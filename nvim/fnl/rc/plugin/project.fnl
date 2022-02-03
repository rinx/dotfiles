(module rc.plugin.project
  {autoload {core aniseed.core
             nvim aniseed.nvim
             project project_nvim}
   require-macros [rc.macros]})

(project.setup
  {:ignore_lsp [:efm]
   :silent_chdir false})
