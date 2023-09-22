(local paredit (require :nvim-paredit))
(local paredit-fennel (require :nvim-paredit-fennel))
(local parpar (require :parpar))

(paredit.setup
 {:use_default_keys false
  :filetypes [:clojure
              :fennel]
  :keys {">)" [(parpar.wrap paredit.api.slurp_forwards) "Slurp forwards"]
         "<(" [(parpar.wrap paredit.api.slurp_backwards) "Slurp backwards"]
         "<)" [(parpar.wrap paredit.api.barf_forwards) "Barf forwards"]
         ">(" [(parpar.wrap paredit.api.barf_backwards) "Barf backwards"]}})

(paredit-fennel.setup)
