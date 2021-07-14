(module dotfiles.plugin.sexp
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

(def- nmap util.nmap)

(set nvim.g.sexp_enable_insert_mode_mappings 0)
(set nvim.g.sexp_mappings {:sexp_insert_at_list_head ""
                           :sexp_insert_at_list_tail ""
                           :sexp_round_head_wrap_element ""
                           :sexp_round_tail_wrap_element ""
                           :sexp_round_head_wrap_list ""
                           :sexp_round_tail_wrap_list ""
                           :sexp_square_head_wrap_list ""
                           :sexp_square_tail_wrap_list ""
                           :sexp_curly_head_wrap_list ""
                           :sexp_curly_tail_wrap_list ""
                           :sexp_round_head_wrap_element ""
                           :sexp_round_tail_wrap_element ""
                           :sexp_square_head_wrap_element ""
                           :sexp_square_tail_wrap_element ""
                           :sexp_curly_head_wrap_element ""
                           :sexp_curly_tail_wrap_element ""
                           :sexp_insert_at_list_head ""
                           :sexp_insert_at_list_tail ""
                           :sexp_splice_list ""
                           :sexp_convolute ""
                           :sexp_raise_list ""
                           :sexp_raise_element ""})
(set nvim.g.sexp_insert_after_wrap 0)
(set nvim.g.sexp_filetypes "clojure,fennel,hy,lisp,scheme")

(nmap ">(" "<Plug>(sexp_emit_head_element)")
(nmap "<)" "<Plug>(sexp_emit_tail_element)")
(nmap "<(" "<Plug>(sexp_capture_prev_element)")
(nmap ">)" "<Plug>(sexp_capture_next_element)")
