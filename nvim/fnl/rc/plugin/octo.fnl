(module rc.plugin.octo
  {autoload {nvim aniseed.nvim
             octo octo}})

(when (= (nvim.fn.executable :gh) 1)
  (octo.setup {}))
