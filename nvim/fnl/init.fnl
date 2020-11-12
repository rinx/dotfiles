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

(defn- nmap [from to]
  (nvim.set_keymap :n from to {}))
(defn- xmap [from to]
  (nvim.set_keymap :x from to {}))
(defn- vmap [from to]
  (nvim.set_keymap :v from to {}))
(defn- omap [from to]
  (nvim.set_keymap :o from to {}))
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

(defn- nmap-silent [from to]
  (nvim.set_keymap :n from to {:silent true}))
(defn- nnoremap-silent [from to]
  (nvim.set_keymap :n from to {:noremap true
                               :silent true}))

;; basics
(set nvim.o.viminfo "'1000,<100,f1,h,s100")
(set nvim.o.history 300)
(set nvim.o.bs "indent,eol,start")

(nvim.ex.set :ruler)
(nvim.ex.set :number)
(set nvim.o.cmdheight 2)
(nvim.ex.set :wildmenu)
(set nvim.o.wildchar 9) ;; 9 = <Tab>
(set nvim.o.wildmode "longest:full,full")

(set nvim.o.shortmess "filnxtToOFc")

(set nvim.o.completeopt "menuone,noinsert,noselect")

(nvim.ex.set :imdisable)

(nvim.ex.set :incsearch)
(nvim.ex.set :ignorecase)
(nvim.ex.set :smartcase)

(nvim.ex.set :autoindent)
(nvim.ex.set :smartindent)
(nvim.ex.set :breakindent)

(nvim.ex.set :confirm)

(set nvim.o.clipboard "unnamed,unnamedplus")

(set nvim.o.mouse "a")

(set nvim.o.foldmethod "marker")

(set nvim.o.virtualedit "block")

(nvim.ex.set :expandtab)
(nvim.ex.set :smarttab)
(set nvim.o.tabstop 8)
(set nvim.o.shiftwidth 4)
(set nvim.o.softtabstop 4)

(if (= (nvim.fn.exists "&pumblend") 1)
  (set nvim.o.pumblend 30))
(if (= (nvim.fn.exists "&winblend") 1)
  (set nvim.o.winblend 30))

(nvim.ex.set :visualbell)
(nvim.ex.set :lazyredraw)
(nvim.ex.set :ttyfast)

(nvim.ex.set :showmatch)
(set nvim.o.matchtime 3)

(nvim.ex.set :nobackup)
(nvim.ex.set :nowritebackup)

(set nvim.o.updatetime 300)
(set nvim.o.timeoutlen 500)

(set nvim.wo.signcolumn "number")

(nvim.ex.set :undofile)
(set nvim.o.undolevels 1000)
(set nvim.o.undoreload 10000)

(let [backupdir (nvim.fn.expand "~/.config/nvim/tmp/backup")
      undodir (nvim.fn.expand "~/.config/nvim/tmp/undo")
      swapdir (nvim.fn.expand "~/.config/nvim/tmp/swap")]
  (set nvim.o.backupdir backupdir)
  (set nvim.o.undodir undodir)
  (set nvim.o.directory swapdir)

  (if (not (= (nvim.fn.isdirectory backupdir) 1))
    (nvim.fn.mkdir backupdir :p))
  (if (not (= (nvim.fn.isdirectory undodir) 1))
    (nvim.fn.mkdir undodir :p))
  (if (not (= (nvim.fn.isdirectory swapdir) 1))
    (nvim.fn.mkdir swapdir :p)))

(nvim.ex.set :list)
(set nvim.o.listchars "eol:¬,tab:▸ ,extends:>,precedes:<,trail:-")

(nvim.ex.set :noautochdir)
(nvim.ex.set :autoread)
(nvim.ex.set :noautowrite)

(nvim.ex.set :noexrc)
(nvim.ex.set :nosecure)

(nvim.ex.set :timeout)
(set nvim.o.timeoutlen 1000)
(set nvim.o.ttimeoutlen 200)

(nvim.ex.set :hidden)

(set nvim.o.laststatus 2)
(set nvim.o.showtabline 2)

(nvim.ex.set :hlsearch)
(nvim.ex.set :termguicolors)
(nvim.ex.syntax :on)
(nvim.ex.filetype :off)
(nvim.ex.filetype "plugin indent on")

(nvim.ex.silent_ "colorscheme doom-one")
(nvim.ex.set "background=dark")
(nvim.ex.syntax :enable)

(nvim.ex.highlight "Normal ctermbg=none guibg=none")

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
(set nvim.g.ale_go_golangci_lint_options "--enable-all --disable=gochecknoglobals --disable=gochecknoinits --disable=typecheck --disable=lll --enable=gosec --enable=prealloc")

