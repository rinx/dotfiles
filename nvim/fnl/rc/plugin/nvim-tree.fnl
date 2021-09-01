(module rc.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             icon rc.icon}
   require-macros [rc.macros]})

(def- icontab icon.tab)

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

(noremap! [:n] :<leader>t ":<C-u>NvimTreeToggle<CR>" :silent)
