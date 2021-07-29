(module rc.plugin.submode
  {autoload {nvim aniseed.nvim}})

;; window
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')")
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')")
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')")
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '>', '<C-w>>')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '<', '<C-w><')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '+', '<C-w>+')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '-', '<C-w>-')")

