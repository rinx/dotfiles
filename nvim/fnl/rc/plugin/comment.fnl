(module rc.plugin.comment
  {autoload {ncm nvim_comment}})

(ncm.setup
  {:marker_padding true
   :comment_empty true
   :create_mappings true
   :line_mapping :gcc
   :operator_mapping :gc
   :hook nil})
