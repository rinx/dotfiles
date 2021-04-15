local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.cmd(fmt("silent !git clone https://github.com/%s/%s %s", user, repo, install_path))
    vim.cmd(fmt("packadd %s", repo))
  end
end

ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")

vim.g["aniseed#env"] = true
