(local actions-preview (require :actions-preview))

(import-macros {: map!} :rc.macros)

(actions-preview.setup
  {:backend [:nui :telescope]
   :nui {:dir :row}}
  (map! [:n :v]
        "<Leader>A"
        ":<C-u>lua require'actions-preview'.code_actions()<CR>"
        {:silent true}))
