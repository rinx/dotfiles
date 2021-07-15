(module rc.plugin.eskk
  {autoload {nvim aniseed.nvim}})

(set nvim.g.eskk#dictionary
     {:path "~/.skk-jisyo"
      :sorted 0
      :encoding "euc_jp"})
(set nvim.g.eskk#large_dictionary
     {:path "~/.SKK-JISYO.L"
      :sorted 0
      :encoding "euc_jp"})
(set nvim.g.eskk#show_candidates_count 3)
(set nvim.g.eskk#kakutei_when_unique_candidate 1)
(set nvim.g.eskk#marker_henkan ">")
(set nvim.g.eskk#marker_okuri "*")
(set nvim.g.eskk#marker_henkan_select ">>")
(set nvim.g.eskk#marker_jisyo_touroku "?")
(set nvim.g.eskk#enable_completion 0)
(set nvim.g.eskk#max_candidates 15)
(set nvim.g.eskk#use_color_cursor 0)
