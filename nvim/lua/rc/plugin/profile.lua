-- [nfnl] Compiled from fnl/rc/plugin/profile.fnl by https://github.com/Olical/nfnl, do not edit.
local profile = require("profile")
if not (vim.NIL == vim.fn.getenv("NVIM_PROFILE")) then
  profile.instrument_autocmds()
  profile.instrument("*")
else
end
local function toggle_profile()
  if profile.is_recording() then
    profile.stop()
    local function _2_(filename)
      if filename then
        profile.export(filename)
        return vim.notify(string.format("Wrote %s", filename))
      else
        return nil
      end
    end
    return vim.ui.input({prompt = "Save profile to:", completion = "file", default = "profile.json"}, _2_)
  else
    return profile.start("*")
  end
end
return vim.api.nvim_create_user_command("ProfileToggle", toggle_profile, {})
