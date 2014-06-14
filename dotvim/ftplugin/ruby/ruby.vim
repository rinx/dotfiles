"Ruby

setl autoindent
setl softtabstop=2
setl tabstop=2
setl shiftwidth=2
setl smarttab
setl expandtab

setl smartindent cinwords=if,elsif,else,unless,for,while,try,rescue,ensure,def,class,module


"neocomplcache omni patterns
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"iabbrev
iab shb #!/usr/bin/env ruby
iab enc # -*- coding: utf-8 -*-
