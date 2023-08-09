(import-macros {: map! : augroup!} :rc.macros)

(map! [:i] :<C-j> "<Plug>(skkeleton-toggle)" {})
(map! [:c] :<C-j> "<Plug>(skkeleton-toggle)" {})

(fn initialize []
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

(fn enable-pre []
  (let [cmp (require :cmp)]
    (cmp.setup.buffer
      {:view
       {:entries :native}})))

(fn disable-pre []
  (let [cmp (require :cmp)]
    (cmp.setup.buffer
      {:view
       {:entries :custom}})))

(augroup!
  init-skkeleton
  {:events [:User]
   :pattern :skkeleton-initialize-pre
   :callback initialize}
  {:events [:User]
   :pattern :skkeleton-enable-pre
   :callback enable-pre}
  {:events [:User]
   :pattern :skkeleton-disable-pre
   :callback disable-pre}
  {:events [:User]
   :pattern :skkeleton-mode-changed
   :command :redrawstatus})
