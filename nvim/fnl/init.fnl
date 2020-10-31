(module init
  {require {core aniseed.core
            nvim aniseed.nvim
            util aniseed.nvim.util
            icon util.icon
            ts-cfg nvim-treesitter.configs
            devicon nvim-web-devicons}
   require-macros [util.macros]})

(defn- bridge [from to]
  (util.fn-bridge from :init to {:return true}))

(local icontab icon.tab)

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
     {:colorscheme :seoul256
      :active {:left [[:mode :paste :spell]
                      [:filename :gitstatus :cocstatus]]
               :right [[:lineinfo]
                       [:percent]
                       [:fileformat :fileencoding :filetype]]}
      :component_function {:filename :LightlineFilename
                           :lineinfo :LightlineLineinfo
                           :gitstatus :LightlineGitstatus
                           :cocstatus :coc#status
                           :alewarnings :LightlineALEWarnings}
      :inactive {:left [[:filename]]
                 :right [[:filetype]]}
      :tabline {:left [[:tabs]]
                :right [[] [:alewarnings]]}
      :separator {:left icontab.pix-l
                  :right icontab.pix-r}
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
