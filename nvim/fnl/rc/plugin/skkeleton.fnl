(module rc.plugin.skkeleton
  {autoload {core aniseed.core
             nvim aniseed.nvim}
   require-macros [rc.macros]})

(map! [:i] :<C-j> "<Plug>(skkeleton-enable)")
(map! [:c] :<C-j> "<Plug>(skkeleton-enable)")

(vim.fn.skkeleton#config
  {:eggLikeNewline false
   :globalJisyo (nvim.fn.expand "~/.SKK-JISYO.L")
   :globalJisyoEncoding :euc-jp
   :immediatelyJisyoRW true
   :selectCandidateKeys :asdfjkl
   :setUndoPoint true
   :showCandidatesCount 4
   :usePopup true
   :userJisyo (nvim.fn.expand "~/.skk-jisyo")})
