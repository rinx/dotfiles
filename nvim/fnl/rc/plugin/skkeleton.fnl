(module rc.plugin.skkeleton
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util rc.util}
   require-macros [rc.macros]})

(map! [:i] :<C-j> "<Plug>(skkeleton-toggle)")
(map! [:c] :<C-j> "<Plug>(skkeleton-toggle)")

(defn initialize []
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
     :usePopup true
     :userJisyo "~/.skk-jisyo"}))

(defn enable-pre []
  (when (util.loaded? :nvim-cmp)
    (let [cmp (require :cmp)]
      (cmp.setup.buffer
        {:view
         {:entries :native}}))))

(defn disable-pre []
  (when (util.loaded? :nvim-cmp)
    (let [cmp (require :cmp)]
      (cmp.setup.buffer
        {:view
         {:entries :custom}}))))

(augroup! init-skkeleton
          (autocmd! :User :skkeleton-initialize-pre (->viml! :initialize))
          (autocmd! :User :skkeleton-enable-pre (->viml! :enable-pre))
          (autocmd! :User :skkeleton-disable-pre (->viml! :disable-pre))
          (autocmd! :User :skkeleton-mode-changed :redrawstatus))
