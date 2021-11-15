(module rc.core
  {autoload {core aniseed.core
             nvim aniseed.nvim
             color rc.color
             icon rc.icon
             util rc.util}})

(def- icontab icon.tab)

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
(set vim.opt.completeopt [:menu :menuone :noselect])

(nvim.ex.set :imdisable)

(nvim.ex.set :ignorecase)
(nvim.ex.set :smartcase)

(nvim.ex.set :smartindent)
(nvim.ex.set :breakindent)

(nvim.ex.set :confirm)

(set nvim.o.clipboard "unnamed,unnamedplus")

(set nvim.o.mouse "a")

(set nvim.o.foldmethod :marker)
(set nvim.o.foldlevel 99)

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

  (when (not (= (nvim.fn.isdirectory backupdir) 1))
    (nvim.fn.mkdir backupdir :p))
  (when (not (= (nvim.fn.isdirectory undodir) 1))
    (nvim.fn.mkdir undodir :p))
  (when (not (= (nvim.fn.isdirectory swapdir) 1))
    (nvim.fn.mkdir swapdir :p)))

(nvim.ex.set :list)
(set vim.opt.listchars
     {:eol icontab.subdirectory-arrow-left
      :extends icontab.extends
      :nbsp icontab.nbsp
      :precedes icontab.precedes
      :tab icontab.keyboard-tab
      :trail icontab.trail})

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

(nvim.ex.set :termguicolors)
(nvim.ex.syntax :on)
(nvim.ex.filetype :off)
(nvim.ex.filetype "plugin indent on")

(nvim.ex.set :modeline)

;; grep
(if (= (nvim.fn.executable :rg) 1)
  (do
    (set nvim.o.grepprg "rg --vimgrep --no-heading")
    (set nvim.o.grepformat "%f:%l:%c:%m,%f:%l:%m")
    (set nvim.g.ackprg "rg --vimgrep --no-heading")))

;; guis
(let [fonts ["FiraCode Nerd Font"
             "JetBrainsMono Nerd Font"
             "HackGenNerd"
             "Noto Color Emoji"]
      size (if (= (nvim.fn.has :mac) 1)
             "h14"
             "h12")]
  (-> (core.map (fn [font]
                  (.. font ":" size)) fonts)
    (table.concat ",")
    (->> (set nvim.o.guifont))))

;; nvui
(when (= nvim.g.nvui 1)
  (nvim.fn.rpcnotify 1 :NVUI_WINOPACITY 0.80)
  (nvim.fn.rpcnotify 1 :NVUI_FRAMELESS false)

  (nvim.fn.rpcnotify 1 :NVUI_TITLEBAR_FONT_FAMILY "JetBrainsMono Nerd Font")
  (nvim.fn.rpcnotify 1 :NVUI_TITLEBAR_FONT_SIZE 10)

  (nvim.fn.rpcnotify 1 :NVUI_IME_SET false)

  (nvim.fn.rpcnotify 1 :NVUI_CARET_EXTEND_TOP 5)
  (nvim.fn.rpcnotify 1 :NVUI_CARET_EXTEND_BOTTOM 5))
