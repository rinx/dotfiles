(module rc.plugin.devicons
  {autoload {devicon nvim-web-devicons}})

(devicon.setup
  {:override {:fnl {:icon ""
                    :color :#c2d94c
                    :name :Fennel}
              :hy {:icon ""
                   :color :#519aba
                   :name :Hy}
              :Makefile {:icon " "
                         :color :#6d8086
                         :name :Makefile}}})
