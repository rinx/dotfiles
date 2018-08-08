{:user
 {:plugins
  [[refactor-nrepl "2.4.0-SNAPSHOT"]
   [cider/cider-nrepl "0.18.0"]
   [lein-kibit "0.1.5"]
   [jonase/eastwood "0.2.5"]]
  :dependencies
  [[org.clojure/tools.nrepl "0.2.12"]
   [cljfmt "0.6.0"]]
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
