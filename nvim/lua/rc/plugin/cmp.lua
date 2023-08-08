-- [nfnl] Compiled from fnl/rc/plugin/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local cmp = require("cmp")
local autopairs_cmp = require("nvim-autopairs.completion.cmp")
local cmp_git = require("cmp_git")
local icon = autoload("rc.icon")
local icontab = icon.tab
local cmp_kinds = {Class = icontab.class, Color = icontab.color, Constant = icontab.pi, Constructor = icontab.tools, Enum = icontab.enum, EnumMember = icontab.atoz, Field = icontab.buffer, File = icontab["document-alt"], Folder = icontab["folder-open-alt"], Function = icontab["function-alt"], Interface = icontab.structure, Keyword = icontab.key, Method = icontab["function"], Module = icontab.cubes, Property = icontab.property, Snippet = icontab["code-braces"], Struct = icontab.struct, Reference = icontab.reference, Text = icontab.text, Unit = icontab.unit, Value = icontab["one-two-three"], Variable = icontab.cube, Operator = icontab["plus-minus"], Event = icontab.zap, TypeParameter = icontab.package}
local cmp_srcs = {buffer = "Buffer", calc = "Calc", cmdline = "CMD", git = "Git", conjure = "Conjure", emoji = "Emoji", neorg = "Neorg", nvim_lsp = "LSP", path = "Path", skkeleton = "SKK", spell = "Spell", treesitter = "TS", vsnip = "VSnip"}
local default_sources = {{name = "nvim_lsp"}, {name = "buffer"}, {name = "vsnip"}, {name = "treesitter"}, {name = "path"}, {name = "skkeleton"}, {name = "spell"}, {name = "calc"}, {name = "emoji"}}
local function _2_(entry, item)
  item.kind = ((core.get(cmp_kinds, item.kind) or "") .. " " .. item.kind)
  item.menu = (core.get(cmp_srcs, entry.source.name) or "")
  return item
end
local function _3_(fallback)
  if cmp.visible() then
    return cmp.select_next_item()
  else
    return fallback()
  end
end
local function _5_(args)
  return vim.fn["vsnip#anonymous"](args.body)
end
cmp.setup({formatting = {format = _2_}, mapping = {["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}), {"i", "c"}), ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}), {"i", "c"}), ["<Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}), ["<Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}), ["<C-s>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}), ["<C-e>"] = cmp.mapping(cmp.mapping.close(), {"i", "c"}), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}), ["<Tab>"] = _3_}, snippet = {expand = _5_}, sources = default_sources})
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})
cmp.setup.cmdline(":", {sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})
local function append_cmp_conjure()
  local ss = {}
  for _, v in ipairs(default_sources) do
    table.insert(ss, v)
  end
  table.insert(ss, {name = "conjure"})
  return cmp.setup.buffer({sources = ss})
end
do
  local group_5_auto = vim.api.nvim_create_augroup("init-cmp-conjure", {clear = true})
  vim.api.nvim_create_autocmd({"FileType"}, {callback = append_cmp_conjure, group = group_5_auto, pattern = "clojure"})
  vim.api.nvim_create_autocmd({"FileType"}, {callback = append_cmp_conjure, group = group_5_auto, pattern = "fennel"})
  vim.api.nvim_create_autocmd({"FileType"}, {callback = append_cmp_conjure, group = group_5_auto, pattern = "hy"})
end
do end (cmp.event):on("confirm_done", autopairs_cmp.on_confirm_done())
local function append_cmp_git()
  cmp_git.setup({})
  local ss = {}
  for _, v in ipairs(default_sources) do
    table.insert(ss, v)
  end
  table.insert(ss, {name = "git"})
  return cmp.setup.buffer({sources = ss})
end
local group_5_auto = vim.api.nvim_create_augroup("init-cmp-git", {clear = true})
return vim.api.nvim_create_autocmd({"FileType"}, {callback = append_cmp_git, group = group_5_auto, pattern = "gitcommit"})
