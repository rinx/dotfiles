(module init
  {require {core aniseed.core
            nvim aniseed.nvim
            ts-cfg nvim-treesitter.configs}})

;; treesitter
(ts-cfg.setup
 {:ensure_installed [:bash
                     :c
                     :cpp
                     :fennel
                     :go
                     :java
                     :javascript
                     :json
                     :lua
                     :python
                     :rust
                     :toml
                     :typescript]
  :highlight {:enable true
              :disable []}})
