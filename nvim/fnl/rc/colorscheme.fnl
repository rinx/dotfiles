(module rc.colorscheme
  {autoload {nvim aniseed.nvim
             color rc.color}
   require-macros [rc.macros]})

(def- colors color.colors)

(set nvim.g.tokyonight_style :storm)
(set nvim.g.tokyonight_transparent true)
(set nvim.g.tokyonight_dark_sidebar true)
(set nvim.g.tokyonight_sidebars [:dapui_breakpoints
                                 :dapui_scopes
                                 :dapui_stacks
                                 :dapui_watches
                                 :NvimTree
                                 :packer])
(nvim.ex.silent_ "colorscheme tokyonight")
(nvim.ex.syntax :enable)

(hi! :Normal {:bg :none
              :blend :0})
(hi! :LineNr {:bg :none})
(hi! :VertSplit {:bg :none})
(hi! :NonText {:bg :none})
(hi! :EndOfBuffer {:bg :none})

(hi! :NormalFloat {:bg :none
                   :blend :0})
(hi! :LspFloatWinNormal {:bg :none
                         :blend :0})

(hi! :Keyword {:cterm "bold,italic"
               :gui "bold,italic"})

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

(hi! :NotifyERROR
     {:ctermfg :red
      :guifg colors.error})
(hi! :NotifyWARN
     {:ctermfg :yellow
      :guifg colors.warn})
(hi! :NotifyINFO
     {:ctermfg :green
      :guifg colors.info})
(hi! :NotifyDEBUG
     {:ctermfg :blue
      :guifg colors.hint})
(hi! :NotifyTRACE
     {:ctermfg :blue
      :guifg colors.hint})
(hi! :NotifyERRORTitle
     {:ctermfg :red
      :guifg colors.error})
(hi! :NotifyWARNTitle
     {:ctermfg :yellow
      :guifg colors.warn})
(hi! :NotifyINFOTitle
     {:ctermfg :green
      :guifg colors.info})
(hi! :NotifyDEBUGTitle
     {:ctermfg :blue
      :guifg colors.hint})
(hi! :NotifyTRACETitle
     {:ctermfg :blue
      :guifg colors.hint})

(hi! :FidgetTitle
     {:ctermfg :green
      :guifg colors.info})
(hi! :FidgetTask
     {:ctermfg :blue
      :guifg colors.hint})
