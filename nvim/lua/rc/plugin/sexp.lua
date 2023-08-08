-- [nfnl] Compiled from fnl/rc/plugin/sexp.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.sexp_enable_insert_mode_mappings = 0
vim.g.sexp_mappings = {sexp_insert_at_list_head = "", sexp_insert_at_list_tail = "", sexp_round_head_wrap_element = "", sexp_round_tail_wrap_element = "", sexp_round_head_wrap_list = "", sexp_round_tail_wrap_list = "", sexp_square_head_wrap_list = "", sexp_square_tail_wrap_list = "", sexp_curly_head_wrap_list = "", sexp_curly_tail_wrap_list = "", sexp_square_head_wrap_element = "", sexp_square_tail_wrap_element = "", sexp_curly_head_wrap_element = "", sexp_curly_tail_wrap_element = "", sexp_splice_list = "", sexp_convolute = "", sexp_raise_list = "", sexp_raise_element = ""}
vim.g.sexp_insert_after_wrap = 0
vim.g.sexp_filetypes = "clojure,fennel,hy,lisp,scheme"
vim.keymap.set("n", ">(", "<Plug>(sexp_emit_head_element)", {})
vim.keymap.set("n", "<)", "<Plug>(sexp_emit_tail_element)", {})
vim.keymap.set("n", "<(", "<Plug>(sexp_capture_prev_element)", {})
return vim.keymap.set("n", ">)", "<Plug>(sexp_capture_next_element)", {})
