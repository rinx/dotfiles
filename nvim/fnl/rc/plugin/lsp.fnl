(module rc.plugin.lsp
  {autoload {core aniseed.core
             nvim aniseed.nvim
             color rc.color
             icon rc.icon
             util rc.util
             lsp lspconfig
             lsp-configs lspconfig/configs
             lsp-signature lsp_signature
             lsputil lspconfig/util}
   require-macros [rc.macros]})

(def- colors color.colors)
(def- icontab icon.tab)
(def- loaded? util.loaded?)

(defn- on-attach [client bufnr]
  (lsp-signature.on_attach
    {:bind true
     :doc_lines 10
     :hint_enabled true
     :hint_prefix (.. icontab.info " ")
     :hint_scheme :String
     :handler_opts
     {:border :single}
     :decorator {"`" "`"}}))

(def- capabilities
  (let [cap (vim.lsp.protocol.make_client_capabilities)]
    (set cap.textDocument.completion.completionItem.snippetSupport true)
    (set cap.textDocument.completion.completionItem.preselectSupport true)
    (set cap.textDocument.completion.completionItem.insertReplaceSupport true)
    (set cap.textDocument.completion.completionItem.deprecatedSupport true)
    (set cap.textDocument.completion.completionItem.commitCharactersSupport true)
    (set cap.textDocument.completion.completionItem.tagSupport
         {:valueSet [1]})
    (set cap.textDocument.completion.completionItem.resolveSupport
         {:properties
          [:documentation
           :detail
           :additionalTextEdits]})
    cap))

(def- default-options
  {:on_attach on-attach
   :capabilities capabilities})

(when (not lsp.hyls)
  (tset lsp-configs :hyls
        {:default_config
         {:cmd [:hyls]
          :filetypes [:hy]
          :root_dir lsputil.path.dirname}}))
(lsp.bashls.setup (core.merge default-options {}))
(lsp.clojure_lsp.setup (core.merge default-options {}))
(lsp.cssls.setup (core.merge default-options {}))
(lsp.denols.setup (core.merge default-options {:autostart false}))
(lsp.dockerls.setup (core.merge default-options {}))
(lsp.efm.setup (core.merge
                 default-options
                 {:filetypes [:markdown
                              :proto]
                  :init_options {:codeAction true
                                 :completion true
                                 :documentFormatting true
                                 :documentSymbol true
                                 :hover true}
                  :settings
                  {:languages
                   {:markdown
                    [{:lintCommand "textlint --format unix ${INPUT}"
                      :lintFormats ["%f:%l:%n: %m"]}
                     {:lintCommand "markdownlint -s -c %USERPROFILE%.markdownlintrc"
                      :lintStdin true
                      :lintFormats ["%f:%l %m"
                                    "%f:%l:%c %m"
                                    "%f: %l: %m"]}
                     {:hoverCommand :excitetranslate.clj
                      :hoverStdin true}]
                    :proto
                    [{:lintCommand "buf lint --path"}]}
                   :lintDebounce 3000000000}}))
(lsp.erlangls.setup (core.merge default-options {}))
(lsp.fortls.setup (core.merge default-options {}))
(lsp.gopls.setup (core.merge
                   default-options
                   {:settings
                    {:gopls
                     {:usePlaceholders true
                      :analyses {:fieldalignment true
                                 :fillstruct true
                                 :nilless true
                                 :shadow true
                                 :unusedwrite true}
                      :staticcheck true
                      :gofumpt true}}}))
(lsp.hls.setup (core.merge default-options {}))
(lsp.html.setup (core.merge default-options {}))
(lsp.hyls.setup (core.merge default-options {}))
(lsp.jsonls.setup (core.merge default-options {}))
(lsp.julials.setup (core.merge default-options {}))
(lsp.kotlin_language_server.setup (core.merge default-options {}))
(lsp.pylsp.setup (core.merge default-options {}))
(lsp.texlab.setup (core.merge default-options {:filetypes [:tex :bib :plaintex]}))
(lsp.tsserver.setup (core.merge default-options {:autostart false}))
(lsp.yamlls.setup (core.merge
                    default-options
                    {:settings
                     {:yaml
                      {:schemaStore {:enable true}}}}))
(lsp.zeta_note.setup (core.merge default-optsion {:cmd [:zeta-note]}))
;; rust-analyzer
(when (loaded? :rust-tools.nvim)
  (let [rust-tools (require :rust-tools)]
    (rust-tools.setup
      {:tools
       {:inlay_hints
        {:parameter_hints_prefix (.. " "
                                     icontab.slash
                                     icontab.arrow-l
                                     " ")
         :other_hints_prefix (.. " "
                                 icontab.arrow-r
                                 " ")}}
       :server
       {:on_attach on-attach
        :capabilities capabilities
        :settings {:rust-analyzer
                   {:cargo {:allFeatures true}
                    :lens {:enable true
                           :methodReferences true
                           :references true}}}}})))