;; neovim LSP
(let [lsp (require :nvim_lsp)
      completion (require :completion)
      diagnostic (require :diagnostic)
      on_attach (fn [client]
                  (completion.on_attach client)
                  (diagnostic.on_attach client))]
  (lsp.bashls.setup {:on_attach on_attach})
  (lsp.dockerls.setup {:on_attach on_attach})
  (lsp.fortls.setup {:on_attach on_attach})
  (lsp.gopls.setup {:on_attach on_attach})
  (lsp.jdtls.setup {:on_attach on_attach})
  (lsp.jsonls.setup {:on_attach on_attach})
  (lsp.kotlin_language_server.setup {:on_attach on_attach})
  (lsp.rls.setup {:on_attach on_attach})
  (lsp.rust_analyzer.setup {:on_attach on_attach})
  (lsp.tsserver.setup {:on_attach on_attach})
  (lsp.vimls.setup {:on_attach on_attach})
  (lsp.yamlls.setup {:on_attach on_attach}))

(nnoremap-silent "K" ":<C-u>lua vim.lsp.buf.hover()<CR>")
(nnoremap-silent "gd" ":<C-u>lua vim.lsp.buf.definition()<CR>")
(nnoremap-silent "gD" ":<C-u>lua vim.lsp.buf.implementation()<CR>")
(nnoremap-silent "gr" ":<C-u>lua vim.lsp.buf.references()<CR>")

(set nvim.g.diagnostic_enable_virtual_text 1)
(set nvim.g.diagnostic_trimmed_virtual_text 40)
(set nvim.g.diagnostic_insert_delay 1)

;; nvim-tree.lua
(set nvim.g.lua_tree_side :left)
(set nvim.g.lua_tree_width 30)
(set nvim.g.lua_tree_auto_close 1)
(set nvim.g.lua_tree_follow 1)
(set nvim.g.lua_tree_indent_markers 1)
(set nvim.g.lua_tree_icons {:default icontab.text
                            :symlink icontab.symlink
                            :git {:unstaged icontab.diff-modified
                                  :staged icontab.check
                                  :unmerged icontab.merge
                                  :renamed icontab.diff-renamed
                                  :untracked icontab.asterisk}
                            :folder {:default icontab.folder
                                     :open icontab.folder-open}})

(nnoremap-silent "<leader>t" ":<C-u>LuaTreeToggle<CR>")

;; fzf.vim
(nnoremap-silent ",ub"  ":<C-u>Buffers<CR>")
(nnoremap-silent ",uf"  ":<C-u>Files<CR>")
(nnoremap-silent ",ugf" ":<C-u>GFiles<CR>")
(nnoremap-silent ",u/"  ":<C-u>BLines<CR>")
(nnoremap-silent ",ur"  ":<C-u>History<CR>")
(nnoremap-silent ",uc"  ":<C-u>History:<CR>")
(nnoremap-silent ",us"  ":<C-u>History/<CR>")
(nnoremap-silent ",uh"  ":<C-u>Helptags<CR>")
(nnoremap-silent ",ut"  ":<C-u>Filetypes<CR>")
(nnoremap-silent ",ug"  ":call fzf#vim#grep(\"rg --column --line-number --no-heading --color=always --smart-case \".shellescape(input('Query: ')), 1, 0)<CR>")

(augroup init-fzf
         (autocmd :FileType :fzf "nnoremap <buffer><silent>q :<C-u>q<CR>"))

;; asterisk
(nvim.set_keymap "" "*" "<Plug>(asterisk-*)" {})
(nvim.set_keymap "" "#" "<Plug>(asterisk-#)" {})
(nvim.set_keymap "" "g*" "<Plug>(asterisk-g*)" {})
(nvim.set_keymap "" "g#" "<Plug>(asterisk-g#)" {})
(nvim.set_keymap "" "z*" "<Plug>(asterisk-z*)" {})
(nvim.set_keymap "" "gz*" "<Plug>(asterisk-gz*)" {})
(nvim.set_keymap "" "z#" "<Plug>(asterisk-z#)" {})
(nvim.set_keymap "" "gz#" "<Plug>(asterisk-gz#)" {})

;; incsearch
(nvim.set_keymap "" "<buffer>/" "<Plug>(incsearch-forward)" {})
(nvim.set_keymap "" "<buffer>?" "<Plug>(incsearch-backward)" {})
(nvim.set_keymap "" "<buffer>g/" "<Plug>(incsearch-stay)" {})

