(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local lsp (autoload :lspconfig))
(local lsp-signature (autoload :lsp_signature))
(local lsputil (autoload :lspconfig.util))
(local schemastore (autoload :schemastore))

(local icon (autoload :rc.icon))
(import-macros {: map! : augroup!} :rc.macros)

(local icontab icon.tab)

(fn setup-codelens-refresh [client bufnr]
  (let [(ok? supported?)
        (pcall
          (fn []
            (client.supports_method :textDocument/codeLens)))]
    (when (and ok? supported?)
      (augroup!
        init-lsp-codelens
        {:events [:CursorHold :CursorHoldI]
         :buffer bufnr
         :callback vim.lsp.codelens.refresh}))))

(fn setup-inlay-hints [client bufnr]
  (when client.server_capabilities.inlayHintProvider
    (vim.lsp.inlay_hint.enable true)))

(fn setup-document-formatting [client bufnr]
  (when client.server_capabilities.documentFormattingProvider
    (augroup!
      init-lsp-format
      {:events [:BufWritePre]
       :pattern :<buffer>
       :command "lua vim.lsp.buf.format()"})))

(augroup!
  lsp-attach
  {:events [:LspAttach]
   :callback (fn [args]
               (let [bufnr args.buf
                     client (vim.lsp.get_client_by_id args.data.client_id)]
                 (setup-codelens-refresh client bufnr)
                 (setup-inlay-hints client bufnr)
                 (setup-document-formatting client bufnr)

                 (lsp-signature.on_attach
                  {:bind true
                   :doc_lines 10
                   :hint_enabled true
                   :hint_prefix (.. icontab.info " ")
                   :hint_scheme :String
                   :handler_opts
                   {:border :single}
                   :decorator {"`" "`"}})))})

(local default-options {})

(lsp.ast_grep.setup (core.merge
                      default-options
                      {:filetypes [:*]}))
(lsp.bashls.setup (core.merge
                    default-options
                    {:settings
                     {:bashIde
                      {:shfmt {:caseIndent true}}}}))
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
                     :root_dir (lsputil.root_pattern "deno.json"
                                                     "deno.jsonc")}))
(lsp.docker_compose_language_service.setup (core.merge default-options {}))
(lsp.dockerls.setup (core.merge default-options {}))
(lsp.efm.setup (core.merge
                 default-options
                 {:filetypes [:dockerfile
                              :gitcommit
                              :proto
                              :rego
                              :vcl
                              :yaml.github-actions]
                  :init_options {:codeAction true
                                 :completion true
                                 :documentFormatting true
                                 :documentSymbol true
                                 :hover true}
                  :settings
                  {:languages
                   {:dockerfile
                    [{:lintCommand "hadolint --no-color"
                      :lintSource "efm/hadolint"
                      :lintAfterOpen true
                      :lintFormats ["%f:%l %m"]}]
                    :gitcommit
                    [{:lintCommand "gitlint --config ~/.dotfiles/.gitlint"
                      :lintStdin true
                      :lintSource "efm/gitlint"
                      :lintAfterOpen true
                      :lintFormats ["%l: %m: \"%r\""
                                    "%l: %m"]}]
                    :proto
                    [{:lintCommand "buf lint --path"
                      :lintSource "efm/buf-lint"
                      :lintAfterOpen true
                      :lintFormats ["%f:%l:%c:%m"]
                      :lintSeverity 2
                      :rootMarkers ["buf.yaml"]}]
                    :rego
                    [{:lintCommand "opa check --strict"
                      :lintIgnoreExitCode true
                      :lintSource "efm/opa-check-strict"
                      :lintAfterOpen true
                      :lintFormats ["%m: %f:%l: %m"
                                    "%f:%l: %m"]}]
                    :vcl
                    [{:lintCommand "falco -vv lint ${INPUT} 2>&1"
                      :lintIgnoreExitCode true
                      :lintSource "efm/falco"
                      :lintAfterOpen true
                      :lintFormats ["%E💥 %m"
                                    "%E🔥 [ERROR] %m"
                                    "%W❗️ [WARNING] %m"
                                    "%I🔈 [INFO] %m"
                                    "%Zin %f at line %l, position %c"
                                    "%-G%.%#"]}]
                    :yaml.github-actions
                    [{:lintCommand "actionlint -no-color -oneline -stdin-filename \"${INPUT}\" -"
                      :lintStdin true
                      :lintSource "efm/actionlint"
                      :lintAfterOpen true
                      :lintFormats ["%f:%l:%c: %.%#: SC%n:%trror:%m"
                                    "%f:%l:%c: %.%#: SC%n:%tarning:%m"
                                    "%f:%l:%c: %.%#: SC%n:%tnfo:%m"
                                    "%f:%l:%c: %m"]
                      :requireMarker true
                      :rootMarkers [".github/"]}]}
                   :lintDebounce "300ms"}}))
(lsp.erlangls.setup (core.merge default-options {}))
(lsp.fennel_language_server.setup
  (core.merge
    default-options
    {:root_dir (lsputil.root_pattern ".nfnl.fnl")
     :settings {:fennel {:diagnostics {:globals [:vim :jit :comment]}
                         :workspace {:library
                                     (vim.api.nvim_list_runtime_paths)}}}}))
