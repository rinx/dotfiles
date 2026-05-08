---
name: clerk
description: Use Clerk from Babashka. Generate rich reports including Vega-Lite/Plotly charts, hiccup, tables, TeX and Images.
---

Here, Clerk refers to https://github.com/nextjournal/clerk.

# Preparation

## Create bb.edn

If additional libraries are needed, add them to the `:deps` map.

```clojure
{:deps
 {io.github.nextjournal/clerk {:mvn/version "0.18.1158"}
   ;; Declare required dependencies here
 }
 :tasks
 {clerk-build
  {:requires ([nextjournal.clerk :as clerk])
   :task (clerk/build! {:paths *command-line-args*})}}}
```

## Create notebooks directory

Create a directory to place the Clerk notes you will create.

    mkdir -p notebooks

# Usage

Clerk notes are created as Clojure code with filenames like `notebooks/*.clj`.
The basic syntax is Markdown, written in Clojure comment format.

```clojure
;; require nextjournal.clerk first.
(require '[nextjournal.clerk :as clerk])

;; # Heading 1
;;
;; Body text here
```

Parts written as code are executed and the results are displayed together.

```clojure
(def fib (lazy-cat [0 1] (map + fib (rest fib))))
```

Reference: [Book of Clerk](https://book.clerk.vision/)

## Viewer features

Clerk has a number of built-in viewers.
It is encouraged to use these features for effective visualizations.

### Vega-Lite and Plotly

### Vega-Lite

You can draw graphs using Vega-Lite.

```clojure
(clerk/vl {:width 650 :height 400 :data {:url "https://vega.github.io/vega-datasets/data/us-10m.json"
                                         :format {:type "topojson" :feature "counties"}}
           :transform [{:lookup "id" :from {:data {:url "https://vega.github.io/vega-datasets/data/unemployment.tsv"}
                                            :key "id" :fields ["rate"]}}]
           :projection {:type "albersUsa"} :mark "geoshape" :encoding {:color {:field "rate" :type "quantitative"}}
           :background "transparent"
           :embed/opts {:actions false}})
```

In this example, data is fetched from a specified URL, but you can also pass data directly to the `:data` key.

Reference: [Vega-Lite schema](https://vega.github.io/schema/vega-lite/v5.json)

### Plotly

Also you can draw graphs using Plotly.

```clojure
(clerk/plotly {:data [{:z [[1 2 3] [3 2 1]] :type "surface"}]
               :layout {:margin {:l 20 :r 0 :b 20 :t 20}
                        :paper_bgcolor "transparent"
                        :plot_bgcolor "transparent"}
               :config {:displayModeBar false
                        :displayLogo false}})
```

### Hiccup

You can write HTML elements using `hiccup` style.

```clojure
(clerk/html [:div "As Clojurians we " [:em "really"] " enjoy hiccup"])
```

### Tables

You can write table using `clerk/table`.

```clojure
(clerk/table {"odd numbers" [1 3]
              "even numbers" [2 4]}) ;; map of seqs
```

### TeX

You can write TeX.

```clojure
(clerk/tex "
\\begin{alignedat}{2}
  \\nabla\\cdot\\vec{E} = \\frac{\\rho}{\\varepsilon_0} & \\qquad \\text{Gauss' Law} \\\\
  \\nabla\\cdot\\vec{B} = 0 & \\qquad \\text{Gauss' Law ($\\vec{B}$ Fields)} \\\\
  \\nabla\\times\\vec{E} = -\\frac{\\partial \\vec{B}}{\\partial t} & \\qquad \\text{Faraday's Law} \\\\
  \\nabla\\times\\vec{B} = \\mu_0\\vec{J}+\\mu_0\\varepsilon_0\\frac{\\partial\\vec{E}}{\\partial t} & \\qquad \\text{Ampere's Law}
\\end{alignedat}
")
```

### Images

You can embed images using `clerk/image`

```clojure
(clerk/image "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/The_Sower.jpg/1510px-The_Sower.jpg")
```

## Static build of notes

Run the `clerk-build` task prepared in `bb.edn`.

    bb clerk-build ${path-to-notebook}

The build artifacts will be created in the `public` directory.

## Open browser and show notes using webserver

Use `/babashka-nrepl` skill to start nREPL server.

Send the following code to nREPL.

```clojure
(require '[nextjournal.clerk :as clerk])

(clerk/serve! {:browse true
               :watch-paths ["notebooks"]})
```
