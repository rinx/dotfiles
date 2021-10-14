(module rc.plugin.feline
  {autoload {core aniseed.core
             nvim aniseed.nvim
             color rc.color
             icon rc.icon
             util rc.util
             feline feline
             vimode-providers feline.providers.vi_mode
             lsp-providers feline.providers.lsp}})

(def- colors color.colors)
(def- icontab icon.tab)
(def- loaded? util.loaded?)

(def- space " ")
(def- fill "▊")

(def- vi-mode-colors
  {:NORMAL colors.info
   :INSERT colors.error
   :VISUAL colors.color8
   :OP colors.info
   :BLOCK colors.hint
   :REPLACE colors.purple
   [:V-REPLACE] colors.purple
   :ENTER colors.color10
   :MORE colors.color10
   :SELECT colors.warn
   :COMMAND colors.info
   :SHELL colors.info
   :TERM colors.info
   :NONE colors.color3})

(def- lsp-icons
  {:error icontab.bug
   :warn icontab.exclam-circle
   :info icontab.info-circle
   :hint icontab.leaf})

(defn- vimode-hl []
  {:name (vimode-providers.get_mode_highlight_name)
   :fg (vimode-providers.get_mode_color)})

(defn- lsp-diagnostics-info []
  {:error (lsp-providers.get_diagnostics_count :Error)
   :warn (lsp-providers.get_diagnostics_count :Warning)
   :info (lsp-providers.get_diagnostics_count :Information)
   :hint (lsp-providers.get_diagnostics_count :Hint)})

(defn- diagnostics-enable [f s]
  (fn []
    (let [diag (core.get (f) s)]
      (and diag (~= diag 0)))))

(defn- diagnostics-of [f s]
  (fn []
    (let [diag (core.get (f) s)
          ic (core.get lsp-icons s)]
      (.. ic diag))))

(def- comps
  {:vimode {:provider fill
            :hl vimode-hl
            :right_sep space}
   :paste {:provider icontab.paste
           :enabled (fn [] vim.o.paste)
           :left_sep space
           :hl {:fg colors.hint}}
   :spell {:provider (.. icontab.spellcheck vim.o.spelllang)
           :enabled (fn [] vim.wo.spell)
           :left_sep space
           :hl {:fg colors.hint}}
   :file {:info {:provider :file_info
                 :hl {:fg colors.hint
                      :style :bold}}
          :encoding {:provider :file_encoding
                     :left_sep space
                     :hl {:fg colors.purple
                          :style :bold}}
          :type {:provider :file_type
                 :left_sep space
                 :hl {:fg colors.hint
                      :style :bold}}}
   :scrollbar {:provider :scroll_bar
               :left_sep space
               :hl {:fg colors.hint
                    :style :bold}}
   :diagnostics {:error {:provider (diagnostics-of
                                     lsp-diagnostics-info
                                     :error)
                         :left_sep space
                         :enabled (diagnostics-enable
                                    lsp-diagnostics-info
                                    :error)
                         :hl {:fg colors.error}}
                 :warn {:provider (diagnostics-of
                                    lsp-diagnostics-info
                                    :warn)
                        :left_sep space
                        :enabled (diagnostics-enable
                                   lsp-diagnostics-info
                                   :warn)
                        :hl {:fg colors.warn}}
                 :info {:provider (diagnostics-of
                                    lsp-diagnostics-info
                                    :info)
                        :left_sep space
                        :enabled (diagnostics-enable
                                   lsp-diagnostics-info
                                   :info)
                        :hl {:fg colors.info}}
                 :hint {:provider (diagnostics-of
                                    lsp-diagnostics-info
                                    :hint)
                        :left_sep space
                        :enabled (diagnostics-enable
                                   lsp-diagnostics-info
                                   :hint)
                        :hl {:fg colors.hint}}}
   :lsp {:provider :lsp_client_names
         :left_sep space
         :icon icontab.server
         :hl {:fg colors.color13}}
   :dap {:provider :dap_status
         :enabled (fn [] (loaded? :nvim-dap))
         :left_sep space
         :hl {:fg colors.color4}
         :icon icontab.play-circle}
   :denops {:provider :denops_status
            :enabled (fn []
                       (loaded? :denops.vim))
            :left_sep space
            :hl {:fg colors.purple}}
   :skkeleton {:provider :skkeleton_status
               :enabled (fn []
                          (and
                            (loaded? :skkeleton)
                            (vim.fn.skkeleton#is_enabled)))
               :left_sep space
               :hl {:fg colors.color10}
               :icon icontab.cursor-text}
   :git {:branch {:provider :git_branch
                  :icon icontab.github
                  :left_sep space
                  :hl {:fg colors.purple
                       :style :bold}}
         :add {:provider :git_diff_added
               :hl {:fg colors.info}
               :icon icontab.diff-add
               :left_sep space}
         :change {:provider :git_diff_changed
                  :hl {:fg colors.warn}
                  :icon icontab.diff-modified
                  :left_sep space}
         :remove {:provider :git_diff_removed
                  :hl {:fg colors.error}
                  :icon icontab.diff-removed
                  :left_sep space}}})

(def- force-inactive
  {:filetypes [:^Trouble$
               :^qf$
               :^help$
               :^dap-repl$
               :^dapui_watches$
               :^dapui_stacks$
               :^dapui_breakpoints$
               :^dapui_scopes$
               :^packer$
               :^NvimTree$
               :^Outline$]
   :buftypes [:^terminal$]
   :bufnames []})

(def- components
  {:active [[comps.vimode
             comps.file.info
             comps.lsp
             comps.diagnostics.error
             comps.diagnostics.warn
             comps.diagnostics.info
             comps.diagnostics.hint]
            [comps.dap
             comps.skkeleton]
            [comps.git.add
             comps.git.change
             comps.git.remove
             comps.git.branch
             comps.file.encoding
             comps.denops
             comps.paste
             comps.spell
             comps.scrollbar]]
   :inactive [[comps.file.info]
              []
              []]})

(def- providers
  {:dap_status (fn []
                (let [dap (require :dap)]
                  (or (dap.status) "")))
   :skkeleton_status (fn []
                       (match (vim.fn.skkeleton#mode)
                         :hira "あ"
                         :kata "ア"
                         :hankata "ｧｱ"
                         :ascii "aA"
                         :zenei "ａ"
                         :abbrev "aあ"
                         _ ""))
   :denops_status (fn []
                    (match (vim.fn.denops#server#status)
                      :running icontab.dinosaur
                      _ ""))})

;; enforce to set &termguicolors
(nvim.ex.set :termguicolors)

(feline.setup
  {:default_bg colors.color2
   :default_fg colors.color4
   :components components
   :custom_providers providers
   :vi_mode_colors vi-mode-colors
   :force_inactive force-inactive})
