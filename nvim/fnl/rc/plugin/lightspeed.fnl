(module rc.plugin.lightspeed
  {autoload {nvim aniseed.nvim
             lightspeed lightspeed}
   require-macros [rc.macros]})

(lightspeed.setup
  {:jump_on_partial_input_safety_timeout 400
   :highlight_unique_chars false
   :grey_out_search_area true
   :match_only_the_start_of_same_char_seqs true
   :limit_ft_matches 5})

(map! [:n] :z :<Plug>Lightspeed_s)
(map! [:n] :Z :<Plug>Lightspeed_S)
(map! [:n] :<C-x> :<Plug>Lightspeed_x)
