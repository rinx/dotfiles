(module init
  {require {core aniseed.core
            nvim aniseed.nvim
            util aniseed.nvim.util
            ts-cfg nvim-treesitter.configs
            icon nvim-web-devicons}})

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

(local icon-table {:lock ""
                   :plus ""
                   :minus ""
                   :branch ""
                   :ln ""
                   :cn ""
                   :zap ""
                   :info ""
                   :exclam ""
                   :times ""
                   :check ""
                   :check-circle ""
                   :check-square ""
                   :comment ""
                   :github ""
                   :quote-l ""
                   :quote-r ""
                   :tri-l ""
                   :tri-r ""
                   :ltri-l ""
                   :ltri-r ""
                   :utri-l ""
                   :utri-r ""
                   :pix-l ""
                   :pix-r ""})
(defn get-icon [name]
  (. icon-table name))

;; lightline
(defn lightline-filename []
  (let [filename (nvim.fn.expand "%")
        filename (if (= filename "")
                   "No Name"
                   filename)
        extension (nvim.fn.expand "%:e")
        icon (match nvim.bo.ft
               :help (get-icon :lock)
               :qf (get-icon :lock)
               _ (if nvim.bo.ro
                   (get-icon :lock)
                   (icon.get_icon filename extension {:default true})))
        modified (match nvim.bo.ft
                   :help ""
                   :qf ""
                   _ (if nvim.bo.modified
                       (.. " " (get-icon :plus))
                       (if nvim.bo.modifiable
                         ""
                         (.. " " (get-icon :minus)))))]
    (.. icon " " filename modified)))
(bridge :LightlineFilename :lightline-filename)

(defn lightline-lineinfo []
  (let [row (nvim.fn.line ".")
        col (nvim.fn.col ".")]
    (.. (get-icon :ln) row " " (get-icon :cn) col)))
(bridge :LightlineLineinfo :lightline-lineinfo)

(defn lightline-gitstatus []
  (let [g-status (. nvim.g :coc_git_status)]
    (if (and g-status (not (= g-status "")))
      (.. (get-icon :branch) " " g-status)
      "")))
(bridge :LightlineGitstatus :lightline-gitstatus)

(defn lightline-coc-diagnostic []
  (let [info (. nvim.b :coc_diagnostic_info)]
    (if (and info (not (= info "")))
      (let [warn (or (. info :warning) 0)
            err (or (. info :error) 0)]
        (.. (get-icon :times) err) " " (get-icon :exclam) warn)
      "")))
(bridge :LightlineCocDiagnostic :lightline-coc-diagnostic)

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
                           :cocdiagnostic :LightlineCocDiagnostic}
      :inactive {:left [[:filename]]
                 :right [[:filetype]]}
      :tabline {:left [[:tabs]]
                :right [[:cocdiagnostic]]}
      :separator {:left (get-icon :pix-l)
                  :right (get-icon :pix-r)}})
