(local {: autoload} (require :nfnl.module))

(local tree (require :nvim-tree))

(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local icontab icon.tab)

;; nvim-tree.lua
(local icons
  {:glyphs
   {:default icontab.text
    :symlink icontab.symlink
    :git {:unstaged icontab.diff-modified
          :staged icontab.check
          :unmerged icontab.merge
          :renamed icontab.diff-renamed
          :untracked icontab.asterisk}
    :folder {:default icontab.folder
             :open icontab.folder-open}}})

(fn on-attach [bufnr]
  (let [api (require :nvim-tree.api)
        opts (fn [desc]
               {:desc (.. "nvim-tree: " desc)
                :buffer bufnr
                :noremap true
                :silent true
                :nowait true})]
    (map! [:n] :<CR> api.node.open.edit (opts "Open"))
    (map! [:n] "<C-]>" api.tree.change_root_to_node (opts "CD"))
    (map! [:n] :<C-v> api.node.open.vertical (opts "Open: Vertical"))
    (map! [:n] :<C-x> api.node.open.horizontal (opts "Open: Horizontal"))
    (map! [:n] "<" api.node.navigate.sibling.prev (opts "Previous Sibling"))
    (map! [:n] ">" api.node.navigate.sibling.next (opts "Next Sibling"))
    (map! [:n] :P api.node.navigate.parent (opts "Parent Directory"))
    (map! [:n] :<BS> api.node.navigate.parent_close (opts "Close Directory"))
    (map! [:n] :<S-CR> api.node.navigate.parent_close (opts "Close Directory"))
    (map! [:n] :<Tab> api.node.open.preview (opts "Open Preview"))
    (map! [:n] :gg api.node.navigate.sibling.first (opts "First Sibling"))
    (map! [:n] :G api.node.navigate.sibling.last (opts "Last Sibling"))
    (map! [:n] :I api.tree.toggle_gitignore_filter (opts "Toggle Git Ignore"))
    (map! [:n] :H api.tree.toggle_hidden_filter (opts "Toggle Dotfiles"))
    (map! [:n] :R api.tree.reload (opts "Refresh"))
    (map! [:n] :a api.fs.create (opts "Create"))
    (map! [:n] :d api.fs.remove (opts "Delete"))
    (map! [:n] :r api.fs.rename (opts "Rename"))
    (map! [:n] :<C-r> api.fs.rename_sub (opts "Rename: Omit Filename"))
    (map! [:n] :x api.fs.cut (opts "Cut"))
    (map! [:n] :c api.fs.copy.node (opts "Copy"))
    (map! [:n] :p api.fs.paste (opts "Paste"))
    (map! [:n] :y api.fs.copy.filename (opts "Copy Name"))
    (map! [:n] :Y api.fs.copy.relative_path (opts "Copy Relative Path"))
    (map! [:n] :gy api.fs.copy.absolute_path (opts "Copy Absolute Path"))
    (map! [:n] :- api.tree.change_root_to_parent (opts "Up"))
    (map! [:n] :q api.tree.close (opts "Close"))
    (map! [:n] :? api.tree.toggle_help (opts "Help"))))

(map! [:n] :<leader>t ":<C-u>NvimTreeToggle<CR>" {:silent true})

(tree.setup
  {:disable_netrw true
   :hijack_netrw true
   :update_cwd true
   :update_focused_file {:enable true
                         :update_cwd true}
   :renderer {:icons icons}
   :respect_buf_cwd true
   :view {:width 30
          :side :left}
   :on_attach on-attach})
