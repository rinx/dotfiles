(local octo (require :octo))

(when (= (vim.fn.executable :gh) 1)
  (octo.setup {}))