(tset vim.lsp.handlers
      :textDocument/hover
      (vim.lsp.with vim.lsp.handlers.hover {:border :rounded}))
(tset vim.lsp.handlers
      :textDocument/signatureHelp
      (vim.lsp.with vim.lsp.handlers.signature_help {:border :rounded}))

(def- lsp-progress-msgs {})
(tset vim.lsp.handlers
      :$/progress
      (fn [_ msg ctx]
        (let [client-id ctx.client_id
              val msg.value]
          (when (not (core.get lsp-progress-msgs client-id))
            (tset lsp-progress-msgs client-id {}))
          (when (and val.kind (or val.message val.title))
            (match val.kind
              :begin (do
                       (tset (core.get lsp-progress-msgs client-id)
                             msg.token
                             {:title val.title
                              :message val.message
                              :percentage val.percentage
                              :done false})
                       (vim.notify
                         (or val.message val.title)
                         vim.lsp.log_levels.INFO
                         {:title (.. "LSP progress: " (or val.title ""))
                          :on_open (fn []
                                     (let [timer (vim.loop.new_timer)]
                                       (timer:start
                                         30000 0
                                         (fn []
                                           (tset (core.get-in
                                                   lsp-progress-msgs
                                                   [client-id msg.token])
                                                 :done
                                                 true)))))
                          :keep (fn []
                                  (not
                                    (core.get-in
                                      lsp-progress-msgs
                                      [client-id msg.token :done])))}))
              :report (let [m (core.get-in lsp-progress-msgs
                                           [client-id msg.token])]
                        ;; TODO: show these informations
                        (tset m :message val.message)
                        (tset m :percentage val.percentage))
              :end (if (core.get-in lsp-progress-msgs [client-id msg.token])
                     (let [m (core.get-in lsp-progress-msgs
                                          [client-id msg.token])]
                       (tset m :done true)
                       (vim.notify
                         (or val.message "")
                         vim.lsp.log_levels.INFO
                         {:title (.. "LSP progress done: " (or m.title ""))}))
                     (vim.notify
                       (.. "Received `end` messages with "
                           "no corresponding `begin` from client-id: "
                           client-id "!")
                       vim.lsp.log_levels.ERROR
                       {:title "LSP progress"}))
              _ nil)))))

(noremap! [:n] :K ":<C-u>lua vim.lsp.buf.hover()<CR>" :silent)
(noremap! [:n] :gd ":<C-u>lua vim.lsp.buf.definition()<CR>" :silent)
(noremap! [:n] :gD ":<C-u>lua vim.lsp.buf.declaration()<CR>" :silent)
(noremap! [:n] :gi ":<C-u>lua vim.lsp.buf.implementation()<CR>" :silent)
(noremap! [:n] :gr ":<C-u>lua vim.lsp.buf.references()<CR>" :silent)
(noremap! [:n] :gs ":<C-u>lua vim.lsp.buf.signature_help()<CR>" :silent)

(noremap! [:n] :<leader>f ":<C-u>lua vim.lsp.buf.formatting()<CR>" :silent)
(noremap! [:x] :<leader>f ":<C-u>lua vim.lsp.buf.range_formatting()<CR>" :silent)

(noremap! [:n] :<leader>l ":<C-u>lua vim.lsp.codelens.run()<CR>" :silent)
(augroup! init-lsp-codelens
          (autocmd! "CursorHold,CursorHoldI"
                    "*"
                    "lua vim.lsp.codelens.refresh()"))

;; lspsaga
(if (loaded? :lspsaga.nvim)
  (do
    (let [saga (require :lspsaga)]
      (saga.init_lsp_saga
        {:error_sign icontab.bug
         :warn_sign icontab.exclam-circle
         :infor_sign icontab.info-circle
         :hint_sign icontab.leaf
         :dianostic_header_icon (.. icontab.search " ")
         :code_action_icon (.. icontab.lightbulb " ")
         :code_action_prompt {:enable true
                              :sign false
                              :sign_priority 20
                              :virtual_text false}
         :finder_definition_icon (.. icontab.star-alt " ")
         :finder_reference_icon (.. icontab.star-alt " ")
         :max_preview_lines 12
         :finder_action_keys {:open :o
                              :vsplit :v
                              :split :s
                              :quit :q
                              :scroll_down "<C-f>"
                              :scroll_up "<C-b>"}
         :code_action_keys {:quit :q :exec "<CR>"}
         :rename_action_keys {:quit "<C-c>" :exec "<CR>"}
         :definition_preview_icon (.. icontab.compas " ")
         :border_style :round
         :rename_prompt_prefix icontab.chevron-r}))
    (noremap! [:n] :gh ":<C-u>Lspsaga lsp_finder<CR>" :silent)
    (noremap! [:n] "<leader>rn" ":<C-u>Lspsaga rename<CR>" :silent)
    (noremap! [:n] "<Leader>a" ":<C-u>Lspsaga code_action<CR>" :silent)
    (noremap! [:x] "<Leader>a" ":<C-u>Lspsaga range_code_action<CR>" :silent)
    (noremap! [:n] "<Leader>d" ":<C-u>Lspsaga show_line_diagnostics<CR>" :silent)
    (noremap! [:n] "[d" ":<C-u>Lspsaga diagnostic_jump_prev<CR>" :silent)
    (noremap! [:n] "]d" ":<C-u>Lspsaga diagnostic_jump_next<CR>" :silent))
  (do
    (noremap! [:n] "<leader>rn" ":<C-u>lua vim.lsp.buf.rename()<CR>" :silent)
    (noremap! [:n] "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>" :silent)
    (noremap! [:x] "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>" :silent)
    (noremap! [:n] "<Leader>d" ":<C-u>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" :silent)
    (noremap! [:n] "[d" ":<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>" :silent)
    (noremap! [:n] "]d" ":<C-u>lua vim.lsp.diagnostic.goto_next()<CR>" :silent)))

