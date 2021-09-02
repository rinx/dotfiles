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
                                 :Outline
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

(hi! :Keyword {:cterm "bold,italic" :gui "bold,italic"})

(hi! :LspDiagnosticsUnderlineError
     {:cterm :undercurl :gui :undercurl :guisp colors.error})
(hi! :LspDiagnosticsUnderlineWarning
     {:cterm :undercurl :gui :undercurl :guisp colors.warn})
(hi! :LspDiagnosticsUnderlineInformation
     {:cterm :undercurl :gui :undercurl :guisp colors.info})
(hi! :LspDiagnosticsUnderlineHint
     {:cterm :undercurl :gui :undercurl :guisp colors.hint})
(hi! :LspDiagnosticsSignError
     {:ctermfg :red :guifg colors.error})
(hi! :LspDiagnosticsSignWarning
     {:ctermfg :yellow :guifg colors.warn})
(hi! :LspDiagnosticsSignInformation
     {:ctermfg :green :guifg colors.info})
(hi! :LspDiagnosticsSignHint
     {:ctermfg :blue :guifg colors.hint})
(hi! :LspDiagnosticsSignLightBulb
     {:ctermfg :yellow :guifg colors.warn})
(hi! :LspDiagnosticsVirtualTextError
     {:ctermfg :red :guifg colors.error :guibg colors.color5})
(hi! :LspDiagnosticsVirtualTextWarning
     {:ctermfg :yellow :guifg colors.warn :guibg colors.color5})
(hi! :LspDiagnosticsVirtualTextInformation
     {:ctermfg :green :guifg colors.info :guibg colors.color5})
(hi! :LspDiagnosticsVirtualTextHint
     {:ctermfg :blue :guifg colors.hint :guibg colors.color5})
(hi! :LspDiagnosticsDefaultError
     {:ctermfg :red :guifg colors.color8 :guibg colors.color5})
(hi! :LspDiagnosticsFloatingError
     {:ctermfg :red :guifg colors.color8 :guibg colors.color5})
(hi! :LspDiagnosticsDefaultWarning
     {:ctermfg :yellow :guifg colors.warn :guibg colors.color5})
(hi! :LspDiagnosticsFloatingWarning
     {:ctermfg :yellow :guifg colors.warn :guibg colors.color5})
(hi! :LspDiagnosticsDefaultHint
     {:ctermfg :blue :guifg colors.color10 :guibg colors.color5})
(hi! :LspDiagnosticsFloatingHint
     {:ctermfg :blue :guifg colors.color10 :guibg colors.color5})
(hi! :LspDiagnosticsDefaultInformation
     {:ctermfg :green :guifg colors.color13 :guibg colors.color5})
(hi! :LspDiagnosticsFloatingInformation
     {:ctermfg :green :guifg colors.color13 :guibg colors.color5})
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
    {:ctermfg :red :guifg colors.error})
(hi! :NotifyWARN
    {:ctermfg :yellow :guifg colors.warn})
(hi! :NotifyINFO
    {:ctermfg :green :guifg colors.info})
(hi! :NotifyDEBUG
    {:ctermfg :blue :guifg colors.hint})
(hi! :NotifyTRACE
    {:ctermfg :blue :guifg colors.hint})
(hi! :NotifyERRORTitle
    {:ctermfg :red :guifg colors.error})
(hi! :NotifyWARNTitle
    {:ctermfg :yellow :guifg colors.warn})
(hi! :NotifyINFOTitle
    {:ctermfg :green :guifg colors.info})
(hi! :NotifyDEBUGTitle
    {:ctermfg :blue :guifg colors.hint})
(hi! :NotifyTRACETitle
    {:ctermfg :blue :guifg colors.hint})
