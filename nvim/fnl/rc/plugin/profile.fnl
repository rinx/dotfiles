(module rc.plugin.profile
  {autoload {core aniseed.core
             nvim aniseed.nvim
             profile profile}
   require-macros [rc.macros]})

(when (not (= vim.NIL (nvim.fn.getenv :NVIM_PROFILE)))
  (profile.instrument_autocmds)
  (profile.instrument "*"))

(defn toggle-profile []
  (if (profile.is_recording)
    (do
      (profile.stop)
      (vim.ui.input
        {:prompt "Save profile to:"
         :completion :file
         :default :profile.json}
        (fn [filename]
          (when filename
            (profile.export filename)
            (vim.notify (string.format "Wrote %s" filename))))))
    (profile.start "*")))

(nvim.ex.command_ :ProfileToggle (->viml! :toggle-profile))
