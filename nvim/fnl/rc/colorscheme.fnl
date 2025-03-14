(local {: autoload} (require :nfnl.module))

(local nightfox (require :nightfox))

(local color (autoload :rc.color))
(import-macros {: hi!} :rc.macros)

(local colors color.colors)

(nightfox.setup
  {:options
   {:compile_path (vim.fn.expand
                    "~/.config/nvim/tmp/cache/nightfox")
    :compile_file_suffix :_compiled
    :transparent true
    :terminal_colors true
    :dim_inactive false
    :styles
    {:comments :italic
     :keywords "bold,italic"
     :functions :bold
     :types :italic}}})

(vim.cmd "silent colorscheme duskfox")
(vim.cmd "syntax enable")

(hi! :DiagnosticUnderlineError
     {:cterm :undercurl
      :gui :undercurl
      :guisp colors.error})
(hi! :DiagnosticUnderlineWarn
     {:cterm :undercurl
      :gui :undercurl
      :guisp colors.warn})
(hi! :DiagnosticUnderlineInfo
     {:cterm :undercurl
      :gui :undercurl
      :guisp colors.info})
(hi! :DiagnosticUnderlineHint
     {:cterm :undercurl
      :gui :undercurl
      :guisp colors.hint})
(hi! :DiagnosticSignError
     {:ctermfg :red
      :guifg colors.error})
(hi! :DiagnosticSignWarn
     {:ctermfg :yellow
      :guifg colors.warn})
(hi! :DiagnosticSignInfo
     {:ctermfg :green
      :guifg colors.info})
(hi! :DiagnosticSignHint
     {:ctermfg :blue
      :guifg colors.hint})
(hi! :DiagnosticSignLightBulb
     {:ctermfg :yellow
      :guifg colors.warn})
(hi! :DiagnosticVirtualTextError
     {:ctermfg :red
      :gui :italic
      :guifg colors.error
      :guibg colors.color5})
(hi! :DiagnosticVirtualTextWarn
     {:ctermfg :yellow
      :gui :italic
      :guifg colors.warn
      :guibg colors.color5})
(hi! :DiagnosticVirtualTextInfo
     {:ctermfg :green
      :gui :italic
      :guifg colors.info
      :guibg colors.color5})
(hi! :DiagnosticVirtualTextHint
     {:ctermfg :blue
      :gui :italic
      :guifg colors.hint
      :guibg colors.color5})
(hi! :DiagnosticError
     {:ctermfg :red
      :guifg colors.color8
      :guibg colors.color5})
(hi! :DiagnosticFloatingError
     {:ctermfg :red
      :guifg colors.color8
      :guibg colors.color5})
(hi! :DiagnosticWarn
     {:ctermfg :yellow
      :guifg colors.warn
      :guibg colors.color5})
(hi! :DiagnosticFloatingWarn
     {:ctermfg :yellow
      :guifg colors.warn
      :guibg colors.color5})
(hi! :DiagnosticHint
     {:ctermfg :blue
      :guifg colors.color10
      :guibg colors.color5})
(hi! :DiagnosticFloatingHint
     {:ctermfg :blue
      :guifg colors.color10
      :guibg colors.color5})
(hi! :DiagnosticInfo
     {:ctermfg :green
      :guifg colors.color13
      :guibg colors.color5})
(hi! :DiagnosticFloatingInfo
     {:ctermfg :green
      :guifg colors.color13
      :guibg colors.color5})
(hi! :LspCodeLens
     {:gui "bold,italic,underline"
      :guifg colors.color2
      :guibg colors.color10})

(hi! :TelescopeBorder
     {:bg :none
      :blend :0
      :ctermfg :blue
      :guifg colors.color10})
(hi! :TelescopePromptPrefix
     {:ctermfg :blue
      :guifg colors.color10})

(hi! :Conceal
     {:ctermfg :white
      :guifg colors.color4})

(hi! "@markup.underline"
     {:gui :underline})
