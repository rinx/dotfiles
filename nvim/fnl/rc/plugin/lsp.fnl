(module rc.plugin.lsp
  {autoload {core aniseed.core
             nvim aniseed.nvim
             color rc.color
             icon rc.icon
             util rc.util
             lsp lspconfig
             lsp-configs lspconfig/configs
             lsp-signature lsp_signature
             lsp-lines lsp_lines
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
    (set cap.textDocument.completion.completionItem.labelDetailsSupport true)
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

(lsp.bashls.setup (core.merge default-options {}))
(lsp.bufls.setup (core.merge default-options {}))
(lsp.clojure_lsp.setup (core.merge default-options {}))
(lsp.cssls.setup (core.merge default-options {}))
(lsp.dagger.setup (core.merge default-options {}))
(lsp.denols.setup (core.merge
                    default-options
                    {:init_options {:lint true
                                    :unstable true
                                    :suggest
                                    {:imports
                                     {:hosts
                                      {"https://deno.land" true
                                       "https://cdn.nest.land" true
                                       "https://crux.land" true}}}}
                     :root_dir (lsputil.root_pattern "deno.json")}))
(lsp.dockerls.setup (core.merge default-options {}))
(lsp.efm.setup (core.merge
                 default-options
                 {:filetypes [:markdown
                              :proto
                              :vcl]
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
                    [{:lintCommand "buf lint --path"}]
                    :vcl
                    [{:lintCommand "falco -vv lint ${INPUT} 2>&1"
                      :lintIgnoreExitCode true
                      :lintFormats ["%E💥 %m"
                                    "%E🔥 [ERROR] %m"
                                    "%W❗️ [WARNING] %m"
                                    "%I🔈 [INFO] %m"
                                    "%Zin %f at line %l, position %c"
                                    "%-G%.%#"]}]}
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
(lsp.jsonls.setup
  (core.merge
    default-options
    (if (loaded? :schemastore.nvim)
      (let [schemastore (require :schemastore)]
        {:settings
         {:json
          {:schemas (schemastore.json.schemas)}}})
      {})))
(lsp.julials.setup (core.merge default-options {}))
(lsp.kotlin_language_server.setup (core.merge default-options {}))
(lsp.pylsp.setup (core.merge default-options {}))
(lsp.terraformls.setup (core.merge
                         default-options
                         {:settings
                          {:terraform-ls
                           {:experimentalFeatures {:validateOnSave true
                                                   :prefillRequiredFields true}}}}))
(lsp.tflint.setup {})
(lsp.texlab.setup (core.merge default-options {:filetypes [:tex :bib :plaintex]}))
(lsp.tsserver.setup (core.merge
                      default-options
                      {:root_dir (lsputil.root_pattern "package.json")}))
(lsp.yamlls.setup
  (core.merge
    default-options
    {:settings
     {:yaml
      {:schemas
       (let [k8s-prefix (table.concat ["https://raw.githubusercontent.com/"
                                       "yannh/"
                                       "kubernetes-json-schema/"
                                       "master/"
                                       "v1.22.4-standalone"])
             ->k8s (fn [x]
                     (table.concat [k8s-prefix x] :/))
             schemastore-prefix "https://json.schemastore.org"
             ->schemastore (fn [x]
                             (table.concat [schemastore-prefix x] :/))]
         {(->k8s "all.json") "k8s/**/*.yaml"
          (->k8s "clusterrole.json") "clusterrole.yaml"
          (->k8s "clusterrolebinding.json") "clusterrolebinding.yaml"
          (->k8s "configmap.json") "configmap.yaml"
          (->k8s "cronjob.json") "cronjob.yaml"
          (->k8s "daemonset.json") "daemonset.yaml"
          (->k8s "deployment.json") "deployment.yaml"
          (->k8s "horizontalpodautoscaler.json") "hpa.yaml"
          (->k8s "ingress.json") "ingress.yaml"
          (->k8s "ingressclass.json") "ingressclass.yaml"
          (->k8s "job.json") "job.yaml"
          (->k8s "namespace.json") "namespace.yaml"
          (->k8s "networkpolicy.json") "networkpolicy.yaml"
          (->k8s "poddisruptionbudget.json") "pdb.yaml"
          (->k8s "podsecuritycontext.json") "podsecuritycontext.yaml"
          (->k8s "podsecuritypolicy.json") ["podsecuritypolicy.yaml" "psp.yaml"]
          (->k8s "priorityclass.json") "priorityclass.yaml"
          (->k8s "secret.json") "secret.yaml"
          (->k8s "securitycontext.json") "securitycontext.yaml"
          (->k8s "service.json") ["service.yaml" "svc.yaml"]
          (->k8s "serviceaccount.json") "serviceaccount.yaml"
          (->k8s "statefulset.json") "statefulset.yaml"
          (->k8s "storageclass.json") "storageclass.yaml"
          (->schemastore "kustomization") "kustomization.yaml"
          (->schemastore "helmfile.json") "helmfile.yaml"
          (->schemastore "github-workflow.json") "/.github/workflows/*"
          (->schemastore "circleciconfig.json") "/.circleci/*"
          (->schemastore "golangci-lint.json") ".golangci.yml"})
       :validate true}
      :single_file_support true}}))
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

(noremap!
  [:n]
  "<Leader>d"
  ":<C-u>lua vim.diagnostic.open_float({border = 'rounded'})<CR>"
  :silent)
(noremap!
  [:n]
  "[d"
  ":<C-u>lua vim.diagnostic.goto_prev({float = {border = 'rounded'}})<CR>" :silent)
(noremap!
  [:n]
  "]d"
  ":<C-u>lua vim.diagnostic.goto_next({float = {border = 'rounded'}})<CR>" :silent)

(noremap! [:n :i] "<F2>" ":<C-u>lua vim.lsp.buf.rename()<CR>" :silent)
(noremap! [:n] "<leader>rn" ":<C-u>lua vim.lsp.buf.rename()<CR>" :silent)

(noremap! [:n] "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>" :silent)
(noremap! [:x] "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>" :silent)

(when (loaded? :dressing.nvim)
  (let [dressing (require :dressing)]
    (dressing.setup
      {:input
       {:default_prompt icontab.rquot}})))

(lsp-lines.setup)

(vim.diagnostic.config
  {:virtual_text false
   :virtual_lines true
   :underline true
   :signs true})

(nvim.fn.sign_define :DiagnosticSignError
                     {:text icontab.bug
                      :texthl :DiagnosticSignError})
(nvim.fn.sign_define :DiagnosticSignWarn
                     {:text icontab.exclam-circle
                      :texthl :DiagnosticSignWarn})
(nvim.fn.sign_define :DiagnosticSignInfo
                     {:text icontab.info-circle
                      :texthl :DiagnosticSignInfo})
(nvim.fn.sign_define :DiagnosticSignHint
                     {:text icontab.leaf
                      :texthl :DiagnosticSignHint})

;; trouble.nvim
(when (loaded? :trouble.nvim)
  (let [trouble (require :trouble)]
    (trouble.setup {:auto_open true
                    :auto_close true
                    :signs {:error icontab.bug
                            :warning icontab.exclam-circle
                            :hint icontab.leaf
                            :information icontab.info-circle
                            :other icontab.comment-alt}})
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
                :colors {:error [:DiagnosticSignError]
                         :warning [:DiagnosticSignWarn]
                         :info [:DiagnosticSignInfo]
                         :hint [:DiagnosticSignHint]
                         :default [colors.purple]}})))

;; lightbulb
(when (loaded? :nvim-lightbulb)
  (augroup! init-lightbulb
            (autocmd! "CursorHold,CursorHoldI"
                      "*"
                      "lua require'nvim-lightbulb'.update_lightbulb()"))
  (nvim.fn.sign_define :LightBulbSign
                       {:text icontab.lightbulb
                        :texthl :DiagnosticSignLightBulb}))

(when (loaded? :fidget.nvim)
  (let [fidget (require :fidget)]
    (fidget.setup
      {:text {:spinner icon.spinners
              :done icontab.check}})))
