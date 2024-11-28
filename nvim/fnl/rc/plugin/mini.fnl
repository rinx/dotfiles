(let [align (require :mini.align)]
  (align.setup))

(let [operators (require :mini.operators)]
  (operators.setup
    {:replace {:prefix :X
               :reindent_linewise true}}))

(let [pairs (require :mini.pairs)]
  (pairs.setup))

(let [surround (require :mini.surround)]
  (surround.setup
    {:mappings
     {:highlight ""}}))

(let [trailspace (require :mini.trailspace)]
  (trailspace.setup))
