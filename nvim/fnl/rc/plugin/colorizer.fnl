(module rc.plugin.colorizer
  {autoload {nvim aniseed.nvim
             colorizer colorizer}})

;; enforce to set &termguicolors
(nvim.ex.set :termguicolors)
(colorizer.setup)