(lsp.fennel_ls.setup
  (core.merge
    default-options
    {:root_dir (lsputil.root_pattern ".nfnl.fnl")}))
(lsp.fortls.setup (core.merge default-options {}))
(lsp.gopls.setup (core.merge
                   default-options
                   {:settings
                    {:gopls
                     {:usePlaceholders true
                      :analyses {:fieldalignment true
                                 :shadow true
                                 :useany true
                                 :unusedvariable true}
                      :hints {:assignVariableTypes true
                              :compositeLiteralFields true
                              :compositeLiteralTypes true
                              :constantValues true
                              :functionTypeParameters true
                              :parameterNames true
                              :rangeVariableTypes true}
                      :staticcheck true
                      :vulncheck :Imports
                      :gofumpt true}}}))
(lsp.harper_ls.setup (core.merge
                       default-options
                       {:settings
                        {:harper-ls
                         {:userDictPath "~/.dotfiles/resources/dict.txt"}}}))
(lsp.hls.setup (core.merge default-options {}))
(lsp.html.setup (core.merge default-options {}))
(lsp.jqls.setup (core.merge default-options {}))
(lsp.jsonls.setup
  (core.merge
    default-options
    {:settings
     {:json
      {:schemas (schemastore.json.schemas)}}}))
(lsp.julials.setup (core.merge default-options {}))
(lsp.kotlin_language_server.setup (core.merge default-options {}))
(lsp.marksman.setup (core.merge default-options {}))
(lsp.nil_ls.setup (core.merge default-options {}))
(lsp.nixd.setup (core.merge default-options {}))
(lsp.pylsp.setup (core.merge default-options {}))
(lsp.regal.setup (core.merge
                   default-options
                   {:init_options
                    {:enableDebugCodelens true
                     :evalCodelensDisplayInline true}}))
(lsp.terraformls.setup (core.merge
                         default-options
                         {:init_options
                          {:experimentalFeatures
                           {:validateOnSave true
                            :prefillRequiredFields true}}}))
(lsp.tflint.setup {})
(lsp.texlab.setup (core.merge default-options {:filetypes [:tex :bib :plaintex]}))
(lsp.ts_ls.setup {})
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
                                       "v1.31.0-standalone"])
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
(lsp.zls.setup {})

(tset vim.lsp.handlers
      :textDocument/hover
      (vim.lsp.with vim.lsp.handlers.hover {:border :rounded}))
(tset vim.lsp.handlers
      :textDocument/signatureHelp
      (vim.lsp.with vim.lsp.handlers.signature_help {:border :rounded}))

(map! [:n] :K ":<C-u>lua vim.lsp.buf.hover()<CR>" {:silent true})
(map! [:n] :gd ":<C-u>lua vim.lsp.buf.definition()<CR>" {:silent true})
(map! [:n] :gD ":<C-u>lua vim.lsp.buf.declaration()<CR>" {:silent true})
(map! [:n] :gi ":<C-u>lua vim.lsp.buf.implementation()<CR>" {:silent true})
(map! [:n] :gr ":<C-u>lua vim.lsp.buf.references()<CR>" {:silent true})
(map! [:n] :gs ":<C-u>lua vim.lsp.buf.signature_help()<CR>" {:silent true})

(map! [:n] :<leader>l ":<C-u>lua vim.lsp.codelens.run()<CR>" {:silent true})

;; toggle inlay hints
(map! [:n] :<leader>i ":<C-u>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>" {:silent true})

(map!
  [:n]
  "<Leader>d"
  ":<C-u>lua vim.diagnostic.open_float({border = 'rounded'})<CR>"
  {:silent true})
(map!
  [:n]
  "[d"
  ":<C-u>lua vim.diagnostic.goto_prev({float = {border = 'rounded'}})<CR>"
  {:silent true})
(map!
  [:n]
  "]d"
  ":<C-u>lua vim.diagnostic.goto_next({float = {border = 'rounded'}})<CR>"
  {:silent true})

(map! [:n :i] "<F2>" ":<C-u>lua vim.lsp.buf.rename()<CR>" {:silent true})
(map! [:n] "<leader>rn" ":<C-u>lua vim.lsp.buf.rename()<CR>" {:silent true})

(map! [:n] "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>" {:silent true})
(map! [:x] "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>" {:silent true})

(vim.diagnostic.config
  {:virtual_text false
   :virtual_lines true
   :underline true
   :signs true})

(vim.fn.sign_define :DiagnosticSignError
                    {:text icontab.bug
                     :texthl :DiagnosticSignError})
(vim.fn.sign_define :DiagnosticSignWarn
                    {:text icontab.exclam-circle
                     :texthl :DiagnosticSignWarn})
(vim.fn.sign_define :DiagnosticSignInfo
                    {:text icontab.info-circle
                     :texthl :DiagnosticSignInfo})
(vim.fn.sign_define :DiagnosticSignHint
                    {:text icontab.leaf
                     :texthl :DiagnosticSignHint})
