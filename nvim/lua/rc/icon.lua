-- [nfnl] Compiled from fnl/rc/icon.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local tab = {["vim-classic"] = "\238\159\133 ", vim = "\238\152\171 ", clojure = "\238\157\168 ", ["clojure-alt"] = "\238\157\170", lua = "\238\152\160 ", python = "\238\156\188", ["large-m"] = "\243\176\171\186", lock = "\239\128\163", ["code-braces"] = "\243\176\133\169 ", ["code-brackets"] = "\243\176\133\170 ", ["code-parentheses"] = "\243\176\133\178 ", ["code-tags"] = "\243\176\133\180 ", plus = "\239\129\167 ", ["plus-circle"] = "\239\129\149 ", ["plus-square"] = "\239\131\190 ", minus = "\239\129\168 ", ["minus-circle"] = "\239\129\150 ", ["minus-square"] = "\239\133\134 ", ["plus-minus"] = "\243\176\166\146", slash = "\238\136\150", branch = "\238\156\165", compare = "\238\156\168 ", merge = "\238\156\167", pullreq = "\238\156\166", ln = "\238\130\161", cn = "\238\130\163", meteor = "\238\141\170 ", zap = "\238\128\138", lightning = "\238\140\149 ", tree = "\239\134\187 ", ["tree-alt"] = "\238\136\156 ", info = "\239\132\169", ["info-circle"] = "\239\129\154 ", leaf = "\239\129\172 ", fire = "\243\176\136\184", heart = "\239\128\132 ", ["heart-o"] = "\239\130\138 ", sparkles = "\243\176\153\180 ", ban = "\239\129\158 ", circle = "\226\151\143", recording = "\238\174\167 ", asterisk = "\239\129\169 ", exclam = "\238\128\137", ["exclam-circle"] = "\239\129\170 ", ["exclam-tri"] = "\239\129\177 ", times = "\239\128\141", close = "\243\176\133\150", ["close-box"] = "\243\176\133\151 ", ["close-box-alt"] = "\243\176\133\152 ", ["close-octagon"] = "\243\176\133\156 ", ["close-octagon-alt"] = "\243\176\133\157 ", bug = "\239\134\136 ", check = "\239\128\140 ", ["check-thin"] = "\238\170\178 ", ["check-circle"] = "\239\129\152 ", ["check-square"] = "\239\133\138 ", pencil = "\239\145\136 ", ["pencil-square"] = "\239\129\132 ", text = "\238\152\146", ["text-alt"] = "\243\176\166\168 ", ["format-title"] = "\243\176\151\180", directory = "\239\144\147 ", document = "\243\176\167\174 ", ["document-alt"] = "\239\133\155 ", dots = "\243\176\135\152", config = "\238\136\143 ", calc = "\239\135\172 ", paste = "\239\144\169 ", spellcheck = "\243\176\147\134 ", search = "\239\128\130 ", ["search-alt"] = "\239\144\162 ", ["zoom-plus"] = "\239\128\142 ", ["zoom-minus"] = "\239\128\144 ", glasses = "\243\176\138\170 ", sunglasses = "\238\137\133 ", scope = "\239\145\171 ", stackoverflow = "\239\133\172 ", play = "\239\129\139 ", ["play-circle"] = "\239\133\132 ", ["play-circle-alt"] = "\239\128\157 ", folder = "\238\151\191 ", ["folder-open"] = "\238\151\190 ", ["folder-open-alt"] = "\239\132\149 ", cursor = "\243\176\135\128", ["cursor-text"] = "\239\137\134", ["function"] = "\198\146", ["function-alt"] = "\239\130\154", pi = "\238\136\172 ", hierarchy = "\238\174\186 ", structure = "\239\131\168 ", property = "\238\152\164 ", ["one-two-three"] = "\243\176\142\160 ", enumerated = "\239\145\146 ", ["level-down"] = "\239\133\137", ["level-up"] = "\239\133\136", ["subdirectory-arrow-left"] = "\243\176\152\140", ["subdirectory-arrow-right"] = "\243\176\152\141", terminal = "\238\158\149 ", ["terminal-alt"] = "\239\132\160 ", ["terminal-alt2"] = "\239\146\137 ", package = "\243\176\143\151 ", ["package-opened"] = "\243\176\143\150 ", ["package-alt"] = "\239\146\135 ", cube = "\239\134\178 ", cubes = "\239\134\179 ", comment = "\239\129\181 ", ["comment-alt"] = "\243\176\141\168 ", lightbulb = "\238\169\161", ["lightbulb-alt"] = "\243\176\140\182", ["lightbulb-on"] = "\243\177\169\142 ", ["lightbulb-on-alt"] = "\243\176\155\168 ", github = "\239\132\147 ", ["beer-fa"] = "\239\131\188 ", ["beer-mdi"] = "\243\176\130\152", ["quote-l"] = "\239\132\141 ", ["quote-r"] = "\239\132\142 ", tag = "\239\128\171 ", tags = "\239\128\172 ", hashtag = "\239\138\146 ", star = "\239\128\133 ", ["star-alt"] = "\239\140\145 ", compas = "\243\176\134\140 ", watch = "\243\176\162\151", symlink = "\239\146\129 ", ["diff-add"] = "\239\145\151 ", ["diff-igored"] = "\239\145\180 ", ["diff-modified"] = "\239\145\153 ", ["diff-removed"] = "\239\145\152 ", ["diff-renamed"] = "\239\145\154 ", class = "\238\173\155 ", color = "\238\136\171 ", tools = "\238\136\143 ", enum = "\239\133\162 ", atoz = "\239\133\157 ", buffer = "\243\176\132\182 ", key = "\243\176\140\139 ", struct = "\243\176\140\151 ", reference = "\243\176\136\135 ", unit = "\243\176\145\173 ", ["sticky-note"] = "\239\137\137 ", server = "\239\136\179 ", opensuse = "\239\140\148 ", dinosaur = "\240\159\166\149", ghost = "\243\176\138\160 ", whale = "\243\176\161\168 ", ruby = "\239\136\153 ", ["number-0"] = "\243\176\142\161 ", ["number-1"] = "\243\176\142\164 ", ["number-2"] = "\243\176\142\167 ", ["number-3"] = "\243\176\142\170 ", ["number-4"] = "\243\176\142\173 ", ["number-5"] = "\243\176\142\177 ", ["number-6"] = "\243\176\142\179 ", ["number-7"] = "\243\176\142\182 ", ["number-8"] = "\243\176\142\185 ", ["number-9"] = "\243\176\142\188 ", ["number-9-plus"] = "\243\176\142\191 ", ["number-0-alt"] = "\243\176\142\163 ", ["number-1-alt"] = "\243\176\142\166 ", ["number-2-alt"] = "\243\176\142\169 ", ["number-3-alt"] = "\243\176\142\172 ", ["number-4-alt"] = "\243\176\142\174 ", ["number-5-alt"] = "\243\176\142\176 ", ["number-6-alt"] = "\243\176\142\181 ", ["number-7-alt"] = "\243\176\142\184 ", ["number-8-alt"] = "\243\176\142\187 ", ["number-9-alt"] = "\243\176\142\190 ", ["number-9-plus-alt"] = "\243\176\143\129 ", ["number-0-mult"] = "\243\176\188\142 ", ["number-1-mult"] = "\243\176\188\143 ", ["number-2-mult"] = "\243\176\188\144 ", ["number-3-mult"] = "\243\176\188\145 ", ["number-4-mult"] = "\243\176\188\146 ", ["number-5-mult"] = "\243\176\188\147 ", ["number-6-mult"] = "\243\176\188\148 ", ["number-7-mult"] = "\243\176\188\149 ", ["number-8-mult"] = "\243\176\188\150 ", ["number-9-mult"] = "\243\176\188\151 ", ["number-9-plus-mult"] = "\243\176\188\152 ", ["arrow-u"] = "\239\129\162 ", ["arrow-d"] = "\239\129\163 ", ["arrow-l"] = "\239\129\160 ", ["arrow-r"] = "\239\129\161 ", ["arrow-u-alt"] = "\239\133\182", ["arrow-d-alt"] = "\239\133\181", ["arrow-l-alt"] = "\239\133\183 ", ["arrow-r-alt"] = "\239\133\184 ", ["keyboard-tab"] = "\243\176\140\146 ", ["arrow-collapse-u"] = "\243\176\158\149 ", ["arrow-collapse-d"] = "\243\176\158\146 ", ["arrow-collapse-l"] = "\243\176\158\147 ", ["arrow-collapse-r"] = "\243\176\158\148 ", ["arrow-expand-u"] = "\243\176\158\153 ", ["arrow-expand-d"] = "\243\176\158\150 ", ["arrow-expand-l"] = "\243\176\158\151 ", ["arrow-expand-r"] = "\243\176\158\152 ", precedes = "\226\134\144", extends = "\226\134\146", trail = "\194\183", nbsp = "\226\144\163", ["fold-open"] = "\239\145\188", ["fold-closed"] = "\239\145\160", rquot = "\226\157\175", ["chevron-u"] = "\239\129\183 ", ["chevron-d"] = "\239\129\184 ", ["chevron-l"] = "\239\129\147", ["chevron-r"] = "\239\129\148", ["round-l"] = "\238\130\180", ["round-r"] = "\238\130\182", ["tri-l"] = "\238\130\176", ["tri-r"] = "\238\130\178", ["ltri-l"] = "\238\130\184", ["ltri-r"] = "\238\130\186", ["utri-l"] = "\238\130\188 ", ["utri-r"] = "\238\130\190", ["pix-l"] = "\238\131\134 ", ["pix-r"] = "\238\131\135 "}
local lazy_nvim_ui_icons = {loaded = "\226\151\143", not_loaded = "\226\151\139", cmd = "\243\176\134\141 ", config = "\239\128\147", event = "\238\128\138", ft = "\239\128\150 ", init = "\239\128\147 ", keys = "\239\132\156 ", plugin = "\239\146\135 ", runtime = "\238\159\133 ", source = "\239\132\161 ", start = "\239\129\172 ", task = "\239\128\140 ", lazy = "\243\176\146\178 ", list = {"\226\151\143", "\226\158\156", "\226\152\133", "\226\128\146"}}
local popfix_border_chars = {TOP_LEFT = "\226\148\140", TOP_RIGHT = "\226\148\144", MID_HORIZONTAL = "\226\148\128", MID_VERTICAL = "\226\148\130", BOTTOM_LEFT = "\226\148\148", BOTTOM_RIGHT = "\226\148\152"}
local popfix_border_chars_alt = {TOP_LEFT = "\226\149\173", TOP_RIGHT = "\226\149\174", MID_HORIZONTAL = "\226\148\128", MID_VERTICAL = "\226\148\130", BOTTOM_LEFT = "\226\149\176", BOTTOM_RIGHT = "\226\149\175"}
local progress = {"\238\184\128", "\238\184\129", "\238\184\130", "\238\184\131", "\238\184\132", "\238\184\133"}
local spinners = {"\238\184\134", "\238\184\135", "\238\184\136", "\238\184\137", "\238\184\138", "\238\184\139"}
local brailles = {"\226\160\128", "\226\160\129", "\226\160\130", "\226\160\131", "\226\160\132", "\226\160\133", "\226\160\134", "\226\160\135", "\226\161\128", "\226\161\129", "\226\161\130", "\226\161\131", "\226\161\132", "\226\161\133", "\226\161\134", "\226\161\135", "\226\160\136", "\226\160\137", "\226\160\138", "\226\160\139", "\226\160\140", "\226\160\141", "\226\160\142", "\226\160\143", "\226\161\136", "\226\161\137", "\226\161\138", "\226\161\139", "\226\161\140", "\226\161\141", "\226\161\142", "\226\161\143", "\226\160\144", "\226\160\145", "\226\160\146", "\226\160\147", "\226\160\148", "\226\160\149", "\226\160\150", "\226\160\151", "\226\161\144", "\226\161\145", "\226\161\146", "\226\161\147", "\226\161\148", "\226\161\149", "\226\161\150", "\226\161\151", "\226\160\152", "\226\160\153", "\226\160\154", "\226\160\155", "\226\160\156", "\226\160\157", "\226\160\158", "\226\160\159", "\226\161\152", "\226\161\153", "\226\161\154", "\226\161\155", "\226\161\156", "\226\161\157", "\226\161\158", "\226\161\159", "\226\160\160", "\226\160\161", "\226\160\162", "\226\160\163", "\226\160\164", "\226\160\165", "\226\160\166", "\226\160\167", "\226\161\160", "\226\161\161", "\226\161\162", "\226\161\163", "\226\161\164", "\226\161\165", "\226\161\166", "\226\161\167", "\226\160\168", "\226\160\169", "\226\160\170", "\226\160\171", "\226\160\172", "\226\160\173", "\226\160\174", "\226\160\175", "\226\161\168", "\226\161\169", "\226\161\170", "\226\161\171", "\226\161\172", "\226\161\173", "\226\161\174", "\226\161\175", "\226\160\176", "\226\160\177", "\226\160\178", "\226\160\179", "\226\160\180", "\226\160\181", "\226\160\182", "\226\160\183", "\226\161\176", "\226\161\177", "\226\161\178", "\226\161\179", "\226\161\180", "\226\161\181", "\226\161\182", "\226\161\183", "\226\160\184", "\226\160\185", "\226\160\186", "\226\160\187", "\226\160\188", "\226\160\189", "\226\160\190", "\226\160\191", "\226\161\184", "\226\161\185", "\226\161\186", "\226\161\187", "\226\161\188", "\226\161\189", "\226\161\190", "\226\161\191", "\226\162\128", "\226\162\129", "\226\162\130", "\226\162\131", "\226\162\132", "\226\162\133", "\226\162\134", "\226\162\135", "\226\163\128", "\226\163\129", "\226\163\130", "\226\163\131", "\226\163\132", "\226\163\133", "\226\163\134", "\226\163\135", "\226\162\136", "\226\162\137", "\226\162\138", "\226\162\139", "\226\162\140", "\226\162\141", "\226\162\142", "\226\162\143", "\226\163\136", "\226\163\137", "\226\163\138", "\226\163\139", "\226\163\140", "\226\163\141", "\226\163\142", "\226\163\143", "\226\162\144", "\226\162\145", "\226\162\146", "\226\162\147", "\226\162\148", "\226\162\149", "\226\162\150", "\226\162\151", "\226\163\144", "\226\163\145", "\226\163\146", "\226\163\147", "\226\163\148", "\226\163\149", "\226\163\150", "\226\163\151", "\226\162\152", "\226\162\153", "\226\162\154", "\226\162\155", "\226\162\156", "\226\162\157", "\226\162\158", "\226\162\159", "\226\163\152", "\226\163\153", "\226\163\154", "\226\163\155", "\226\163\156", "\226\163\157", "\226\163\158", "\226\163\159", "\226\162\160", "\226\162\161", "\226\162\162", "\226\162\163", "\226\162\164", "\226\162\165", "\226\162\166", "\226\162\167", "\226\163\160", "\226\163\161", "\226\163\162", "\226\163\163", "\226\163\164", "\226\163\165", "\226\163\166", "\226\163\167", "\226\162\168", "\226\162\169", "\226\162\170", "\226\162\171", "\226\162\172", "\226\162\173", "\226\162\174", "\226\162\175", "\226\163\168", "\226\163\169", "\226\163\170", "\226\163\171", "\226\163\172", "\226\163\173", "\226\163\174", "\226\163\175", "\226\162\176", "\226\162\177", "\226\162\178", "\226\162\179", "\226\162\180", "\226\162\181", "\226\162\182", "\226\162\183", "\226\163\176", "\226\163\177", "\226\163\178", "\226\163\179", "\226\163\180", "\226\163\181", "\226\163\182", "\226\163\183", "\226\162\184", "\226\162\185", "\226\162\186", "\226\162\187", "\226\162\188", "\226\162\189", "\226\162\190", "\226\162\191", "\226\163\184", "\226\163\185", "\226\163\186", "\226\163\187", "\226\163\188", "\226\163\189", "\226\163\190", "\226\163\191"}
local function pos__3ebraille(...)
  local __3eidx
  local function _4_(_2_)
    local _arg_3_ = _2_
    local x = _arg_3_[1]
    local y = _arg_3_[2]
    return ((2 ^ y) * (16 ^ x))
  end
  __3eidx = _4_
  local function _5_(acc, x)
    return (acc + x)
  end
  return brailles[core.inc(core.reduce(_5_, 0, core.map(__3eidx, {...})))]
end
return {tab = tab, ["lazy-nvim-ui-icons"] = lazy_nvim_ui_icons, ["popfix-border-chars"] = popfix_border_chars, ["popfix-border-chars-alt"] = popfix_border_chars_alt, progress = progress, spinners = spinners, brailles = brailles, ["pos->braille"] = pos__3ebraille}