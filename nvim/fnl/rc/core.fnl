(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local icon (autoload :rc.icon))

;; basics
(set vim.o.viminfo "'1000,<100,f1,h,s100")
(set vim.o.history 300)
(set vim.o.bs "indent,eol,start")

(set vim.o.ruler true)
(set vim.o.number true)
(set vim.o.cmdheight 2)
(set vim.o.wildmenu true)
(set vim.o.wildchar 9) ;; 9 = <Tab>
(set vim.o.wildmode "longest:full,full")

(set vim.o.shortmess "filnxtToOFc")
(set vim.opt.completeopt [:menu :menuone :noselect])

;; (set vim.o.imdisable true)

(set vim.o.ignorecase true)
(set vim.o.smartcase true)

(set vim.o.smartindent true)
(set vim.o.breakindent true)

(set vim.o.confirm true)

(set vim.o.clipboard "unnamed,unnamedplus")

(set vim.o.mouse "a")

(set vim.o.foldmethod :marker)
(set vim.o.foldlevel 99)

(set vim.o.virtualedit "block")

(set vim.o.expandtab true)
(set vim.o.smarttab true)
(set vim.o.tabstop 8)
(set vim.o.shiftwidth 4)
(set vim.o.softtabstop 4)

(if (= (vim.fn.exists "&pumblend") 1)
  (set vim.o.pumblend 30))
(if (= (vim.fn.exists "&winblend") 1)
  (set vim.o.winblend 30))

(set vim.o.visualbell true)
(set vim.o.lazyredraw true)
(set vim.o.ttyfast true)

(set vim.o.showmatch true)
(set vim.o.matchtime 3)

(set vim.o.backup false)
(set vim.o.writebackup false)

(set vim.o.updatetime 300)
(set vim.o.timeoutlen 500)

(set vim.wo.signcolumn :number)

(set vim.o.undofile true)
(set vim.o.undolevels 1000)
(set vim.o.undoreload 10000)

(let [backupdir (vim.fn.expand "~/.config/nvim/tmp/backup")
      undodir (vim.fn.expand "~/.config/nvim/tmp/undo")
      swapdir (vim.fn.expand "~/.config/nvim/tmp/swap")]
  (set vim.o.backupdir backupdir)
  (set vim.o.undodir undodir)
  (set vim.o.directory swapdir)

  (when (not (= (vim.fn.isdirectory backupdir) 1))
    (vim.fn.mkdir backupdir :p))
  (when (not (= (vim.fn.isdirectory undodir) 1))
    (vim.fn.mkdir undodir :p))
  (when (not (= (vim.fn.isdirectory swapdir) 1))
    (vim.fn.mkdir swapdir :p)))

(set vim.o.list true)
(set vim.opt.listchars
     {:eol icon.tab.subdirectory-arrow-left
      :extends icon.tab.extends
      :nbsp icon.tab.nbsp
      :precedes icon.tab.precedes
      :tab icon.tab.keyboard-tab
      :trail icon.tab.trail})

(set vim.o.autochdir false)
(set vim.o.autoread true)
(set vim.o.autowrite false)

(set vim.o.exrc false)
(set vim.o.secure false)

(set vim.o.timeout true)
(set vim.o.timeoutlen 1000)
(set vim.o.ttimeoutlen 200)

(set vim.o.hidden true)

(set vim.o.laststatus 3)
(set vim.o.showtabline 2)

(set vim.o.termguicolors true)
(vim.cmd "syntax on")
(vim.cmd "filetype off")
(vim.cmd "filetype plugin indent on")
(vim.cmd "language en_US.utf-8")

(set vim.o.modeline true)

;; grep
(if (= (vim.fn.executable :rg) 1)
  (do
    (set vim.o.grepprg "rg --vimgrep --no-heading")
    (set vim.o.grepformat "%f:%l:%c:%m,%f:%l:%m")
    (set vim.g.ackprg "rg --vimgrep --no-heading")))

;; guis
(let [fonts ["MonaspaceRn NFM"
             "FiraCode Nerd Font"
             "Moralerspace Radon NF"
             "Noto Color Emoji"]
      size (if (= (vim.fn.has :mac) 1)
             "h14"
             "h12")
      guifonts (-> (core.map (fn [font]
                               (.. font ":" size)) fonts)
                   (table.concat ","))]
  (set vim.o.guifont guifonts))

;; neovide
(when vim.g.neovide
  (set vim.g.neovide_floating_blur 0)
  (set vim.g.neovide_transparency 0.8)
  (set vim.g.neovide_cursor_animation_length 0.1)
  (set vim.g.neovide_cursor_trail_size 0.01)
  (set vim.g.neovide_cursor_vfx_mode :ripple)
  (set vim.g.neovide_refresh_rate 60)
  (set vim.g.neovide_refresh_rate_idle 5)
  (set vim.g.neovide_underline_automatic_scaling true))

(set vim.g.denops#server#deno_args [:-q :--no-lock :-A :--unstable-kv])
