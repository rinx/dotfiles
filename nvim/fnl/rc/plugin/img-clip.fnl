(local clip (require :img-clip))

(clip.setup
  {:default
   {:relative_to_current_file true
    :prompt_for_file_name false}
   :filetypes
   {:org {:template "[[$FILE_PATH]]"}}})
