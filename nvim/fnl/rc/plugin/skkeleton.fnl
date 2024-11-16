(import-macros {: map! : augroup!} :rc.macros)

(map! [:i] :<C-j> "<Plug>(skkeleton-toggle)" {})
(map! [:c] :<C-j> "<Plug>(skkeleton-toggle)" {})

(fn initialize []
  (vim.fn.skkeleton#config
    {:eggLikeNewline false
     :globalDictionaries ["~/.SKK-JISYO.L"]
     :immediatelyDictionaryRW true
     :registerConvertResult false
     :keepState true
     :selectCandidateKeys :asdfjkl
     :setUndoPoint true
     :showCandidatesCount 4
     :usePopup true
     :userDictionary "~/.skk-jisyo"}))

(augroup!
  init-skkeleton
  {:events [:User]
   :pattern :skkeleton-initialize-pre
   :callback initialize}
  {:events [:User]
   :pattern :skkeleton-mode-changed
   :command :redrawstatus})
