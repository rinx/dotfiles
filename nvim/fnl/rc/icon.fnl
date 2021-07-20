(module rc.icon
  {autoload {core aniseed.core}})

(def tab
  {:vim-classic " "
   :vim " "
   :clojure " "
   :clojure-alt ""
   :lua " "
   :python ""
   :large-m " "
   :lock ""
   :code-braces " "
   :code-brackets " "
   :code-parentheses " "
   :code-tags " "
   :plus " "
   :plus-circle " "
   :plus-square " "
   :minus " "
   :minus-circle " "
   :minus-square " "
   :plus-minus " "
   :slash ""
   :branch ""
   :compare " "
   :merge ""
   :pullreq ""
   :ln ""
   :cn ""
   :meteor " "
   :zap ""
   :lightning " "
   :tree " "
   :tree-alt " "
   :info ""
   :info-circle " "
   :leaf " "
   :fire " "
   :heart " "
   :heart-o " "
   :sparkles " "
   :ban " "
   :circle "●"
   :asterisk " "
   :exclam ""
   :exclam-circle " "
   :exclam-circle-alt "𥉉"
   :exclam-tri " "
   :exclam-tri-alt " "
   :exclam-box " "
   :exclam-octagon " "
   :exclam-octagram "ﱥ"
   :exclam-comment " "
   :exclam-comment-alt " "
   :times ""
   :close ""
   :close-box " "
   :close-box-alt " "
   :close-octagon " "
   :close-octagon-alt " "
   :bug " "
   :check " "
   :check-thin " "
   :check-circle " "
   :check-square " "
   :pencil " "
   :pencil-square " "
   :text ""
   :text-alt ""
   :format-title "﫳"
   :document " "
   :document-alt " "
   :dots ""
   :config " "
   :calc " "
   :paste " "
   :spellcheck "暈"
   :search " "
   :search-alt " "
   :zoom-plus " "
   :zoom-minus " "
   :glasses " "
   :sunglasses "履"
   :scope " "
   :stackoverflow " "
   :play " "
   :play-circle " "
   :play-circle-alt " "
   :folder " "
   :folder-open " "
   :cursor ""
   :cursor-text "﫦"
   :function "ƒ"
   :function-alt ""
   :pi " "
   :hierarchy "פּ"
   :property ""
   :one-two-three " "
   :enumerated " "
   :level-down ""
   :level-up ""
   :subdirectory-arrow-left "﬋"
   :subdirectory-arrow-right "﬌"
   :terminal " "
   :terminal-alt " "
   :terminal-alt2 " "
   :package " "
   :package-opened " "
   :package-alt " "
   :package-moving " "
   :cube " "
   :cubes " "
   :comment " "
   :comment-alt " "
   :alarm-light "ﲍ"
   :lightbulb ""
   :lightbulb-alt ""
   :lightbulb-on "ﯦ"
   :lightbulb-on-alt "ﯧ"
   :github " "
   :beer-fa " "
   :beer-mdi ""
   :quote-l " "
   :quote-r " "
   :tag " "
   :tags " "
   :hashtag " "
   :star " "
   :star-alt " "
   :compas " "
   :watch " "
   :symlink " "
   :diff-add " "
   :diff-igored " "
   :diff-modified " "
   :diff-removed " "
   :diff-renamed " "
   :number-0 " "
   :number-1 " "
   :number-2 " "
   :number-3 " "
   :number-4 " "
   :number-5 " "
   :number-6 " "
   :number-7 " "
   :number-8 " "
   :number-9 " "
   :number-9-plus " "
   :number-0-alt " "
   :number-1-alt " "
   :number-2-alt " "
   :number-3-alt " "
   :number-4-alt " "
   :number-5-alt " "
   :number-6-alt " "
   :number-7-alt " "
   :number-8-alt " "
   :number-9-alt " "
   :number-9-plus-alt " "
   :number-0-mult " "
   :number-1-mult " "
   :number-2-mult " "
   :number-3-mult " "
   :number-4-mult " "
   :number-5-mult " "
   :number-6-mult " "
   :number-7-mult " "
   :number-8-mult " "
   :number-9-mult " "
   :number-9-plus-mult " "
   :arrow-u " "
   :arrow-d " "
   :arrow-l " "
   :arrow-r " "
   :arrow-u-alt ""
   :arrow-d-alt ""
   :arrow-l-alt " "
   :arrow-r-alt " "
   :keyboard-tab " "
   :arrow-collapse-u "ﲓ"
   :arrow-collapse-d "ﲐ"
   :arrow-collapse-l "ﲑ"
   :arrow-collapse-r "ﲒ"
   :arrow-expand-u "ﲗ"
   :arrow-expand-d "ﲔ"
   :arrow-expand-l "ﲕ"
   :arrow-expand-r "ﲖ"
   :precedes "←"
   :extends "→"
   :trail "·"
   :nbsp "␣"
   :fold-open ""
   :fold-closed ""
   :rquot "❯"
   :chevron-u " "
   :chevron-d " "
   :chevron-l ""
   :chevron-r ""
   :round-l ""
   :round-r ""
   :tri-l ""
   :tri-r ""
   :ltri-l ""
   :ltri-r ""
   :utri-l " "
   :utri-r ""
   :pix-l " "
   :pix-r " "})

