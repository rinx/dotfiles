(local avante (require :avante))

(avante.setup
  {:provider :copilot
   :behavior
   {:auto_set_keymaps false
    :auto_suggestions false
    :auto_apply_diff_after_generation true}
   :hints
   {:enabled false}
   :file_selector
   {:provider :snacks}})
