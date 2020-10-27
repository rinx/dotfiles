(module init
  {require {core aniseed.core
            nvim aniseed.nvim
            util aniseed.nvim.util
            ts-cfg nvim-treesitter.configs}})

(defn- bridge [from to]
  (util.fn-bridge from :init to {:return true}))

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
(defn lightline-modified []
  (match nvim.bo.ft
    :help ""
    :qf ""
    _ (if nvim.bo.modified
        "+"
        (if nvim.bo.modifiable
          ""
          "-"))))
(bridge :LightlineModified :lightline-modified)

(defn lightline-readonly []
  (match nvim.bo.ft
    :help "RO"
    :qf "RO"
    _ nvim.bo.ro))
(bridge :LightlineReadonly :lightline-readonly)

(defn lightline-filename []
  (nvim.fn.expand "%"))
(bridge :LightlineFilename :lightline-filename)

(defn lightline-gitstatus []
  (nvim.fn.substitute nvim.g.coc_git_status " " "" "g"))
(bridge :LightlineGitstatus :lightline-gitstatus)

(set nvim.g.lightline
     {:colorscheme :seoul256
      :active {:left [[:mode :paste :spell]
                      [:filename :gitstatus :cocstatus]]
               :right [[:lineinfo]
                       [:percent]
                       [:fileformat :fileencoding :filetype]]}
      :component_function {:modified :LightlineModified
                           :readonly :LightlineReadonly
                           :filename :LightlineFilename
                           :gitstatus :LightlineGitstatus
                           :cocstatus :coc#status}
      :inactive {:left [[:filename]]
                 :right [[:lineinfo]]}
      :tabline {:left [[:tabs]]}})
