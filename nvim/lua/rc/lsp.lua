-- [nfnl] fnl/rc/lsp.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local schemastore = autoload("schemastore")
local icon = autoload("rc.icon")
local icontab = icon.tab
local function setup_codelens_refresh(client, bufnr)
  local group_5_auto = vim.api.nvim_create_augroup("init-lsp-codelens", {clear = true})
  return vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = bufnr, callback = vim.lsp.codelens.refresh, group = group_5_auto})
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
  local function _4_(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    setup_codelens_refresh(client, bufnr)
    setup_inlay_hints(client, bufnr)
    return setup_document_formatting(client, bufnr)
  end
  vim.api.nvim_create_autocmd({"LspAttach"}, {callback = _4_, group = group_5_auto})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("lsp-progress", {clear = true})
  local function _5_(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local function _6_(notif)
      if (ev.data.params.value.kind == "end") then
        notif.icon = icontab.check
      else
        notif.icon = core.get(icon.spinners, core.inc(math.floor(((vim.uv.hrtime() / (1000000 * 80)) % core.count(icon.spinners)))))
      end
      return nil
    end
    return vim.notify(vim.lsp.status(), "info", {id = "lsp_progress", title = client.name, opts = _6_})
  end
  vim.api.nvim_create_autocmd({"LspProgress"}, {callback = _5_, group = group_5_auto})
end
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
vim.keymap.set("n", "K", ":<C-u>lua vim.lsp.buf.hover()<CR>", {silent = true})
vim.keymap.set("n", "gd", ":<C-u>lua Snacks.picker.lsp_definitions({layout = {preset = \"bottom\"}})<CR>", {silent = true, desc = "show lsp definitions"})
vim.keymap.set("n", "gD", ":<C-u>lua Snacks.picker.lsp_declarations({layout = {preset = \"bottom\"}})<CR>", {silent = true, desc = "show lsp declarations"})
vim.keymap.set("n", "gi", ":<C-u>lua Snacks.picker.lsp_implementations({layout = {preset = \"bottom\"}})<CR>", {silent = true, desc = "show lsp implementations"})
vim.keymap.set("n", "gr", ":<C-u>lua Snacks.picker.lsp_references({layout = {preset = \"bottom\"}})<CR>", {silent = true, desc = "show lsp references"})
vim.keymap.set("n", "gs", ":<C-u>lua vim.lsp.buf.signature_help()<CR>", {silent = true})
vim.keymap.set("n", "<Leader>f", ":<C-u>lua vim.lsp.buf.format()<CR>", {silent = true})
vim.keymap.set("n", "<leader>l", ":<C-u>lua vim.lsp.codelens.run()<CR>", {silent = true})
do
  vim.keymap.set("n", "<F2>", ":<C-u>lua vim.lsp.buf.rename()<CR>", {silent = true})
  vim.keymap.set("i", "<F2>", ":<C-u>lua vim.lsp.buf.rename()<CR>", {silent = true})
end
vim.keymap.set("n", "<leader>rn", ":<C-u>lua vim.lsp.buf.rename()<CR>", {silent = true})
vim.keymap.set("n", "<Leader>a", ":<C-u>lua vim.lsp.buf.code_action()<CR>", {silent = true})
vim.keymap.set("x", "<Leader>a", ":<C-u>lua vim.lsp.buf.range_code_action()<CR>", {silent = true})
vim.diagnostic.config({virtual_lines = true, underline = true, signs = {text = {[vim.diagnostic.severity.ERROR] = icontab.bug, [vim.diagnostic.severity.WARN] = icontab["exclam-circle"], [vim.diagnostic.severity.INFO] = icontab["info-circle"], [vim.diagnostic.severity.HINT] = icontab.leaf}}, virtual_text = false})
local function use(cfgs)
  local lsps
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for name, _ in pairs(cfgs) do
      local val_28_ = name
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    lsps = tbl_26_
  end
  for lsp, config in pairs(cfgs) do
    vim.lsp.config(lsp, config)
  end
  return vim.lsp.enable(lsps)
end
local function root_pattern(...)
  local filenames = {...}
  local function _9_(bufnr, callback)
    local found_dirs = vim.fs.find(filenames, {upward = true, path = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr)))})
    if (core.count(found_dirs) > 0) then
      return callback(vim.fs.dirname(found_dirs[1]))
    else
      return nil
    end
  end
  return _9_
