---
name: babashka-clerk
description: Use Clerk from Babashka. Generate rich reports including Vega-Lite charts.
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
;; # Heading 1
;;
;; Body text here
```

Parts written as code are executed and the results are displayed together.

```clojure
(def fib (lazy-cat [0 1] (map + fib (rest fib))))
```

Reference: [Book of Clerk](https://book.clerk.vision/)


## Vega-Lite

On Clerk notes, you can draw graphs using Vega-Lite.

```clojure
(require '[nextjournal.clerk :as clerk])

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
