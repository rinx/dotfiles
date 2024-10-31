-- [nfnl] Compiled from fnl/rc/plugin/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local lsp = autoload("lspconfig")
local lsp_signature = autoload("lsp_signature")
local lsputil = autoload("lspconfig.util")
local schemastore = autoload("schemastore")
local icon = autoload("rc.icon")
local icontab = icon.tab
local function setup_codelens_refresh(client, bufnr)
  local ok_3f, supported_3f = nil, nil
  local function _2_()
    return client.supports_method("textDocument/codeLens")
  end
  ok_3f, supported_3f = pcall(_2_)
  if (ok_3f and supported_3f) then
    local group_5_auto = vim.api.nvim_create_augroup("init-lsp-codelens", {clear = true})
    return vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = bufnr, callback = vim.lsp.codelens.refresh, group = group_5_auto})
  else
    return nil
  end
end
local function setup_inlay_hints(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    return vim.lsp.inlay_hint.enable(true)
  else
    return nil
  end
end
local function setup_document_formatting(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local group_5_auto = vim.api.nvim_create_augroup("init-lsp-format", {clear = true})
    return vim.api.nvim_create_autocmd({"BufWritePre"}, {command = "lua vim.lsp.buf.format()", group = group_5_auto, pattern = "<buffer>"})
  else
    return nil
  end
end
do
  local group_5_auto = vim.api.nvim_create_augroup("lsp-attach", {clear = true})
  local function _6_(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    setup_codelens_refresh(client, bufnr)
    setup_inlay_hints(client, bufnr)
    setup_document_formatting(client, bufnr)
    return lsp_signature.on_attach({bind = true, doc_lines = 10, hint_enabled = true, hint_prefix = (icontab.info .. " "), hint_scheme = "String", handler_opts = {border = "single"}, decorator = {["`"] = "`"}})
  end
  vim.api.nvim_create_autocmd({"LspAttach"}, {callback = _6_, group = group_5_auto})
end
local default_options = {}
lsp.ast_grep.setup(core.merge(default_options, {filetypes = {"*"}}))
lsp.bashls.setup(core.merge(default_options, {settings = {bashIde = {shfmt = {caseIndent = true}}}}))
lsp.bufls.setup(core.merge(default_options, {}))
lsp.clojure_lsp.setup(core.merge(default_options, {}))
lsp.cssls.setup(core.merge(default_options, {}))
lsp.dagger.setup(core.merge(default_options, {}))
lsp.denols.setup(core.merge(default_options, {init_options = {lint = true, unstable = true, suggest = {imports = {hosts = {["https://deno.land"] = true, ["https://cdn.nest.land"] = true, ["https://crux.land"] = true}}}}, root_dir = lsputil.root_pattern("deno.json", "deno.jsonc")}))
lsp.docker_compose_language_service.setup(core.merge(default_options, {}))
lsp.dockerls.setup(core.merge(default_options, {}))
lsp.efm.setup(core.merge(default_options, {filetypes = {"dockerfile", "gitcommit", "proto", "rego", "vcl", "yaml.github-actions"}, init_options = {codeAction = true, completion = true, documentFormatting = true, documentSymbol = true, hover = true}, settings = {languages = {dockerfile = {{lintCommand = "hadolint --no-color", lintSource = "efm/hadolint", lintAfterOpen = true, lintFormats = {"%f:%l %m"}}}, gitcommit = {{lintCommand = "gitlint --config ~/.dotfiles/.gitlint", lintStdin = true, lintSource = "efm/gitlint", lintAfterOpen = true, lintFormats = {"%l: %m: \"%r\"", "%l: %m"}}}, proto = {{lintCommand = "buf lint --path", lintSource = "efm/buf-lint", lintAfterOpen = true, lintFormats = {"%f:%l:%c:%m"}, lintSeverity = 2, rootMarkers = {"buf.yaml"}}}, rego = {{lintCommand = "opa check --strict", lintIgnoreExitCode = true, lintSource = "efm/opa-check-strict", lintAfterOpen = true, lintFormats = {"%m: %f:%l: %m", "%f:%l: %m"}}}, vcl = {{lintCommand = "falco -vv lint ${INPUT} 2>&1", lintIgnoreExitCode = true, lintSource = "efm/falco", lintAfterOpen = true, lintFormats = {"%E\240\159\146\165 %m", "%E\240\159\148\165 [ERROR] %m", "%W\226\157\151\239\184\143 [WARNING] %m", "%I\240\159\148\136 [INFO] %m", "%Zin %f at line %l, position %c", "%-G%.%#"}}}, ["yaml.github-actions"] = {{lintCommand = "actionlint -no-color -oneline -stdin-filename \"${INPUT}\" -", lintStdin = true, lintSource = "efm/actionlint", lintAfterOpen = true, lintFormats = {"%f:%l:%c: %.%#: SC%n:%trror:%m", "%f:%l:%c: %.%#: SC%n:%tarning:%m", "%f:%l:%c: %.%#: SC%n:%tnfo:%m", "%f:%l:%c: %m"}, requireMarker = true, rootMarkers = {".github/"}}}}, lintDebounce = "300ms"}}))
lsp.erlangls.setup(core.merge(default_options, {}))
lsp.fennel_language_server.setup(core.merge(default_options, {root_dir = lsputil.root_pattern(".nfnl.fnl"), settings = {fennel = {diagnostics = {globals = {"vim", "jit", "comment"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}))
lsp.fennel_ls.setup(core.merge(default_options, {root_dir = lsputil.root_pattern(".nfnl.fnl")}))
lsp.fortls.setup(core.merge(default_options, {}))
lsp.gopls.setup(core.merge(default_options, {settings = {gopls = {usePlaceholders = true, analyses = {fieldalignment = true, shadow = true, useany = true, unusedvariable = true}, hints = {assignVariableTypes = true, compositeLiteralFields = true, compositeLiteralTypes = true, constantValues = true, functionTypeParameters = true, parameterNames = true, rangeVariableTypes = true}, staticcheck = true, vulncheck = "Imports", gofumpt = true}}}))
lsp.harper_ls.setup(core.merge(default_options, {}))
lsp.hls.setup(core.merge(default_options, {}))
lsp.html.setup(core.merge(default_options, {}))
lsp.jqls.setup(core.merge(default_options, {}))
lsp.jsonls.setup(core.merge(default_options, {settings = {json = {schemas = schemastore.json.schemas()}}}))
lsp.julials.setup(core.merge(default_options, {}))
lsp.kotlin_language_server.setup(core.merge(default_options, {}))
lsp.marksman.setup(core.merge(default_options, {}))
lsp.nil_ls.setup(core.merge(default_options, {}))
lsp.nixd.setup(core.merge(default_options, {}))
lsp.pylsp.setup(core.merge(default_options, {}))
lsp.regal.setup(core.merge(default_options, {init_options = {enableDebugCodelens = true, evalCodelensDisplayInline = true}}))
lsp.terraformls.setup(core.merge(default_options, {init_options = {experimentalFeatures = {validateOnSave = true, prefillRequiredFields = true}}}))
lsp.tflint.setup({})
lsp.texlab.setup(core.merge(default_options, {filetypes = {"tex", "bib", "plaintex"}}))
lsp.ts_ls.setup({})
local _7_
do
  local k8s_prefix = table.concat({"https://raw.githubusercontent.com/", "yannh/", "kubernetes-json-schema/", "master/", "v1.31.0-standalone"})
  local __3ek8s
  local function _8_(x)
    return table.concat({k8s_prefix, x}, "/")
  end
  __3ek8s = _8_
  local schemastore_prefix = "https://json.schemastore.org"
  local __3eschemastore
  local function _9_(x)
    return table.concat({schemastore_prefix, x}, "/")
  end
  __3eschemastore = _9_
  _7_ = {[__3ek8s("all.json")] = "k8s/**/*.yaml", [__3ek8s("clusterrole.json")] = "clusterrole.yaml", [__3ek8s("clusterrolebinding.json")] = "clusterrolebinding.yaml", [__3ek8s("configmap.json")] = "configmap.yaml", [__3ek8s("cronjob.json")] = "cronjob.yaml", [__3ek8s("daemonset.json")] = "daemonset.yaml", [__3ek8s("deployment.json")] = "deployment.yaml", [__3ek8s("horizontalpodautoscaler.json")] = "hpa.yaml", [__3ek8s("ingress.json")] = "ingress.yaml", [__3ek8s("ingressclass.json")] = "ingressclass.yaml", [__3ek8s("job.json")] = "job.yaml", [__3ek8s("namespace.json")] = "namespace.yaml", [__3ek8s("networkpolicy.json")] = "networkpolicy.yaml", [__3ek8s("poddisruptionbudget.json")] = "pdb.yaml", [__3ek8s("podsecuritycontext.json")] = "podsecuritycontext.yaml", [__3ek8s("podsecuritypolicy.json")] = {"podsecuritypolicy.yaml", "psp.yaml"}, [__3ek8s("priorityclass.json")] = "priorityclass.yaml", [__3ek8s("secret.json")] = "secret.yaml", [__3ek8s("securitycontext.json")] = "securitycontext.yaml", [__3ek8s("service.json")] = {"service.yaml", "svc.yaml"}, [__3ek8s("serviceaccount.json")] = "serviceaccount.yaml", [__3ek8s("statefulset.json")] = "statefulset.yaml", [__3ek8s("storageclass.json")] = "storageclass.yaml", [__3eschemastore("kustomization")] = "kustomization.yaml", [__3eschemastore("helmfile.json")] = "helmfile.yaml", [__3eschemastore("github-workflow.json")] = "/.github/workflows/*", [__3eschemastore("circleciconfig.json")] = "/.circleci/*", [__3eschemastore("golangci-lint.json")] = ".golangci.yml"}
end
lsp.yamlls.setup(core.merge(default_options, {settings = {yaml = {schemas = _7_, validate = true}, single_file_support = true}}))
lsp.zls.setup({})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
vim.keymap.set("n", "K", ":<C-u>lua vim.lsp.buf.hover()<CR>", {silent = true})
vim.keymap.set("n", "gd", ":<C-u>lua vim.lsp.buf.definition()<CR>", {silent = true})
vim.keymap.set("n", "gD", ":<C-u>lua vim.lsp.buf.declaration()<CR>", {silent = true})
vim.keymap.set("n", "gi", ":<C-u>lua vim.lsp.buf.implementation()<CR>", {silent = true})
vim.keymap.set("n", "gr", ":<C-u>lua vim.lsp.buf.references()<CR>", {silent = true})
vim.keymap.set("n", "gs", ":<C-u>lua vim.lsp.buf.signature_help()<CR>", {silent = true})
vim.keymap.set("n", "<leader>l", ":<C-u>lua vim.lsp.codelens.run()<CR>", {silent = true})
vim.keymap.set("n", "<leader>i", ":<C-u>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", {silent = true})
vim.keymap.set("n", "<Leader>d", ":<C-u>lua vim.diagnostic.open_float({border = 'rounded'})<CR>", {silent = true})
vim.keymap.set("n", "[d", ":<C-u>lua vim.diagnostic.goto_prev({float = {border = 'rounded'}})<CR>", {silent = true})
vim.keymap.set("n", "]d", ":<C-u>lua vim.diagnostic.goto_next({float = {border = 'rounded'}})<CR>", {silent = true})
do
  vim.keymap.set("n", "<F2>", ":<C-u>lua vim.lsp.buf.rename()<CR>", {silent = true})
  vim.keymap.set("i", "<F2>", ":<C-u>lua vim.lsp.buf.rename()<CR>", {silent = true})
end
vim.keymap.set("n", "<leader>rn", ":<C-u>lua vim.lsp.buf.rename()<CR>", {silent = true})
vim.keymap.set("n", "<Leader>a", ":<C-u>lua vim.lsp.buf.code_action()<CR>", {silent = true})
vim.keymap.set("x", "<Leader>a", ":<C-u>lua vim.lsp.buf.range_code_action()<CR>", {silent = true})
vim.diagnostic.config({virtual_lines = true, underline = true, signs = true, virtual_text = false})
vim.fn.sign_define("DiagnosticSignError", {text = icontab.bug, texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = icontab["exclam-circle"], texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = icontab["info-circle"], texthl = "DiagnosticSignInfo"})
return vim.fn.sign_define("DiagnosticSignHint", {text = icontab.leaf, texthl = "DiagnosticSignHint"})