end
local function alter_cmd(exec, nixpkg)
  if (vim.fn.executable(exec[1]) == 1) then
    return exec
  else
    return {"nix", "run", ("nixpkgs#" .. nixpkg), "--", unpack(exec, 2)}
  end
end
local _12_
do
  local k8s_prefix = table.concat({"https://raw.githubusercontent.com/", "yannh/", "kubernetes-json-schema/", "master/", "v1.33.0-standalone"})
  local __3ek8s
  local function _13_(x)
    return table.concat({k8s_prefix, x}, "/")
  end
  __3ek8s = _13_
  local schemastore_prefix = "https://json.schemastore.org"
  local __3eschemastore
  local function _14_(x)
    return table.concat({schemastore_prefix, x}, "/")
  end
  __3eschemastore = _14_
  _12_ = {[__3ek8s("all.json")] = "k8s/**/*.yaml", [__3ek8s("clusterrole.json")] = "clusterrole.yaml", [__3ek8s("clusterrolebinding.json")] = "clusterrolebinding.yaml", [__3ek8s("configmap.json")] = "configmap.yaml", [__3ek8s("cronjob.json")] = "cronjob.yaml", [__3ek8s("daemonset.json")] = "daemonset.yaml", [__3ek8s("deployment.json")] = "deployment.yaml", [__3ek8s("horizontalpodautoscaler.json")] = "hpa.yaml", [__3ek8s("ingress.json")] = "ingress.yaml", [__3ek8s("ingressclass.json")] = "ingressclass.yaml", [__3ek8s("job.json")] = "job.yaml", [__3ek8s("namespace.json")] = "namespace.yaml", [__3ek8s("networkpolicy.json")] = "networkpolicy.yaml", [__3ek8s("poddisruptionbudget.json")] = "pdb.yaml", [__3ek8s("podsecuritycontext.json")] = "podsecuritycontext.yaml", [__3ek8s("podsecuritypolicy.json")] = {"podsecuritypolicy.yaml", "psp.yaml"}, [__3ek8s("priorityclass.json")] = "priorityclass.yaml", [__3ek8s("secret.json")] = "secret.yaml", [__3ek8s("securitycontext.json")] = "securitycontext.yaml", [__3ek8s("service.json")] = {"service.yaml", "svc.yaml"}, [__3ek8s("serviceaccount.json")] = "serviceaccount.yaml", [__3ek8s("statefulset.json")] = "statefulset.yaml", [__3ek8s("storageclass.json")] = "storageclass.yaml", [__3eschemastore("kustomization")] = "kustomization.yaml", [__3eschemastore("helmfile.json")] = "helmfile.yaml", [__3eschemastore("github-workflow.json")] = "/.github/workflows/*", [__3eschemastore("circleciconfig.json")] = "/.circleci/*", [__3eschemastore("golangci-lint.json")] = ".golangci.yml"}
