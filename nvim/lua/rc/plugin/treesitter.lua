-- [nfnl] fnl/rc/plugin/treesitter.fnl
local ts = require("nvim-treesitter")
local languages = {"bash", "c", "clojure", "cmake", "comment", "commonlisp", "cpp", "css", "cue", "diff", "dockerfile", "dot", "earthfile", "editorconfig", "elixir", "elm", "erlang", "fennel", "fortran", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "gleam", "go", "gomod", "gosum", "gotmpl", "gowork", "gpg", "graphql", "hcl", "helm", "hjson", "html", "http", "hyprlang", "ini", "janet_simple", "java", "javascript", "jq", "jsdoc", "json", "json5", "jsonc", "jsonnet", "julia", "kotlin", "latex", "llvm", "lua", "luadoc", "luap", "make", "markdown", "markdown_inline", "mermaid", "nginx", "nix", "passwd", "pem", "promql", "proto", "python", "ql", "query", "r", "regex", "rego", "rst", "rust", "scss", "smithy", "sparql", "sql", "ssh_config", "strace", "teal", "terraform", "tmux", "toml", "tsx", "typescript", "typst", "vim", "vimdoc", "vrl", "vue", "xml", "yaml", "zig"}
ts.setup({})
ts.install(languages)
do
  local group_5_auto = vim.api.nvim_create_augroup("init-treesitter", {clear = true})
  local function _1_(ctx)
    pcall(vim.treesitter.start)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    return nil
  end
  vim.api.nvim_create_autocmd({"FileType"}, {callback = _1_, group = group_5_auto})
end
local function ensure_installed()
  local installer = ts.install(languages)
  return installer:wait(300000)
end
return vim.api.nvim_create_user_command("TSInstallEnsure", ensure_installed, {})
