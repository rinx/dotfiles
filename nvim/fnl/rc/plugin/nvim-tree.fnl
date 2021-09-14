(module rc.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             icon rc.icon
             config nvim-tree.config}
   require-macros [rc.macros]})

(def- icontab icon.tab)
(def- cb config.nvim_tree_callback)

;; nvim-tree.lua
(set nvim.g.nvim_tree_side :left)
(set nvim.g.nvim_tree_width 30)
(set nvim.g.nvim_tree_auto_close 1)
(set nvim.g.nvim_tree_follow 1)
(set nvim.g.nvim_tree_indent_markers 1)
(set nvim.g.nvim_tree_icons {:default icontab.text
                             :symlink icontab.symlink
                             :git {:unstaged icontab.diff-modified
                                   :staged icontab.check
                                   :unmerged icontab.merge
                                   :renamed icontab.diff-renamed
                                   :untracked icontab.asterisk}
                             :folder {:default icontab.folder
                                      :open icontab.folder-open}})

(set nvim.g.nvim_tree_disable_default_keybindings 1)
(set nvim.g.nvim_tree_bindings
     [{:key [:<CR> :o :<2-LeftMouse>] :cb (cb :edit)}
      {:key [:<2-RightMouse> "<C-]>"] :cb (cb :cd)}
      {:key :<C-v> :cb (cb :vsplit)}
      {:key :<C-x> :cb (cb :split)}
      {:key :<C-t> :cb (cb :tabnew)}
      {:key "<" :cb (cb :prev_sibling)}
      {:key ">" :cb (cb :next_sibling)}
      {:key :P :cb (cb :parent_node)}
      {:key :<BS> :cb (cb :close_node)}
      {:key :<S-CR> :cb (cb :close_node)}
      {:key :<Tab> :cb (cb :preview)}
      {:key :K :cb (cb :first_sibling)}
      {:key :J :cb (cb :last_sibling)}
      {:key :I :cb (cb :toggle_ignored)}
      {:key :H :cb (cb :toggle_dotfiles)}
      {:key :R :cb (cb :refresh)}
      {:key :a :cb (cb :create)}
      {:key :d :cb (cb :remove)}
      {:key :r :cb (cb :rename)}
      {:key :<C-r> :cb (cb :full_rename)}
      {:key :x :cb (cb :cut)}
      {:key :c :cb (cb :copy)}
      {:key :p :cb (cb :paste)}
      {:key :y :cb (cb :copy_name)}
      {:key :Y :cb (cb :copy_path)}
      {:key :gy :cb (cb :copy_absolute_path)}
      {:key "[c" :cb (cb :prev_git_item)}
      {:key "]c" :cb (cb :next_git_item)}
      {:key :- :cb (cb :dir_up)}
      {:key :q :cb (cb :close)}
      {:key :g? :cb (cb :toggle_help)}])

(noremap! [:n] :<leader>t ":<C-u>NvimTreeToggle<CR>" :silent)
