(module rc.plugin.lsp
  {autoload {nvim aniseed.nvim
             color rc.color
             icon rc.icon
             util rc.util
             lsp lspconfig
             lsp-configs lspconfig/configs
             lsp-signature lsp_signature
             lsp-status lsp-status
             lsputil lspconfig/util}
   require-macros [rc.macros]})

(def- colors color.colors)
(def- icontab icon.tab)
(def- loaded? util.loaded?)

(def- nnoremap-silent util.nnoremap-silent)
(def- xnoremap-silent util.xnoremap-silent)

(defn- on-attach [client bufnr]
  (lsp-status.on_attach client)
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

(lsp-status.register_progress)
(lsp-status.config
  {:status_symbol (.. icontab.code-braces " ")
   :indicator_errors icontab.ban
   :indicator_warnings icontab.exclam-tri
   :indicator_info icontab.info-circle
   :indicator_hint icontab.leaf
   :indicator_ok icontab.check
   :current_function false})

(when (not lsp.hyls)
  (tset lsp-configs :hyls
        {:default_config
         {:cmd [:hyls]
          :filetypes [:hy]
          :root_dir lsputil.path.dirname}}))
(lsp.bashls.setup {:on_attach on-attach
                   :capabilities capabilities})
(lsp.clojure_lsp.setup {:on_attach on-attach
                        :capabilities capabilities})
(lsp.cssls.setup {:on_attach on-attach
                  :capabilities capabilities})
(lsp.dockerls.setup {:on_attach on-attach
                     :capabilities capabilities})
(lsp.efm.setup {:on_attach on-attach
                :capabilities capabilities
                :filetypes [:markdown
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
                 :lintDebounce 3000000000}})
(lsp.fortls.setup {:on_attach on-attach
                   :capabilities capabilities})
(lsp.gopls.setup {:on_attach on-attach
                  :capabilities capabilities
                  :settings {:gopls
                             {:usePlaceholders true
                              :analyses {:fieldalignment true
                                         :fillstruct true
                                         :nilless true
                                         :shadow true
                                         :unusedwrite true}
                              :staticcheck true
                              :gofumpt true}}})
(lsp.hls.setup {:on_attach on-attach
                :capabilities capabilities})
(lsp.html.setup {:on_attach on-attach
                 :capabilities capabilities})
(lsp.hyls.setup {:on_attach on-attach
                 :capabilities capabilities})
(lsp.jsonls.setup {:on_attach on-attach
                   :capabilities capabilities})
(lsp.julials.setup {:on_attach on-attach
                    :capabilities capabilities})
(lsp.kotlin_language_server.setup {:on_attach on-attach
                                   :capabilities capabilities})
(lsp.pylsp.setup {:on_attach on-attach
                 :capabilities capabilities})
(lsp.tsserver.setup {:on_attach on-attach
                     :capabilities capabilities})
(lsp.yamlls.setup {:on_attach on-attach
                   :capabilities capabilities
                   :settings {:yaml
                              {:schemaStore {:enable true}}}})
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

(nnoremap-silent :K ":<C-u>lua vim.lsp.buf.hover()<CR>")
(nnoremap-silent :gd ":<C-u>lua vim.lsp.buf.definition()<CR>")
(nnoremap-silent :gD ":<C-u>lua vim.lsp.buf.declaration()<CR>")
(nnoremap-silent :gi ":<C-u>lua vim.lsp.buf.implementation()<CR>")
(nnoremap-silent :gr ":<C-u>lua vim.lsp.buf.references()<CR>")

(nnoremap-silent :<leader>f ":<C-u>lua vim.lsp.buf.formatting()<CR>")
(xnoremap-silent :<leader>f ":<C-u>lua vim.lsp.buf.range_formatting()<CR>")

(nnoremap-silent :<leader>l ":<C-u>lua vim.lsp.codelens.run()<CR>")
(augroup init-lsp-codelens
         (autocmd "CursorHold,CursorHoldI"
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
    (nnoremap-silent :gh ":<C-u>Lspsaga lsp_finder<CR>")
    (nnoremap-silent :gs ":<C-u>Lspsaga signature_help<CR>")
    (nnoremap-silent "<leader>rn" ":<C-u>Lspsaga rename<CR>")
    (nnoremap-silent "<Leader>a" ":<C-u>Lspsaga code_action<CR>")
    (xnoremap-silent "<Leader>a" ":<C-u>Lspsaga range_code_action<CR>")
    (nnoremap-silent "<Leader>d" ":<C-u>Lspsaga show_line_diagnostics<CR>")
    (nnoremap-silent "[d" ":<C-u>Lspsaga diagnostic_jump_prev<CR>")
    (nnoremap-silent "]d" ":<C-u>Lspsaga diagnostic_jump_next<CR>"))
  (do
    (nnoremap-silent "<leader>rn" ":<C-u>lua vim.lsp.buf.rename()<CR>")
    (nnoremap-silent "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>")
    (xnoremap-silent "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>")
    (nnoremap-silent "<Leader>d" ":<C-u>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    (nnoremap-silent "[d" ":<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>")
    (nnoremap-silent "]d" ":<C-u>lua vim.lsp.diagnostic.goto_next()<CR>")))

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
    (nnoremap-silent "<leader>xx" ":<C-u>TroubleToggle<CR>")
    (nnoremap-silent "<leader>xw" ":<C-u>TroubleToggle lsp_workspace_diagnostics<CR>")
    (nnoremap-silent "<leader>xd" ":<C-u>TroubleToggle lsp_document_diagnostics<CR>")
    (nnoremap-silent "<leader>xq" ":<C-u>TroubleToggle quickfix<CR>")
    (nnoremap-silent "<leader>xl" ":<C-u>TroubleToggle loclist<CR>")
    (nnoremap-silent "gR" ":<C-u>TroubleToggle lsp_references<CR>")))

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
  (nnoremap-silent :<leader>o ":<C-u>SymbolsOutline<CR>"))

;; lightbulb
(when (loaded? :nvim-lightbulb)
  (augroup init-lightbulb
           (autocmd "CursorHold,CursorHoldI"
                    "*"
                    "lua require'nvim-lightbulb'.update_lightbulb()"))
  (nvim.fn.sign_define :LightBulbSign
                       {:text icontab.lightbulb
                        :texthl :LspDiagnosticsSignLightBulb}))
