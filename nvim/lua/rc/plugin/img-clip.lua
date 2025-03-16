-- [nfnl] Compiled from fnl/rc/plugin/img-clip.fnl by https://github.com/Olical/nfnl, do not edit.
local clip = require("img-clip")
return clip.setup({default = {relative_to_current_file = true, prompt_for_file_name = false}, filetypes = {org = {template = "[[$FILE_PATH]]"}}})
