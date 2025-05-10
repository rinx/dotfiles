(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(import-macros {: map! : augroup!} :rc.macros)

(local schemastore (autoload :schemastore))

(local icon (autoload :rc.icon))
(local icontab icon.tab)

(fn setup-codelens-refresh [client bufnr]
  (let [(ok? supported?)
        (pcall
          (fn []
            (client:supports_method :textDocument/codeLens)))]
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
                 (setup-document-formatting client bufnr)))})

(augroup!
  lsp-progress
  {:events [:LspProgress]
   :callback (fn [ev]
               (let [client (vim.lsp.get_client_by_id ev.data.client_id)]
                 (vim.notify
                   (vim.lsp.status)
                   :info
                   {:id :lsp_progress
                    :title client.name
                    :opts (fn [notif]
                            (set notif.icon
                                 (if (= ev.data.params.value.kind :end)
                                     icontab.check
                                     (core.get
                                       icon.spinners
                                       (core.inc
                                         (math.floor
                                           (% (/ (vim.uv.hrtime)
                                                 (* 1e6 80))
                                              (core.count icon.spinners))))))))})))})

(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border "rounded"}))
(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border "rounded"}))

(map! [:n] :K ":<C-u>lua vim.lsp.buf.hover()<CR>" {:silent true})
(map! [:n] :gd ":<C-u>lua vim.lsp.buf.definition()<CR>" {:silent true})
(map! [:n] :gD ":<C-u>lua vim.lsp.buf.declaration()<CR>" {:silent true})
(map! [:n] :gi ":<C-u>lua vim.lsp.buf.implementation()<CR>" {:silent true})
(map! [:n] :gr ":<C-u>lua vim.lsp.buf.references()<CR>" {:silent true})
(map! [:n] :gs ":<C-u>lua vim.lsp.buf.signature_help()<CR>" {:silent true})

(map! [:n] :<leader>l ":<C-u>lua vim.lsp.codelens.run()<CR>" {:silent true})

(map! [:n :i] "<F2>" ":<C-u>lua vim.lsp.buf.rename()<CR>" {:silent true})
(map! [:n] "<leader>rn" ":<C-u>lua vim.lsp.buf.rename()<CR>" {:silent true})

(map! [:n] "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>" {:silent true})
(map! [:x] "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>" {:silent true})

(vim.diagnostic.config
  {:virtual_text false
   :virtual_lines true
   :underline true
   :signs {:text {vim.diagnostic.severity.ERROR icontab.bug
                  vim.diagnostic.severity.WARN icontab.exclam-circle
                  vim.diagnostic.severity.INFO icontab.info-circle
                  vim.diagnostic.severity.HINT icontab.leaf}}})

(fn use [cfgs]
  (let [lsps (icollect [name _ (pairs cfgs)]
               name)]
    (each [lsp config (pairs cfgs)]
      (vim.lsp.config lsp config))
    (vim.lsp.enable lsps)))

(fn root-pattern [...]
  (let [filenames [...]]
    (fn [bufnr callback]
      (let [found-dirs (vim.fs.find filenames
                         {:upward true
                          :path (-> (vim.api.nvim_buf_get_name bufnr)
                                    (vim.fs.normalize)
                                    (vim.fs.dirname))})]
        (when (> (core.count found-dirs) 0)
          (-> found-dirs
              (. 1)
              (vim.fs.dirname)
              (callback)))))))

(use
  {:ast_grep {:filetypes [:*]}
   :bash_ls {:settings
             {:bashIde
              {:shfmt {:caseIndent true}}}}
   :buf_ls {}
   :clojure_lsp {}
   :cue {}
   :dagger {}
   :denols {:init_options
            {:lint true
             :unstable true}
            :root_dir (root-pattern :deno.json :deno.jsonc :deps.ts)}
   :docker_compose_language_service {}
   :dockerls {}
   :efm {:filetypes
         [:dockerfile
          :gitcommit
          :proto
          :rego
          :vcl
          :yaml.github-actions]
         :init_options
         {:codeAction true
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
          :lintDebounce :300ms}}
   :erlangls {}
   :fennel_ls {:root_dir (root_pattern :.nfnl.fnl)}
   :fortls {}
   :gh_actions_ls {}
   :gleam {}
   :gopls {:settings
           {:gopls
            {:usePlaceholders true
             :analyses {:shadow true
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
             :gofumpt true}}}
   :harper_ls {:settings
               {:harper-ls
                {:userDictPath "~/.config/harper-ls/dict.txt"}}}
   :jqls {}
   :jsonls {:settings
            {:json
             {:schemas (schemastore.json.schemas)}}}
   :marksman {}
   :nil_ls {}
   :nixd {}
   :pylsp {}
   :regal {:init_options
           {:enableDebugCodelens true
            :evalCodelensDisplayInline true}}
   :rust_analyzer {}
   :terraformls {:init_options
                 {:experimentalFeatures
                  {:validateOnSave true
                   :prefillRequiredFields true}}}
   :tflint {}
   :texlab {:filetypes [:tex :bib :plaintex]}
   :ts_ls {}
   :yamlls {:settings
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
             :single_file_support true}}})
