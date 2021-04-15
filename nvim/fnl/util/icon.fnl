(module util.icon)

(def tab
  {:vim-classic ""
   :vim ""
   :clojure ""
   :clojure-alt ""
   :lua ""
   :lock ""
   :plus ""
   :plus-circle ""
   :plus-square ""
   :minus ""
   :minus-circle ""
   :minus-square ""
   :branch ""
   :compare ""
   :merge ""
   :pullreq ""
   :ln ""
   :cn ""
   :zap ""
   :info ""
   :leaf ""
   :heart ""
   :heart-o ""
   :ban ""
   :circle "●"
   :asterisk ""
   :exclam ""
   :exclam-circle ""
   :exclam-tri ""
   :times ""
   :close ""
   :check ""
   :check-thin ""
   :check-circle ""
   :check-square ""
   :pencil ""
   :pencil-square ""
   :text ""
   :document ""
   :dots ""
   :calc ""
   :folder ""
   :folder-open ""
   :cursor ""
   :cursor-text "﫦"
   :level-down ""
   :level-up ""
   :terminal ""
   :cube ""
   :comment ""
   :github ""
   :beer-fa ""
   :beer-mdi ""
   :quote-l ""
   :quote-r ""
   :symlink ""
   :diff-add ""
   :diff-igored ""
   :diff-modified ""
   :diff-removed ""
   :diff-renamed ""
   :arrow-u ""
   :arrow-d ""
   :arrow-l ""
   :arrow-r ""
   :chevron-u ""
   :chevron-d ""
   :chevron-l ""
   :chevron-r ""
   :round-l ""
   :round-r ""
   :tri-l ""
   :tri-r ""
   :ltri-l ""
   :ltri-r ""
   :utri-l ""
   :utri-r ""
   :pix-l ""
   :pix-r ""})

(let [devicon (require :nvim-web-devicons)]
  (devicon.setup {:override {:fnl {:icon ""
                                   :color "#51a0cf"
                                   :name "Fennel"}
                             :Makefile {:icon ""
                                        :color "#6d8086"
                                        :name "Makefile"}
                             :markdown {:icon ""
                                        :color "#519aba"
                                        :name "Markdown"}
                             :md {:icon ""
                                  :color "#519aba"
                                  :name "Md"}
                             :mdx {:icon ""
                                   :color "#519aba"
                                   :name "Mdx"}}}))
