-- [nfnl] Compiled from fnl/rc/plugin/project.fnl by https://github.com/Olical/nfnl, do not edit.
local project = require("project_nvim")
return project.setup({ignore_lsp = {"efm"}, patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".nfnl.fnl"}, silent_chdir = false})
