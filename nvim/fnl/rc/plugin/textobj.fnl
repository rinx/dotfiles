(import-macros {: map!} :rc.macros)

(set vim.g.textobj_between_no_default_key_mappings 1)

(map! [:o :v] :ac "<Plug>(textobj-between-a)" {})
(map! [:o :v] :ic "<Plug>(textobj-between-i)" {})
(map! [:o :v] :ab "<Plug>(textobj-multiblock-a)" {})
(map! [:o :v] :ib "<Plug>(textobj-multiblock-i)" {})