(set nvim.g.diagnostic_enable_virtual_text 1)
(set nvim.g.diagnostic_trimmed_virtual_text 40)
(set nvim.g.diagnostic_show_sign 1)
(set nvim.g.diagnostic_insert_delay 1)

(nvim.fn.sign_define :LspDiagnosticsSignError
                     {:text icontab.bug
                      :texthl :LspDiagnosticsSignError})
(nvim.fn.sign_define :LspDiagnosticsSignWarning
                     {:text icontab.exclam-circle
                      :texthl :LspDiagnosticsSignWarning})
(nvim.fn.sign_define :LspDiagnosticsSignInformation
                     {:text icontab.info-circle
                      :texthl :LspDiagnosticsSignInformation})
(nvim.fn.sign_define :LspDiagnosticsSignHint
                     {:text icontab.leaf
                      :texthl :LspDiagnosticsSignHint})

;; trouble.nvim
(when (loaded? :trouble.nvim)
  (let [trouble (require :trouble)]
    (trouble.setup {:auto_open true
                    :auto_close true
                    :use_lsp_diagnostic_signs true})
    (noremap! [:n] "<leader>xx" ":<C-u>TroubleToggle<CR>" :silent)
    (noremap! [:n] "<leader>xw" ":<C-u>TroubleToggle lsp_workspace_diagnostics<CR>" :silent)
    (noremap! [:n] "<leader>xd" ":<C-u>TroubleToggle lsp_document_diagnostics<CR>" :silent)
    (noremap! [:n] "<leader>xq" ":<C-u>TroubleToggle quickfix<CR>" :silent)
    (noremap! [:n] "<leader>xl" ":<C-u>TroubleToggle loclist<CR>" :silent)
    (noremap! [:n] "gR" ":<C-u>TroubleToggle lsp_references<CR>" :silent)))

;; lsp-colors.nvim
(when (loaded? :lsp-colors.nvim)
  (let [colors (require :lsp-colors)]
    (colors.setup {:Error colors.error
                   :Warning colors.warn
                   :Information colors.info
                   :Hint colors.hint})))

(when (loaded? :todo-comments.nvim)
  (let [tdc (require :todo-comments)]
    (tdc.setup {:signs true
                :keywords {:FIX {:icon icontab.bug
                                 :color :error
                                 :alt [:FIXME :BUG :FIXIT :FIX :ISSUE]}
                           :TODO {:icon icontab.check
                                  :color :info}
                           :HACK {:icon icontab.fire
                                  :color :warning}
                           :WARN {:icon icontab.excram-tri
                                  :color :warning}
                           :PERF {:icon icontab.watch
                                  :color :default
                                  :alt [:OPTIM :PERFORMANCE :OPTIMIZE]}
                           :NOTE {:icon icontab.comment-alt
                                  :color :hint
                                  :alt [:INFO]}}
                :colors {:error [:LspDiagnosticsSignError]
                         :warning [:LspDiagnosticsSignWarning]
                         :info [:LspDiagnosticsSignInformation]
                         :hint [:LspDiagnosticsSignHint]
                         :default [colors.purple]}})))

;; symbols-outline
(when (loaded? :symbols-outline.nvim)
  (set nvim.g.symbols_outline {:highlight_hovered_item true
                               :show_guides true
                               :auto_preview true
                               :position :right
                               :keymaps {:close :<Esc>
                                         :goto_location :<CR>
                                         :focus_location :o
                                         :hover_symbol :<Space>
                                         :rename_symbol :r
                                         :code_actions :a}
                               :lsp_blacklist {}})
  (noremap! [:n] :<leader>o ":<C-u>SymbolsOutline<CR>" :silent))

;; lightbulb
(when (loaded? :nvim-lightbulb)
  (augroup! init-lightbulb
            (autocmd! "CursorHold,CursorHoldI"
                      "*"
                      "lua require'nvim-lightbulb'.update_lightbulb()"))
  (nvim.fn.sign_define :LightBulbSign
                       {:text icontab.lightbulb
                        :texthl :LspDiagnosticsSignLightBulb}))
