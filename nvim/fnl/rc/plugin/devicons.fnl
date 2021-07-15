(module rc.plugin.devicons
  {autoload {icon rc.icon
             devicon nvim-web-devicons}})

(devicon.setup
  {:override {:fnl {:icon icon.tab.lua
                    :color :#c2d94c
                    :name :Fennel}
              :hy {:icon icon.tab.python
                   :color :#519aba
                   :name :Hy}
              :Makefile {:icon icon.tab.large-m
                         :color :#6d8086
                         :name :Makefile}}})