end
return use({ast_grep = {filetypes = {"c", "cpp", "css", "dart", "fennel", "go", "html", "java", "javascript", "javascript.jsx", "javascriptreact", "kotlin", "lua", "python", "rust", "typescript", "typescript.tsx", "typescriptreact"}}, bashls = {settings = {bashIde = {shfmt = {caseIndent = true}}}}, buf_ls = {}, clojure_lsp = {}, cssls = {}, cue = {}, dagger = {}, denols = {init_options = {lint = true, unstable = true}, root_dir = root_pattern("deno.json", "deno.jsonc", "deps.ts")}, docker_compose_language_service = {}, dockerls = {}, efm = {filetypes = {"dockerfile", "gitcommit", "proto", "rego", "vcl", "yaml.github-actions"}, init_options = {codeAction = true, completion = true, documentFormatting = true, documentSymbol = true, hover = true}, settings = {languages = {dockerfile = {{lintCommand = "hadolint --no-color", lintSource = "efm/hadolint", lintAfterOpen = true, lintFormats = {"%f:%l %m"}}}, gitcommit = {{lintCommand = "gitlint --config ~/.dotfiles/.gitlint", lintStdin = true, lintSource = "efm/gitlint", lintAfterOpen = true, lintFormats = {"%l: %m: \"%r\"", "%l: %m"}}}, proto = {{lintCommand = "buf lint --path", lintSource = "efm/buf-lint", lintAfterOpen = true, lintFormats = {"%f:%l:%c:%m"}, lintSeverity = 2, rootMarkers = {"buf.yaml"}}}, rego = {{lintCommand = "opa check --strict", lintIgnoreExitCode = true, lintSource = "efm/opa-check-strict", lintAfterOpen = true, lintFormats = {"%m: %f:%l: %m", "%f:%l: %m"}}}, vcl = {{lintCommand = "falco -vv lint ${INPUT} 2>&1", lintIgnoreExitCode = true, lintSource = "efm/falco", lintAfterOpen = true, lintFormats = {"%E\240\159\146\165 %m", "%E\240\159\148\165 [ERROR] %m", "%W\226\157\151\239\184\143 [WARNING] %m", "%I\240\159\148\136 [INFO] %m", "%Zin %f at line %l, position %c", "%-G%.%#"}}}, ["yaml.github-actions"] = {{lintCommand = "actionlint -no-color -oneline -stdin-filename \"${INPUT}\" -", lintStdin = true, lintSource = "efm/actionlint", lintAfterOpen = true, lintFormats = {"%f:%l:%c: %.%#: SC%n:%trror:%m", "%f:%l:%c: %.%#: SC%n:%tarning:%m", "%f:%l:%c: %.%#: SC%n:%tnfo:%m", "%f:%l:%c: %m"}, requireMarker = true, rootMarkers = {".github/"}}}}, lintDebounce = "300ms"}}, erlangls = {cmd = alter_cmd({"erlang_ls"}, "beamMinimal27Packages.erlang-ls")}, fennel_ls = {root_dir = root_pattern(".nfnl.fnl", "flsproject.fnl")}, fortls = {cmd = alter_cmd({"fortls", "--notify_init", "--hover_signature", "--hover_language=fortran", "--use_signature_help"}, "fortls")}, gh_actions_ls = {}, gleam = {}, gopls = {settings = {gopls = {usePlaceholders = true, analyses = {shadow = true, useany = true, unusedvariable = true}, hints = {assignVariableTypes = true, compositeLiteralFields = true, compositeLiteralTypes = true, constantValues = true, functionTypeParameters = true, parameterNames = true, rangeVariableTypes = true}, staticcheck = true, vulncheck = "Imports", gofumpt = true}}}, harper_ls = {cmd = alter_cmd({"harper", "--stdio"}, "harper")}, helm_ls = {cmd = alter_cmd({"helm_ls", "serve"}, "helm-ls")}, jqls = {cmd = alter_cmd({"jq-lsp"}, "jq-lsp")}, jsonls = {settings = {json = {schemas = schemastore.json.schemas()}}}, lua_ls = {cmd = alter_cmd({"lua-language-server"}, "lua-language-server")}, marksman = {}, nginx_language_server = {cmd = alter_cmd({"nginx-language-server"}, "nginx-language-server")}, nil_ls = {}, nixd = {}, pylsp = {cmd = alter_cmd({"pylsp"}, "python313Packages.python-lsp-server")}, regal = {init_options = {enableDebugCodelens = true, evalCodelensDisplayInline = true}}, rust_analyzer = {cmd = alter_cmd({"rust-analyzer"}, "rust-analyzer")}, terraformls = {init_options = {experimentalFeatures = {validateOnSave = true, prefillRequiredFields = true}}}, tflint = {}, tinymist = {}, tsgo = {cmd = {"tsgo", "--lsp", "--stdio"}, filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"}, root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json")}, yamlls = {settings = {yaml = {schemas = _12_, validate = true}, single_file_support = true}}})
