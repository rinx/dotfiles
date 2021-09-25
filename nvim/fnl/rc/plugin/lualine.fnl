(module rc.plugin.lualine
  {autoload {core aniseed.core
             nvim aniseed.nvim
             icon rc.icon
             util rc.util
             lualine lualine}})

(def- icontab icon.tab)
(def- loaded? util.loaded?)

(def- filename
  {1 :filename
   :file_status true
   :symbols
   {:modified (.. " " icontab.plus)
    :readonly (.. " " icontab.lock)}})

(def- mode
  {1 :mode
   :fmt (fn [mode-name]
          (let [i icontab
                dict {:n i.hashtag
                      :i i.text
                      :v i.cursor-text
                      "" i.cursor
                      :V i.cursor
                      :c i.chevron-r
                      :no i.hashtag
                      :s i.cursor-text
                      :S i.cursor-text
                      "" i.cursor-text
                      :ic i.lightning
                      :R i.arrow-r
                      :Rv i.arrow-r
                      :cv i.hashtag
                      :ce i.hashtag
                      :r i.chevron-r
                      :rm i.chevron-r
                      "r?" i.chevron-r
                      "!" i.chevron-r
                      :t i.chevron-r}]
            (or (. dict (vim.fn.mode))
                mode-name)))})

(defn- paste []
  (if vim.o.paste
    icontab.paste
    ""))

(defn- spell []
  (if vim.wo.spell
    (.. icontab.spellcheck vim.o.spelllang)
    ""))

(defn- lsp-status []
  (match (when (loaded? :lsp-status.nvim)
           (let [lsp-status (require :lsp-status)]
             (lsp-status.status)))
    status status
    _ ""))

(defn- dap-status []
  (match (when (loaded? :nvim-dap)
           (let [dap (require :dap)]
             (dap.status)))
    "" " "
    status (.. icontab.play-circle" " status)
    _ ""))

(defn- lineinfo []
  (let [row (nvim.fn.line ".")
        col (nvim.fn.col ".")]
    (.. icontab.ln row " " icontab.cn col)))

(lualine.setup
  {:options
   {:theme :ayu_dark
    :section_separators {:left icontab.round-l
                         :right icontab.round-r}
    :component_separators {:left "|"
                           :right "|"}
    :icons_enabled true}
   :sections
   {:lualine_a [mode
                paste
                spell]
    :lualine_b [filename
                {1 :branch
                 :icon icontab.github}
                {1 :diff
                 :colored true
                 :symbols
                 {:added icontab.diff-add
                  :modified icontab.diff-modified
                  :removed icontab.diff-removed}}
                lsp-status]
    :lualine_c []
    :lualine_x [dap-status]
    :lualine_y [:fileformat
                :encoding
                :filetype]
    :lualine_z [lineinfo]}
   :inactive_sections
   {:lualine_a []
    :lualine_b []
    :lualine_c [filename]
    :lualine_x [:filetype]
    :lualine_y []
    :lualine_z []}
   :extensions
   [:quickfix
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.alarm-light " Trouble"))]
                :lualine_b
                [(fn [] 
                   (let [tc (require :trouble.config)
                         mode tc.options.mode]
                     (match mode
                       :quickfix
                       (let [title (core.get
                                     (vim.fn.getqflist {:title 1})
                                     :title)]
                         (if (> (string.len title) 0)
                           (.. mode " | " title)
                           mode))
                       :loclist
                       (let [title (core.get
                                     (vim.fn.getloclist
                                       (vim.fn.winnr)
                                       {:title 1})
                                     :title)]
                         (if (> (string.len title) 0)
                           (.. mode " | " title)
                           mode))
                       _ mode)))]}
     :filetypes [:Trouble]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.chevron-r " REPL"))]}
     :filetypes [:dap-repl]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.glasses " Watches"))]}
     :filetypes [:dapui_watches]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.stackoverflow " Stacks"))]}
     :filetypes [:dapui_stacks]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.tags " Breakpoints"))]}
     :filetypes [:dapui_breakpoints]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.scope " Scopes"))]}
     :filetypes [:dapui_scopes]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.terminal-alt
                       " Term "
                       nvim.b.toggle_number))]}
     :filetypes [:toggleterm]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.package-alt " Packer"))]}
     :filetypes [:packer]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.tree " NvimTree"))]}
     :filetypes [:NvimTree]}
    {:sections {:lualine_a
                [(fn []
                   (.. icontab.hierarchy " Outline"))]}
     :filetypes [:Outline]}]})
