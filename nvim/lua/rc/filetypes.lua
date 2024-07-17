-- [nfnl] Compiled from fnl/rc/filetypes.fnl by https://github.com/Olical/nfnl, do not edit.
local function lsp_format()
  local ok_3f, val_or_err = pcall(vim.lsp.buf.format)
  if ok_3f then
    return vim.notify("Formatted.", vim.lsp.log_levels.INFO, {annote = "LSP format", skip_history = true})
  else
    return vim.notify(("An error occurred: " .. val_or_err), vim.lsp.log_levels.WARN, {annote = "LSP format"})
  end
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-filetype-detect", {clear = true})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf cue", group = group_5_auto, pattern = "*.cue"})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf fortran", group = group_5_auto, pattern = "*.nml,*.namelist"})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf jq", group = group_5_auto, pattern = "*.jq"})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf julia", group = group_5_auto, pattern = "*.jl"})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf rego", group = group_5_auto, pattern = "*.rego,*.rq"})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf terraform", group = group_5_auto, pattern = "*.tf,*.tfvars"})
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWinEnter"}, {command = "setf yaml.docker-compose", group = group_5_auto, pattern = "docker-compose.yaml"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-git-files", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "set bufhidden=delete", group = group_5_auto, pattern = "gitcommit,gitrebase"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-markdown", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=4", group = group_5_auto, pattern = "markdown"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-nix", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "nix"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-json", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "json"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-julia", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=4", group = group_5_auto, pattern = "julia"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-yaml", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "yaml"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-yaml", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "yaml"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-fennel", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "fennel"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl colorcolumn=80", group = group_5_auto, pattern = "fennel"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-lua", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "lua"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-clojure", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer><silent> <leader>K :<C-u>lua vim.lsp.buf.hover()<CR>", group = group_5_auto, pattern = "clojure"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl colorcolumn=80", group = group_5_auto, pattern = "clojure"})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.clj,*.cljc,*.cljs"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-go", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl colorcolumn=80", group = group_5_auto, pattern = "go"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl noexpandtab", group = group_5_auto, pattern = "go"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=4", group = group_5_auto, pattern = "go"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl tabstop=4", group = group_5_auto, pattern = "go"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl softtabstop=4", group = group_5_auto, pattern = "go"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "compiler go", group = group_5_auto, pattern = "go"})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.go"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-rego", {clear = true})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.rego,*.rq"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-rust", {clear = true})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.rs"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-kotlin", {clear = true})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.kt,*.kts"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-terraform", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "terraform"})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.tf,*.tfvars"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-typescript", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "setl shiftwidth=2", group = group_5_auto, pattern = "typescript"})
  vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = lsp_format, group = group_5_auto, pattern = "*.ts"})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-qf", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> j j", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> k k", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> 0 0", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> $ $", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> gj gj", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> gk gk", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> g0 g0", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> g$ g$", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer><silent>q :<C-u>q<CR>", group = group_5_auto, pattern = "qf"})
  vim.api.nvim_create_autocmd({"WinEnter"}, {command = "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif", group = group_5_auto, pattern = "*"})
end
local group_5_auto = vim.api.nvim_create_augroup("init-help", {clear = true})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> j j", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> k k", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> 0 0", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> $ $", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> gj gj", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> gk gk", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> g0 g0", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer> g$ g$", group = group_5_auto, pattern = "help"})
vim.api.nvim_create_autocmd({"FileType"}, {command = "nnoremap <buffer><silent>q :<C-u>q<CR>", group = group_5_auto, pattern = "help"})
return vim.api.nvim_create_autocmd({"WinEnter"}, {command = "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif", group = group_5_auto, pattern = "*"})
