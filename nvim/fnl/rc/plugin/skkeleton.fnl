(module rc.plugin.skkeleton
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util rc.util}})

(def- imap util.imap)
(def- cmap util.cmap)

(imap :<C-j> "<Plug>(skkeleton-enable)")
(cmap :<C-j> "<Plug>(skkeleton-enable)")

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
