local execute = vim.api.nvim_command
local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/lazy"
local fmt = string.format

function ensure (user, repo)
  local install_path = fmt("%s/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone --filter=blob:none --single-branch https://github.com/%s/%s %s", user, repo, install_path))
  end
  vim.opt.runtimepath:prepend(install_path)
end

ensure("folke", "lazy.nvim")
ensure("Olical", "aniseed")

vim.g["aniseed#env"] = {
  module = "rc.init",
  compile = true,
}
