(module rc.plugin.sidebar
  {autoload {nvim aniseed.nvim
             sidebar sidebar-nvim}
   require-macros [rc.macros]})

(sidebar.setup
  {:open false
   :side :right
   :sections [:git
              :todos
              :buffers
              :symbols]
   :disable_closing_prompt true})

(noremap! [:n] :<leader>o ":<C-u>SidebarNvimToggle<CR>" :silent)
