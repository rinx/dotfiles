(local sidebar (require :sidebar-nvim))

(import-macros {: map!} :rc.macros)

(sidebar.setup
  {:open false
   :side :right
   :sections
   [:git
    :todos
    :buffers
    :symbols]
   :disable_closing_prompt true})

(map! [:n] :<leader>o ":<C-u>SidebarNvimToggle<CR>" {:silent true})
