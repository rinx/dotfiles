(module dotfiles.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             icon dotfiles.icon
             util dotfiles.util}})

(def- icontab icon.tab)
(def- nnoremap-silent util.nnoremap-silent)

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

(nnoremap-silent :<leader>t ":<C-u>NvimTreeToggle<CR>")

