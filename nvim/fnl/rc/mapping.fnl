(import-macros {: map!} :rc.macros)

(set vim.g.mapleader :\ )

(map! [:n :v] ";" ":" {})
(map! [:n :v] ":" ";" {})

(map! [:n :i] :<Left>  :<Nop> {})
(map! [:n :i] :<Down>  :<Nop> {})
(map! [:n :i] :<Up>    :<Nop> {})
(map! [:n :i] :<Right> :<Nop> {})

(map! [:n] :<C-t> :<Nop> {})

(map! [:n :v :o] :j :gj {:silent true})
(map! [:n :v :o] :k :gk {:silent true})
(map! [:n] :0 :g0 {:silent true})
(map! [:n] :$ :g$ {:silent true})

(map! [:n :v :o] :gj :j {:silent true})
(map! [:n :v :o] :gk :k {:silent true})
(map! [:n] :g0 :0 {:silent true})
(map! [:n] :g$ :$ {:silent true})

(map! [:n] :Y :y$ {})

(map! [:n] ",p" "\"+p" {})
(map! [:n] ",P" "\"+P" {})

(map! [:n :v] ",y" "\"+y" {})
(map! [:n :v] ",d" "\"+d" {})

(map! [:c] :<C-p> :<Up> {})
(map! [:c] :<C-n> :<Down> {})

(map! [:t] :<ESC> "<C-\\><C-n>" {:silent true})

(map! [:n] :s :<Nop> {})
(map! [:n] :S :<Nop> {})
(map! [:n] :sj :<C-w>j {:silent true})
(map! [:n] :sk :<C-w>k {:silent true})
(map! [:n] :sl :<C-w>l {:silent true})
(map! [:n] :sh :<C-w>h {:silent true})
(map! [:n] :sJ :<C-w>J {:silent true})
(map! [:n] :sK :<C-w>K {:silent true})
(map! [:n] :sL :<C-w>L {:silent true})
(map! [:n] :sH :<C-w>H {:silent true})
(map! [:n] :sr :<C-w>r {:silent true})
(map! [:n] :sw :<C-w>w {:silent true})
(map! [:n] :s_ :<C-w>_ {:silent true})
(map! [:n] "s|" "<C-w>|" {:silent true})
(map! [:n] :so "<C-w>_<C-w>|" {:silent true})
(map! [:n] :sO "<C-w>=" {:silent true})
(map! [:n] :s= "<C-w>=" {:silent true})
(map! [:n] :ss ":<C-u>sp<CR>" {:silent true})
(map! [:n] :sv ":<C-u>vs<CR>" {:silent true})

(map! [:n] :<Leader>p ":setl paste!<CR>" {:silent true})
(map! [:n] :<Leader>r ":setl relativenumber!<CR>" {:silent true})
(map! [:n] :<Leader>s ":setl spell!<CR>" {:silent true})

(map! [:n] :MM :zz {})
(map! [:n] :ZZ :<Nop> {})
(map! [:n] :ZQ :<Nop> {})
(map! [:n] :Q :<Nop> {})

;; Toggle folding
(map! [:n] :<Space> :za {})
(map! [:n] :Q :zi {})
