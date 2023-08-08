(local {: autoload} (require :nfnl.module))

(local bufferline (require :bufferline))

(local color (autoload :rc.color))
(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local colors color.colors)
(local icontab icon.tab)

(bufferline.setup
  {:highlights
   {:fill
    {:bg colors.color2}
    :background
    {:bg colors.color5}
    :tab
    {:bg colors.color5}
    :tab_selected
    {:bg colors.color9}
    :tab_close
    {:bg colors.color2}
    :buffer_selected
    {:bg colors.color9}
    :buffer_visible
    {:bg colors.color5}
    :close_button
    {:bg colors.color5}
    :close_button_visible
    {:bg colors.color5}
    :close_button_selected
    {:bg colors.color9}
    :diagnostic
    {:bg colors.color5}
    :diagnostic_visible
    {:bg colors.color5}
    :diagnostic_selected
    {:bg colors.color9}
    :info
    {:fg colors.info
     :bg colors.color5}
    :info_visible
    {:fg colors.info
     :bg colors.color5}
    :info_selected
    {:fg colors.info
     :bg colors.color9
     :bold true
     :italic true}
    :info_diagnostic
    {:fg colors.info
     :bg colors.color5}
    :info_diagnostic_visible
    {:fg colors.info
     :bg colors.color5}
    :info_diagnostic_selected
    {:fg colors.info
     :bg colors.color9
     :bold true
     :italic true}
    :warning
    {:fg colors.warn
     :bg colors.color5}
    :warning_visible
    {:fg colors.warn
     :bg colors.color5}
    :warning_selected
    {:fg colors.warn
     :bg colors.color9
     :bold true
     :italic true}
    :warning_diagnostic
    {:fg colors.warn
     :bg colors.color5}
    :warning_diagnostic_visible
    {:fg colors.warn
     :bg colors.color5}
    :warning_diagnostic_selected
    {:fg colors.warn
     :bg colors.color9
     :bold true
     :italic true}
    :error
    {:fg colors.error
     :bg colors.color5}
    :error_visible
    {:fg colors.error
     :bg colors.color5}
    :error_selected
    {:fg colors.error
     :bg colors.color9
     :bold true
     :italic true}
    :error_diagnostic
    {:fg colors.error
     :bg colors.color5}
    :error_diagnostic_visible
    {:fg colors.error
     :bg colors.color5}
    :error_diagnostic_selected
    {:fg colors.error
     :bg colors.color9
     :bold true
     :italic true}
    :duplicate
    {:bg colors.color5}
    :duplicate_selected
    {:bg colors.color9}
    :duplicate_visible
    {:bg colors.color5}
    :modified
    {:bg colors.color5}
    :modified_selected
    {:bg colors.color9}
    :modified_visible
    {:bg colors.color5}
    :separator
    {:fg colors.color5
     :bg colors.color5}
    :separator_selected
    {:fg colors.color9
     :bg colors.color9}
    :separator_visible
    {:fg colors.color5
     :bg colors.color5}
    :indicator_selected
    {:fg colors.hint
     :bg colors.color9}
    :pick
    {:bg colors.color5
     :fg colors.warn}
    :pick_selected
    {:bg colors.color9
     :fg colors.error}
    :pick_visible
    {:bg colors.color5
     :fg colors.error}}
   :options {:numbers :none
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

(map! [:n] ",bc" ":tabe<CR>" {:silent true})
(map! [:n] ",bb" ":<C-u>BufferLinePick<CR>" {:silent true})
(map! [:n] ",bo" ":<C-u>BufferLineSortByDirectory<CR>" {:silent true})
(map! [:n] ",be" ":<C-u>BufferLineSortByExtension<CR>" {:silent true})
(map! [:n] ",bn" ":<C-u>BufferLineCycleNext<CR>" {:silent true})
(map! [:n] ",bp" ":<C-u>BufferLineCyclePrev<CR>" {:silent true})
(map! [:n] ",bN" ":<C-u>BufferLineMoveNext<CR>" {:silent true})
(map! [:n] ",bP" ":<C-u>BufferLineMovePrev<CR>" {:silent true})

(fn buffer-close [opts]
  (let [bn (vim.fn.bufnr :%)
        abn (vim.fn.bufnr :#)]
    (if (not (= abn -1))
      (vim.cmd "silent bnext")
      (vim.cmd "silent enew"))
    (vim.cmd (.. "silent bdelete " bn))))
(vim.api.nvim_create_user_command :BufferClose buffer-close {})
(map! [:n] ",bd" ":<C-u>BufferClose<CR>" {:silent true})
