(module rc.mapping
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util rc.util}})

(def- nmap util.nmap)
(def- imap util.imap)
(def- xmap util.xmap)
(def- vmap util.vmap)
(def- omap util.omap)

(def- nnoremap util.nnoremap)
(def- inoremap util.inoremap)
(def- cnoremap util.cnoremap)
(def- vnoremap util.vnoremap)
(def- onoremap util.onoremap)

(def- nmap-silent util.nmap-silent)
(def- nnoremap-silent util.nnoremap-silent)

(set nvim.g.mapleader :\)

(nnoremap ";" ":")
(nnoremap ":" ";")
(vnoremap ";" ":")
(vnoremap ":" ";")

(nnoremap "<Left>" "<Nop>")
(nnoremap "<Down>" "<Nop>")
(nnoremap "<Up>" "<Nop>")
(nnoremap "<Right>" "<Nop>")

(inoremap "<Left>" "<Nop>")
(inoremap "<Down>" "<Nop>")
(inoremap "<Up>" "<Nop>")
(inoremap "<Right>" "<Nop>")

(nnoremap "<C-t>" "<Nop>")

(nnoremap "j" "gj")
(nnoremap "k" "gk")
(nnoremap "0" "g0")
(nnoremap "$" "g$")
(vnoremap "j" "gj")
(vnoremap "k" "gk")
(onoremap "j" "gj")
(onoremap "k" "gk")

(nnoremap "gj" "j")
(nnoremap "gk" "k")
(nnoremap "g0" "0")
(nnoremap "g$" "$")
(vnoremap "gj" "j")
(vnoremap "gk" "k")
(onoremap "gj" "j")
(onoremap "gk" "k")

(nnoremap "Y" "y$")

(nnoremap ",p" "\"+p")
(nnoremap ",P" "\"+P")

(nnoremap ",y" "\"+y")
(nnoremap ",d" "\"+d")
(vnoremap ",y" "\"+y")
(vnoremap ",d" "\"+d")

(cnoremap "<C-p>" "<Up>")
(cnoremap "<C-n>" "<Down>")

(nvim.set_keymap :t "<ESC>" "<C-\\><C-n>" {:noremap true
                                           :silent true})

(nnoremap :s :<Nop>)
(nnoremap :S :<Nop>)
(nnoremap-silent "sj" "<C-w>j")
(nnoremap-silent "sk" "<C-w>k")
(nnoremap-silent "sl" "<C-w>l")
(nnoremap-silent "sh" "<C-w>h")
(nnoremap-silent "sJ" "<C-w>J")
(nnoremap-silent "sK" "<C-w>K")
(nnoremap-silent "sL" "<C-w>L")
(nnoremap-silent "sH" "<C-w>H")
(nnoremap-silent "sr" "<C-w>r")
(nnoremap-silent "sw" "<C-w>w")
(nnoremap-silent "s_" "<C-w>_")
(nnoremap-silent "s|" "<C-w>|")
(nnoremap-silent "so" "<C-w>_<C-w>|")
(nnoremap-silent "sO" "<C-w>=")
(nnoremap-silent "s=" "<C-w>=")
(nnoremap-silent "ss" ":<C-u>sp<CR>")
(nnoremap-silent "sv" ":<C-u>vs<CR>")

(nnoremap-silent "<Leader>p" ":setl paste!<CR>")
(nnoremap-silent "<Leader>r" ":setl relativenumber!<CR>")
(nnoremap-silent "<Leader>s" ":setl spell!<CR>")

(nnoremap :MM :zz)
(nnoremap :ZZ :<Nop>)
(nnoremap :ZQ :<Nop>)
(nnoremap :Q :<Nop>)

;; submode
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')")
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')")
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')")
(nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '>', '<C-w>>')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '<', '<C-w><')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '+', '<C-w>+')")
(nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '-', '<C-w>-')")

;; arpeggio
(nvim.ex.silent_ "call arpeggio#load()")

;; operator
(set nvim.g.caw_no_default_keymappings 1)
(nvim.ex.silent_ "Arpeggio map or <Plug>(operator-replace)")
(nvim.ex.silent_ "Arpeggio map oc <Plug>(caw:hatpos:toggle:operator)")
(nvim.ex.silent_ "Arpeggio map od <Plug>(caw:hatpos:uncomment:operator)")
(nvim.ex.silent_ "Arpeggio map oe <Plug>(caw:zeropos:toggle:operator)")
(nvim.set_keymap "" "Sa" "<Plug>(operator-surround-append)" {})
(nvim.set_keymap "" "Sd" "<Plug>(operator-surround-delete)" {})
(nvim.set_keymap "" "Sr" "<Plug>(operator-surround-replace)" {})

;; textobj
(set nvim.g.textobj_between_no_default_key_mappings 1)
(omap "ac" "<Plug>(textobj-between-a)")
(omap "ic" "<Plug>(textobj-between-i)")
(vmap "ac" "<Plug>(textobj-between-a)")
(vmap "ic" "<Plug>(textobj-between-i)")
(omap "ab" "<Plug>(textobj-multiblock-a)")
(omap "ib" "<Plug>(textobj-multiblock-i)")
(vmap "ab" "<Plug>(textobj-multiblock-a)")
(vmap "ib" "<Plug>(textobj-multiblock-i)")
