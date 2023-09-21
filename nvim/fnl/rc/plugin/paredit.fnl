(local paredit (require :nvim-paredit))

(paredit.setup
  {:use_default_keys false
   :filetypes [:clojure
               :fennel]
   :keys {">)" [paredit.api.slurp_forwards "Slurp forwards"]
          ">(" [paredit.api.slurp_backwards "Slurp backwards"]
          "<)" [paredit.api.barf_forwards "Barf forwards"]
          "<(" [paredit.api.barf_backwards "Barf backwards"]}})
