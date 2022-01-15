(module rc.plugin.lightspeed
  {autoload {nvim aniseed.nvim
             lightspeed lightspeed}
   require-macros [rc.macros]})

(lightspeed.setup
  {:match_only_the_start_of_same_char_seqs true
   :limit_ft_matches 5})

(map! [:n] :z :<Plug>Lightspeed_s)
(map! [:n] :Z :<Plug>Lightspeed_S)
(map! [:n] :<C-x> :<Plug>Lightspeed_x)
