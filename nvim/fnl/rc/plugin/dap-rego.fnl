(local {: autoload} (require :nfnl.module))

(local dap-rego (require :dap-rego))

(dap-rego.setup
  {:regal
   {:path :regal-debug}})
