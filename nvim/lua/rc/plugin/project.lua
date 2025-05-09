-- [nfnl] fnl/rc/plugin/project.fnl
local project = require("project_nvim")
return project.setup({ignore_lsp = {"efm"}, patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".nfnl.fnl"}, silent_chdir = false})
