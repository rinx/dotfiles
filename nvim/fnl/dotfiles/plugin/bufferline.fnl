(module dotfiles.plugin.bufferline
  {autoload {nvim aniseed.nvim
             color dotfiles.color
             icon dotfiles.icon
             util dotfiles.util
             bufferline bufferline}
   require-macros [dotfiles.util.macros]})

(def- colors color.colors)
(def- icontab icon.tab)
(def- nnoremap-silent util.nnoremap-silent)

(bufferline.setup
  {:highlights {:fill
                {:guibg colors.color2}
                :background
                {:guibg colors.color5}
                :tab
                {:guibg colors.color5}
                :tab_selected
                {:guibg colors.color9}
                :tab_close
                {:guibg colors.color2}
                :buffer_selected
                {:guibg colors.color9}
                :buffer_visible
                {:guibg colors.color5}
                :close_button
                {:guibg colors.color5}
                :close_button_visible
                {:guibg colors.color5}
                :close_button_selected
                {:guibg colors.color9}
                :diagnostic
                {:guibg colors.color5}
                :diagnostic_visible
                {:guibg colors.color5}
                :diagnostic_selected
                {:guibg colors.color9}
                :info
                {:guifg colors.info
                 :guibg colors.color5}
                :info_visible
                {:guifg colors.info
                 :guibg colors.color5}
                :info_selected
                {:guifg colors.info
                 :guibg colors.color9
                 :gui :bolditalic}
                :info_diagnostic
                {:guifg colors.info
                 :guibg colors.color5}
                :info_diagnostic_visible
                {:guifg colors.info
                 :guibg colors.color5}
                :info_diagnostic_selected
                {:guifg colors.info
                 :guibg colors.color9
                 :gui :bolditalic}
                :warning
                {:guifg colors.warn
                 :guibg colors.color5}
                :warning_visible
                {:guifg colors.warn
                 :guibg colors.color5}
                :warning_selected
                {:guifg colors.warn
                 :gui :bolditalic
                 :guibg colors.color9}
                :warning_diagnostic
                {:guifg colors.warn
                 :guibg colors.color5}
                :warning_diagnostic_visible
                {:guifg colors.warn
                 :guibg colors.color5}
                :warning_diagnostic_selected
                {:guifg colors.warn
                 :gui :bolditalic
                 :guibg colors.color9}
                :error
                {:guifg colors.error
                 :guibg colors.color5}
                :error_visible
                {:guifg colors.error
                 :guibg colors.color5}
                :error_selected
                {:guifg colors.error
                 :gui :bolditalic
                 :guibg colors.color9}
                :error_diagnostic
                {:guifg colors.error
                 :guibg colors.color5}
                :error_diagnostic_visible
                {:guifg colors.error
                 :guibg colors.color5}
                :error_diagnostic_selected
                {:guifg colors.error
                 :gui :bolditalic
                 :guibg colors.color9}
                :duplicate
                {:guibg colors.color5}
                :duplicate_selected
                {:guibg colors.color9}
                :duplicate_visible
                {:guibg colors.color5}
                :modified
                {:guibg colors.color5}
                :modified_selected
                {:guibg colors.color9}
                :modified_visible
                {:guibg colors.color5}
                :separator
                {:guifg colors.color5
                 :guibg colors.color5}
:separator_selected
{:guifg colors.color9
 :guibg colors.color9}
:separator_visible
{:guifg colors.color5
 :guibg colors.color5}
:indicator_selected
{:guifg colors.hint
 :guibg colors.color9}
:pick
{:guibg colors.color5
 :guifg colors.warn}
:pick_selected
{:guibg colors.color9
 :guifg colors.error}
:pick_visible
{:guibg colors.color5
 :guifg colors.error}}
:options {:numbers :none
          :mappings false
          :max_name_length 18
          :max_prefix_length 15
          :tab_size 18
          :diagnostics :nvim_lsp
          :diagnostics_indicator
          (fn [count level dict ctx]
            (if (ctx.buffer:current)
              ""
              (.. " " icontab.exclam-circle count)))
          :show_tab_indicators false
          :separator_style :thin
          :always_show_bufferline true
          :sort_by :extension}})

(nnoremap-silent ",bc" ":tabe<CR>")
(nnoremap-silent ",bb" ":<C-u>BufferLinePick<CR>")
(nnoremap-silent ",bo" ":<C-u>BufferLineSortByDirectory<CR>")
(nnoremap-silent ",be" ":<C-u>BufferLineSortByExtension<CR>")
(nnoremap-silent ",bn" ":<C-u>BufferLineCycleNext<CR>")
(nnoremap-silent ",bp" ":<C-u>BufferLineCyclePrev<CR>")
(nnoremap-silent ",bN" ":<C-u>BufferLineMoveNext<CR>")
(nnoremap-silent ",bP" ":<C-u>BufferLineMovePrev<CR>")
(nnoremap-silent :gt  ":<C-u>BufferLineCycleNext<CR>")
(nnoremap-silent :gT  ":<C-u>BufferLineCyclePrev<CR>")

(defn buffer-close []
  (let [bn (nvim.fn.bufnr :%)
        abn (nvim.fn.bufnr :#)]
    (if (not (= abn -1))
      (nvim.ex.silent_ :bnext)
      (nvim.ex.silent_ :enew))
    (nvim.ex.silent_ (.. "bdelete " bn))))
(nvim.ex.command_ :BufferClose (->viml :buffer-close))
(nnoremap-silent ",bd" ":<C-u>BufferClose<CR>")