(def popfix-border-chars
  {:TOP_LEFT "┌"
   :TOP_RIGHT "┐"
   :MID_HORIZONTAL "─"
   :MID_VERTICAL "│"
   :BOTTOM_LEFT "└"
   :BOTTOM_RIGHT "┘"})

(def popfix-border-chars-alt
  {:TOP_LEFT "╭"
   :TOP_RIGHT "╮"
   :MID_HORIZONTAL "─"
   :MID_VERTICAL "│"
   :BOTTOM_LEFT "╰"
   :BOTTOM_RIGHT "╯"})

(def brailles
  ["⠀" "⠁" "⠂" "⠃" "⠄" "⠅" "⠆" "⠇" "⡀" "⡁" "⡂" "⡃" "⡄" "⡅" "⡆" "⡇"
   "⠈" "⠉" "⠊" "⠋" "⠌" "⠍" "⠎" "⠏" "⡈" "⡉" "⡊" "⡋" "⡌" "⡍" "⡎" "⡏"
   "⠐" "⠑" "⠒" "⠓" "⠔" "⠕" "⠖" "⠗" "⡐" "⡑" "⡒" "⡓" "⡔" "⡕" "⡖" "⡗"
   "⠘" "⠙" "⠚" "⠛" "⠜" "⠝" "⠞" "⠟" "⡘" "⡙" "⡚" "⡛" "⡜" "⡝" "⡞" "⡟"
   "⠠" "⠡" "⠢" "⠣" "⠤" "⠥" "⠦" "⠧" "⡠" "⡡" "⡢" "⡣" "⡤" "⡥" "⡦" "⡧"
   "⠨" "⠩" "⠪" "⠫" "⠬" "⠭" "⠮" "⠯" "⡨" "⡩" "⡪" "⡫" "⡬" "⡭" "⡮" "⡯"
   "⠰" "⠱" "⠲" "⠳" "⠴" "⠵" "⠶" "⠷" "⡰" "⡱" "⡲" "⡳" "⡴" "⡵" "⡶" "⡷"
   "⠸" "⠹" "⠺" "⠻" "⠼" "⠽" "⠾" "⠿" "⡸" "⡹" "⡺" "⡻" "⡼" "⡽" "⡾" "⡿"
   "⢀" "⢁" "⢂" "⢃" "⢄" "⢅" "⢆" "⢇" "⣀" "⣁" "⣂" "⣃" "⣄" "⣅" "⣆" "⣇"
   "⢈" "⢉" "⢊" "⢋" "⢌" "⢍" "⢎" "⢏" "⣈" "⣉" "⣊" "⣋" "⣌" "⣍" "⣎" "⣏"
   "⢐" "⢑" "⢒" "⢓" "⢔" "⢕" "⢖" "⢗" "⣐" "⣑" "⣒" "⣓" "⣔" "⣕" "⣖" "⣗"
   "⢘" "⢙" "⢚" "⢛" "⢜" "⢝" "⢞" "⢟" "⣘" "⣙" "⣚" "⣛" "⣜" "⣝" "⣞" "⣟"
   "⢠" "⢡" "⢢" "⢣" "⢤" "⢥" "⢦" "⢧" "⣠" "⣡" "⣢" "⣣" "⣤" "⣥" "⣦" "⣧"
   "⢨" "⢩" "⢪" "⢫" "⢬" "⢭" "⢮" "⢯" "⣨" "⣩" "⣪" "⣫" "⣬" "⣭" "⣮" "⣯"
   "⢰" "⢱" "⢲" "⢳" "⢴" "⢵" "⢶" "⢷" "⣰" "⣱" "⣲" "⣳" "⣴" "⣵" "⣶" "⣷"
   "⢸" "⢹" "⢺" "⢻" "⢼" "⢽" "⢾" "⢿" "⣸" "⣹" "⣺" "⣻" "⣼" "⣽" "⣾" "⣿"])

; ; => "⠱"
; (pos->braille [0 0]
;               [1 1]
;               [1 2])
(defn pos->braille [...]
  (let [->idx (fn [[x y]]
                ; returns an index to enable specified place (x, y) of braille.
                ; x: [0-1], y: [0-3]"
                (* (^ 2 y) (^ 16 x)))]
    (->> [...]
         (core.map ->idx)
         (core.reduce (fn [acc x]
                        (+ acc x)) 0)
         (core.inc)
         (. brailles))))