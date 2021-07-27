(module rc.colorscheme
  {autoload {nvim aniseed.nvim
             color rc.color
             util rc.util}})

(def- colors color.colors)
(def- hi util.hi)
(def- hi-link util.hi)

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

(hi :Normal {:bg :none})
(hi :LineNr {:bg :none})
(hi :VertSplit {:bg :none})
(hi :NonText {:bg :none})
(hi :EndOfBuffer {:bg :none})

(hi :Keyword {:others "cterm=bold,italic gui=bold,italic"})

(hi :LspDiagnosticsUnderlineError
    {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.error)})
(hi :LspDiagnosticsUnderlineWarning
    {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.warn)})
(hi :LspDiagnosticsUnderlineInformation
    {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.info)})
(hi :LspDiagnosticsUnderlineHint
    {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.hint)})
(hi :LspDiagnosticsSignError
    {:others (.. "ctermfg=red guifg=" colors.error)})
(hi :LspDiagnosticsSignWarning
    {:others (.. "ctermfg=yellow guifg=" colors.warn)})
(hi :LspDiagnosticsSignInformation
    {:others (.. "ctermfg=green guifg=" colors.info)})
(hi :LspDiagnosticsSignHint
    {:others (.. "ctermfg=blue guifg=" colors.hint)})
(hi :LspDiagnosticsSignLightBulb
    {:others (.. "ctermfg=yellow guifg=" colors.warn)})
(hi :LspDiagnosticsVirtualTextError
    {:others (.. "ctermfg=red guifg=" colors.error " guibg=" colors.color5)})
(hi :LspDiagnosticsVirtualTextWarning
    {:others (.. "ctermfg=yellow guifg=" colors.warn " guibg=" colors.color5)})
(hi :LspDiagnosticsVirtualTextInformation
    {:others (.. "ctermfg=green guifg=" colors.info " guibg=" colors.color5)})
(hi :LspDiagnosticsVirtualTextHint
    {:others (.. "ctermfg=blue guifg=" colors.hint " guibg=" colors.color5)})
(hi :LspDiagnosticsDefaultError
    {:others (.. "ctermfg=red guifg=" colors.color8 " guibg=" colors.color5)})
(hi :LspDiagnosticsFloatingError
    {:others (.. "ctermfg=red guifg=" colors.color8 " guibg=" colors.color5)})
(hi :LspDiagnosticsDefaultWarning
    {:others (.. "ctermfg=yellow guifg=" colors.warn " guibg=" colors.color5)})
(hi :LspDiagnosticsFloatingWarning
    {:others (.. "ctermfg=yellow guifg=" colors.warn " guibg=" colors.color5)})
(hi :LspDiagnosticsDefaultHint
    {:others (.. "ctermfg=blue guifg=" colors.color10 " guibg=" colors.color5)})
(hi :LspDiagnosticsFloatingHint
    {:others (.. "ctermfg=blue guifg=" colors.color10 " guibg=" colors.color5)})
(hi :LspDiagnosticsDefaultInformation
    {:others (.. "ctermfg=green guifg=" colors.color13 " guibg=" colors.color5)})
(hi :LspDiagnosticsFloatingInformation
    {:others (.. "ctermfg=green guifg=" colors.color13 " guibg=" colors.color5)})
(hi :LspCodeLens
    {:others (.. "gui=bold,italic,underline guifg=" colors.color2
                 " guibg=" colors.color10)})

(hi :TelescopeBorder
    {:bg :none
     :others (.. "blend=0 ctermfg=blue guifg=" colors.color10)})
(hi :TelescopePromptPrefix
    {:others (.. "ctermfg=blue guifg=" colors.color10)})
