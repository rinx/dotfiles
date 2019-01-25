{:user
 {:plugins
  [[refactor-nrepl "2.4.0"]
   [cider/cider-nrepl "0.20.0"]]
  :repl-options
  {:nrepl-middleware [cider.nrepl/wrap-complete
                      cider.nrepl/wrap-format
                      cider.nrepl/wrap-info
                      cider.nrepl/wrap-macroexpand
                      cider.nrepl/wrap-ns
                      cider.nrepl/wrap-out
                      cider.nrepl/wrap-spec
                      cider.nrepl/wrap-test
                      cider.nrepl/wrap-undef]}}}
