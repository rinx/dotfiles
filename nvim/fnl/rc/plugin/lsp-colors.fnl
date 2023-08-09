(local {: autoload} (require :nfnl.module))

(local lsp-colors (require :lsp-colors))

(local color (autoload :rc.color))
(local colors color.colors)

(lsp-colors.setup {:Error colors.error
                   :Warning colors.warn
                   :Information colors.info
                   :Hint colors.hint})
