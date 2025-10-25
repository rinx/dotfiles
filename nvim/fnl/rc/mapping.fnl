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

(map! [:n] :sj "<C-w>j<Plug>(winnav)" {:silent true})
(map! [:n] :sk "<C-w>k<Plug>(winnav)" {:silent true})
(map! [:n] :sl "<C-w>l<Plug>(winnav)" {:silent true})
(map! [:n] :sh "<C-w>h<Plug>(winnav)" {:silent true})
(map! [:n] :sJ "<C-w>J<Plug>(winnav)" {:silent true})
(map! [:n] :sK "<C-w>K<Plug>(winnav)" {:silent true})
(map! [:n] :sL "<C-w>L<Plug>(winnav)" {:silent true})
(map! [:n] :sH "<C-w>H<Plug>(winnav)" {:silent true})
(map! [:n] :s> "<C-w>><Plug>(winnav)" {:silent true})
(map! [:n] :s< "<C-w><<Plug>(winnav)" {:silent true})
(map! [:n] :s+ "<C-w>+<Plug>(winnav)" {:silent true})
(map! [:n] :s- "<C-w>-<Plug>(winnav)" {:silent true})

(map! [:n] "<Plug>(winnav)j" "<C-w>j<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)k" "<C-w>k<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)l" "<C-w>l<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)h" "<C-w>h<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)J" "<C-w>J<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)K" "<C-w>K<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)L" "<C-w>L<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)H" "<C-w>H<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)>" "<C-w>><Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)<" "<C-w><<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)+" "<C-w>+<Plug>(winnav)" {:silent true})
(map! [:n] "<Plug>(winnav)-" "<C-w>-<Plug>(winnav)" {:silent true})

(map! [:n] :sr :<C-w>r {:silent true})
(map! [:n] :sw :<C-w>w {:silent true})
(map! [:n] :so "<C-w>_<C-w>|" {:silent true})
(map! [:n] :sO "<C-w>=" {:silent true})
(map! [:n] :s= "<C-w>=" {:silent true})

(map! [:n] :ss ":<C-u>sp<CR>" {:silent true})
(map! [:n] :sv ":<C-u>vs<CR>" {:silent true})

(map! [:n] :MM :zz {})
(map! [:n] :ZZ :<Nop> {})
(map! [:n] :ZQ :<Nop> {})
(map! [:n] :Q :<Nop> {})

(map! [:n] :H "H<Plug>(H)" {})
(map! [:n] :L "L<Plug>(L)" {})
(map! [:n] "<Plug>(H)H" "<PageUp><Plug>(H)" {})
(map! [:n] "<Plug>(L)L" "<PageDown><Plug>(L)" {})
