-- [nfnl] fnl/rc/plugin/img-clip.fnl
local clip = require("img-clip")
return clip.setup({default = {relative_to_current_file = true, prompt_for_file_name = false}, filetypes = {org = {template = "[[$FILE_PATH]]"}}})
