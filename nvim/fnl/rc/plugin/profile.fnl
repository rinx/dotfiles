(local profile (require :profile))

(when (not (= vim.NIL (vim.fn.getenv :NVIM_PROFILE)))
  (profile.instrument_autocmds)
  (profile.instrument "*"))

(fn toggle-profile []
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

(vim.api.nvim_create_user_command :ProfileToggle toggle-profile {})
