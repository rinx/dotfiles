(module rc.mapping
  {autoload {nvim aniseed.nvim
             util rc.util}
   require-macros [rc.macros]})

(def- _map util._map)

(set nvim.g.mapleader :\ )

(noremap! [:n :v] ";" ":")
(noremap! [:n :v] ":" ";")

(noremap! [:n :i] :<Left>  :<Nop>)
(noremap! [:n :i] :<Down>  :<Nop>)
(noremap! [:n :i] :<Up>    :<Nop>)
(noremap! [:n :i] :<Right> :<Nop>)

(noremap! [:n] :<C-t> :<Nop>)

(noremap! [:n :v :o] :j :gj :silent)
(noremap! [:n :v :o] :k :gk :silent)
(noremap! [:n] :0 :g0 :silent)
(noremap! [:n] :$ :g$ :silent)

(noremap! [:n :v :o] :gj :j :silent)
(noremap! [:n :v :o] :gk :k :silent)
(noremap! [:n] :g0 :0 :silent)
(noremap! [:n] :g$ :$ :silent)

(noremap! [:n] :Y :y$)

(noremap! [:n] ",p" "\"+p")
(noremap! [:n] ",P" "\"+P")

(noremap! [:n :v] ",y" "\"+y")
(noremap! [:n :v] ",d" "\"+d")

(noremap! [:c] :<C-p> :<Up>)
(noremap! [:c] :<C-n> :<Down>)

(noremap! [:t] :<ESC> "<C-\\><C-n>" :silent)

(noremap! [:n] :s :<Nop>)
(noremap! [:n] :S :<Nop>)
(noremap! [:n] :sj :<C-w>j :silent)
(noremap! [:n] :sk :<C-w>k :silent)
(noremap! [:n] :sl :<C-w>l :silent)
(noremap! [:n] :sh :<C-w>h :silent)
(noremap! [:n] :sJ :<C-w>J :silent)
(noremap! [:n] :sK :<C-w>K :silent)
(noremap! [:n] :sL :<C-w>L :silent)
(noremap! [:n] :sH :<C-w>H :silent)
(noremap! [:n] :sr :<C-w>r :silent)
(noremap! [:n] :sw :<C-w>w :silent)
(noremap! [:n] :s_ :<C-w>_ :silent)
(noremap! [:n] "s|" "<C-w>|" :silent)
(noremap! [:n] :so "<C-w>_<C-w>|" :silent)
(noremap! [:n] :sO "<C-w>=" :silent)
(noremap! [:n] :s= "<C-w>=" :silent)
(noremap! [:n] :ss ":<C-u>sp<CR>" :silent)
(noremap! [:n] :sv ":<C-u>vs<CR>" :silent)

(noremap! [:n] :<Leader>p ":setl paste!<CR>" :silent)
(noremap! [:n] :<Leader>r ":setl relativenumber!<CR>" :silent)
(noremap! [:n] :<Leader>s ":setl spell!<CR>" :silent)

(noremap! [:n] :MM :zz)
(noremap! [:n] :ZZ :<Nop>)
(noremap! [:n] :ZQ :<Nop>)
(noremap! [:n] :Q :<Nop>)

;; operator
(_map :X "<Plug>(operator-replace)")
(_map :Sa "<Plug>(operator-surround-append)")
(_map :Sd "<Plug>(operator-surround-delete)")
(_map :Sr "<Plug>(operator-surround-replace)")

;; textobj
(set nvim.g.textobj_between_no_default_key_mappings 1)
(map! [:o :v] :ac "<Plug>(textobj-between-a)")
(map! [:o :v] :ic "<Plug>(textobj-between-i)")
(map! [:o :v] :ab "<Plug>(textobj-multiblock-a)")
(map! [:o :v] :ib "<Plug>(textobj-multiblock-i)")
