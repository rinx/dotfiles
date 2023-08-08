-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local lazypath = (vim.fn.stdpath("data") .. "/lazy")
local function ensure(user, repo)
  local install_path = string.format("%s/%s", lazypath, repo)
  if (vim.fn.empty(vim.fn.glob(install_path)) > 1) then
    vim.api.nvim_command(string.format("!git clone --filter=blob:none --single-branch https://github.com/%s/%s %s", user, repo, install_path))
  else
  end
  return (vim.opt.runtimepath):prepend(install_path)
end
ensure("folke", "lazy.nvim")
ensure("Olical", "nfnl")
return require("rc.init")
