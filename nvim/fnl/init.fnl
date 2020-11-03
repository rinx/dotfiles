(module init
  {require {core aniseed.core
            nvim aniseed.nvim
            util aniseed.nvim.util
            icon util.icon
            ts-cfg nvim-treesitter.configs
            devicon nvim-web-devicons}
   require-macros [util.macros]})

(local icontab icon.tab)

(defn- bridge [from to]
  (util.fn-bridge from :init to {:return true}))

(defn- nnoremap [from to]
  (nvim.set_keymap :n from to {:noremap true}))
(defn- inoremap [from to]
  (nvim.set_keymap :i from to {:noremap true}))
(defn- cnoremap [from to]
  (nvim.set_keymap :c from to {:noremap true}))
(defn- vnoremap [from to]
  (nvim.set_keymap :v from to {:noremap true}))
(defn- onoremap [from to]
  (nvim.set_keymap :o from to {:noremap true}))

(defn- nnoremap-silent [from to]
  (nvim.set_keymap :n from to {:noremap true
                               :silent true}))

;; mappings
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

(nnoremap "s" "<Nop>")
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

(nnoremap "ZZ" "<Nop>")
(nnoremap "ZQ" "<Nop>")
(nnoremap "Q" "<Nop>")

;; grep
(if (= (nvim.fn.executable "rg") 1)
  (do
    (set nvim.o.grepprg "rg --vimgrep --no-heading")
    (set nvim.o.grepformat "%f:%l:%c:%m,%f:%l:%m")
    (set nvim.g.ackprg "rg --vimgrep --no-heading")))

;; eskk
(set nvim.g.eskk#dictionary
     {:path "~/.skk-jisyo"
      :sorted 0
      :encoding "euc_jp"})
(set nvim.g.eskk#large_dictionary
     {:path "~/.SKK-JISYO.L"
      :sorted 0
      :encoding "euc_jp"})
(set nvim.g.eskk#show_candidates_count 3)
(set nvim.g.eskk#kakutei_when_unique_candidate 1)
(set nvim.g.eskk#marker_henkan ">")
(set nvim.g.eskk#marker_okuri "*")
(set nvim.g.eskk#marker_henkan_select ">>")
(set nvim.g.eskk#marker_jisyo_touroku "?")
(set nvim.g.eskk#enable_completion 0)
(set nvim.g.eskk#max_candidates 15)
(set nvim.g.eskk#use_color_cursor 0)

;; ale.vim
(set nvim.g.ale_lint_on_save 1)
(set nvim.g.ale_lint_on_enter 1)
(set nvim.g.ale_lint_on_text_changed :never)
(set nvim.g.ale_lint_on_filetype_changed 1)
(set nvim.g.ale_fix_on_save 1)
(set nvim.g.ale_linters {:clojure [:clj-kondo]
                         :go [:golangci-lint]
                         :rust [:rls]})
(set nvim.g.ale_fixers {"*" [:remove_trailing_lines :trim_whitespace]
                        :go [:goimports]
                        :rust [:rustfmt]})
(set nvim.g.ale_set_quickfix 0)
(set nvim.g.ale_set_loclist 1)
(set nvim.g.ale_open_list 1)
(set nvim.g.ale_sign_column_always 1)
(set nvim.g.ale_warn_about_trailing_blank_lines 1)
(set nvim.g.ale_warn_about_trailing_whitespace 1)

;; json
(augroup init-json
         (autocmd :FileType :json "setlocal shiftwidth=2"))

;; yaml
(augroup init-yaml
         (autocmd :FileType :yaml "setlocal shiftwidth=2"))

;; fennel
(set nvim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed.")

(augroup init-fennel
         (autocmd :FileType :fennel "setlocal shiftwidth=2"))

;; rust
(augroup init-rust
         (autocmd :FileType :rust "let b:coc_pairs_disabled = [\"'\"]"))

;; treesitter
(ts-cfg.setup
  {:ensure_installed [:bash
                      :c
                      :cpp
                      :fennel
                      :go
                      :java
                      :javascript
                      :json
                      :lua
                      :python
                      :rust
                      :toml
                      :typescript]
   :highlight {:enable true
               :disable []}})

;; barbar.nvim
(nnoremap-silent ",bc" ":tabe<CR>")
(nnoremap-silent ",bd" ":BufferClose<CR>")
(nnoremap-silent ",bb" ":BufferPick<CR>")
(nnoremap-silent ",bo" ":BufferOrderByDirectory<CR>")
(nnoremap-silent ",bl" ":BufferOrderByLanguage<CR>")
(nnoremap-silent ",bn" ":BufferNext<CR>")
(nnoremap-silent ",bp" ":BufferPrevious<CR>")
(nnoremap-silent ",bN" ":BufferMoveNext<CR>")
(nnoremap-silent ",bP" ":BufferMovePrevious<CR>")
(nnoremap-silent "gt"  ":BufferNext<CR>")
(nnoremap-silent "gT"  ":BufferPrevious<CR>")

;; lightline
(defn lightline-filename []
  (let [filename (nvim.fn.expand "%")
        filename (if (= filename "")
                   "No Name"
                   filename)
        extension (nvim.fn.expand "%:e")
        icon (match nvim.bo.ft
               :help icontab.lock
               :qf icontab.lock
               _ (if nvim.bo.ro
                   icontab.lock
                   (devicon.get_icon filename extension {:default true})))
        modified (match nvim.bo.ft
                   :help ""
                   :qf ""
                   _ (if nvim.bo.modified
                       (.. " " icontab.plus)
                       (if nvim.bo.modifiable
                         ""
                         (.. " " icontab.minus))))]
    (.. icon " " filename modified)))
(bridge :LightlineFilename :lightline-filename)

(defn lightline-lineinfo []
  (let [row (nvim.fn.line ".")
        col (nvim.fn.col ".")]
    (.. icontab.ln row " " icontab.cn col)))
(bridge :LightlineLineinfo :lightline-lineinfo)

(defn lightline-gitstatus []
  (let [g-status (. nvim.g :coc_git_status)]
    (if (and g-status (not (= g-status "")))
      (.. icontab.branch " " g-status)
      "")))
(bridge :LightlineGitstatus :lightline-gitstatus)

(defn lightline-ale-warnings []
  (let [bufnr (nvim.fn.bufnr "")
        count (nvim.fn.ale#statusline#Count bufnr)]
    (if count
      (let [err count.error
            warn count.warning]
      (.. icontab.exclam warn " " icontab.times err))
      "")))
(bridge :LightlineALEWarnings :lightline-ale-warnings)

(set nvim.g.lightline
     {:enable {:statusline 1
               :tabline 0}
      :colorscheme :seoul256
      :active {:left [[:mode :paste :spell]
                      [:filename :gitstatus :cocstatus]]
               :right [[:lineinfo]
                       [:fileformat :fileencoding :filetype]
                       [:alewarnings]]}
      :component_function {:filename :LightlineFilename
                           :lineinfo :LightlineLineinfo
                           :gitstatus :LightlineGitstatus
                           :cocstatus :coc#status
                           :alewarnings :LightlineALEWarnings}
      :inactive {:left [[:filename]]
                 :right [[:filetype]]}
      :separator {:left icontab.round-l
                  :right icontab.round-r}
      :mode_map {:n icontab.minus-square
                 :i icontab.info
                 :R icontab.arrow-r
                 :v icontab.cursor-text
                 :V icontab.cursor
                 "" icontab.cursor
                 :c icontab.terminal
                 :s "S"
                 :S "SL"
                 "" "SB"
                 :t "T"}})
