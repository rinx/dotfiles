-- [nfnl] Compiled from fnl/rc/plugin/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local configs = require("nvim-treesitter.configs")
local parsers = require("nvim-treesitter.parsers")
do
  local parser_configs = parsers.get_parser_configs()
  parser_configs.cue = {install_info = {url = "https://github.com/eonpatapon/tree-sitter-cue", files = {"src/parser.c", "src/scanner.c"}, branch = "main"}, filetype = "cue"}
  parser_configs.norg_meta = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}}
  parser_configs.norg_table = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}}
end
local languages = {"bash", "bibtex", "c", "clojure", "cmake", "comment", "commonlisp", "cpp", "css", "cue", "diff", "dockerfile", "elixir", "elm", "erlang", "fennel", "fortran", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "graphql", "hcl", "help", "hjson", "html", "http", "java", "javascript", "jq", "jsdoc", "json", "json5", "jsonc", "jsonnet", "julia", "kotlin", "latex", "llvm", "lua", "make", "markdown", "mermaid", "norg", "norg_meta", "norg_table", "passwd", "proto", "python", "ql", "query", "r", "regex", "rego", "rst", "rust", "scss", "sparql", "sql", "teal", "terraform", "toml", "tsx", "typescript", "vim", "vue", "yaml"}
configs.setup({ensure_installed = languages, highlight = {enable = true, disable = {}}, indent = {enable = true, disable = {}}, context_commentstring = {enable = true, enable_autocmd = false}})
do
  local queries_dir = string.format("%s/queries", vim.fn.stdpath("config"))
  local cue_dir = string.format("%s/cue", queries_dir)
  local cue_highlight_scm = string.format("%s/highlights.scm", cue_dir)
  if (vim.fn.empty(vim.fn.glob(cue_highlight_scm)) == 1) then
    vim.cmd(string.format("silent !mkdir -p %s", cue_dir))
    vim.cmd(string.format("silent !wget -O %s %s", cue_highlight_scm, "https://raw.githubusercontent.com/eonpatapon/tree-sitter-cue/main/queries/highlights.scm"))
  else
  end
end
local function ensure_installed()
  for _, lang in ipairs(languages) do
    vim.cmd(string.format("TSInstallSync! %s", lang))
  end
  return nil
end
return vim.api.nvim_create_user_command("TSInstallEnsure", ensure_installed, {})
