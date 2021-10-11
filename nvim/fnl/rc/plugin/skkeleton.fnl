(module rc.plugin.skkeleton
  {autoload {core aniseed.core
             nvim aniseed.nvim}
   require-macros [rc.macros]})

(map! [:i] :<C-j> "<Plug>(skkeleton-toggle)")
(map! [:c] :<C-j> "<Plug>(skkeleton-toggle)")

(vim.fn.skkeleton#config
  {:eggLikeNewline false
   :globalJisyo "~/.SKK-JISYO.L"
   :globalJisyoEncoding :euc-jp
   :immediatelyJisyoRW true
   :registerConvertResult false
   :keepState true
   :selectCandidateKeys :asdfjkl
   :setUndoPoint true
   :showCandidatesCount 4
   :tabCompletion true
   :usePopup true
   :userJisyo "~/.skk-jisyo"})