;; clever-f
(set nvim.g.clever_f_not_overwrites_standard_mappings 1)
(set nvim.g.clever_f_across_no_line 0)
(set nvim.g.clever_f_ignore_case 0)
(set nvim.g.clever_f_smart_case 0)
(set nvim.g.clever_f_use_migemo 0)
(set nvim.g.clever_f_fix_key_direction 0)
(set nvim.g.clever_f_show_prompt 0)
(set nvim.g.clever_f_chars_match_any_signs "")
(set nvim.g.clever_f_mark_cursor 1)
(set nvim.g.clever_f_mark_cursor_color "Cursor")
(set nvim.g.clever_f_hide_cursor_on_cmdline 1)
(set nvim.g.clever_f_timeout_ms 0)
(set nvim.g.clever_f_mark_char 1)
(set nvim.g.clever_f_mark_char_color "CleverFDefaultLabel")
(set nvim.g.clever_f_repeat_last_char_inputs ["\r"])
(nmap "f" "<Plug>(clever-f-f)")
(nmap "F" "<Plug>(clever-f-F)")
(nmap "t" "<Plug>(clever-f-t)")
(nmap "T" "<Plug>(clever-f-T)")
(nmap "<Space>" "<Plug>(clever-f-reset)")

;; quickhl
(nmap "<Space>m" "<Plug>(quickhl-manual-this)")
(xmap "<Space>m" "<Plug>(quickhl-manual-this)")
(nmap "<Space>M" "<Plug>(quickhl-manual-reset)")
(xmap "<Space>M" "<Plug>(quickhl-manual-reset)")

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

;; sexp
(set nvim.g.sexp_enable_insert_mode_mappings 0)
(set nvim.g.sexp_insert_after_wrap 0)
(set nvim.g.sexp_filetypes "clojure,scheme,lisp,fennel")
(nmap ">(" "<Plug>(sexp_emit_head_element)")
(nmap "<)" "<Plug>(sexp_emit_tail_element)")
(nmap "<(" "<Plug>(sexp_capture_prev_element)")
(nmap ">)" "<Plug>(sexp_capture_next_element)")

;; markdown
(set nvim.g.mkdp_open_to_the_world 1)
(set nvim.g.mkdp_open_ip "0.0.0.0")
(set nvim.g.mkdp_port "8000")
(defn mkdp-echo-url [url]
  (nvim.ex.echo (.. "'" url "'")))
(bridge :MkdpEchoURL :mkdp-echo-url)
(set nvim.g.mkdp_browserfunc "MkdpEchoURL")

;; iced
(set nvim.g.iced_enable_default_key_mappings true)

;; hy
(set nvim.g.hy_enable_conceal 0)
(set nvim.g.hy_conceal_fancy 0)

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

;; go
(augroup init-golang
         (autocmd :FileType :go "set noexpandtab")
         (autocmd :FileType :go "set shiftwidth=4")
         (autocmd :FileType :go "set tabstop=4")
         (autocmd :FileType :go "set softtabstop=4")
         (autocmd :FileType :go "compiler go")
         (autocmd :BufWritePre "*.go" ":call CocAction('runCommand', 'editor.action.organizeImport')"))


;; QuickFix
(augroup init-qf
         (autocmd :FileType :qf "nnoremap <buffer> j j")
         (autocmd :FileType :qf "nnoremap <buffer> k k")
         (autocmd :FileType :qf "nnoremap <buffer> 0 0")
         (autocmd :FileType :qf "nnoremap <buffer> $ $")
         (autocmd :FileType :qf "nnoremap <buffer> gj gj")
         (autocmd :FileType :qf "nnoremap <buffer> gk gk")
         (autocmd :FileType :qf "nnoremap <buffer> g0 g0")
         (autocmd :FileType :qf "nnoremap <buffer> g$ g$")
         (autocmd :FileType :qf "nnoremap <buffer><silent>q :<C-u>q<CR>")
         (autocmd :WinEnter :* "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif"))

;; Help
(augroup init-help
         (autocmd :FileType :help "nnoremap <buffer> j j")
         (autocmd :FileType :help "nnoremap <buffer> k k")
         (autocmd :FileType :help "nnoremap <buffer> 0 0")
         (autocmd :FileType :help "nnoremap <buffer> $ $")
         (autocmd :FileType :help "nnoremap <buffer> gj gj")
         (autocmd :FileType :help "nnoremap <buffer> gk gk")
         (autocmd :FileType :help "nnoremap <buffer> g0 g0")
         (autocmd :FileType :help "nnoremap <buffer> g$ g$")
         (autocmd :FileType :help "nnoremap <buffer><silent>q :<C-u>q<CR>")
         (autocmd :WinEnter :* "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'help' | q | endif"))

;; treesitter
(ts-cfg.setup
  {:ensure_installed [:bash
                      :c
                      :clojure
                      :cpp
                      :fennel
                      :go
                      :html
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

(set nvim.g.bufferline {:maximum_padding 6})

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
      (.. icontab.github " " g-status)
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
      :colorscheme :ayu_dark
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
                 :c icontab.chevron-r
                 :s "S"
                 :S "SL"
                 "" "SB"
                 :t icontab.terminal}})
