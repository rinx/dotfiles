(module rc.plugin.cmp
  {autoload {core aniseed.core
             nvim aniseed.nvim
             icon rc.icon
             cmp cmp}
   require-macros [rc.macros]})

(def- icontab icon.tab)
(def- cmp-kinds
  {:Class icontab.lsp-class
   :Color icontab.lsp-color
   :Constant icontab.lsp-constant
   :Constructor icontab.lsp-constructor
   :Enum icontab.lsp-enum
   :EnumMember icontab.lsp-enummember
   :Field icontab.lsp-field
   :File icontab.lsp-file
   :Folder icontab.lsp-folder
   :Function icontab.lsp-function
   :Interface icontab.lsp-interface
   :Keyword icontab.lsp-keyword
   :Method icontab.lsp-method
   :Module icontab.lsp-module
   :Property icontab.lsp-property
   :Snippet icontab.lsp-snippet
   :Struct icontab.lsp-struct
   :Reference icontab.lsp-reference
   :Text icontab.lsp-text
   :Unit icontab.lsp-unit
   :Value icontab.lsp-value
   :Variable icontab.lsp-variable
   :Operator icontab.lsp-operator
   :Event icontab.lsp-event
   :TypeParameter icontab.lsp-typeparameter})

(def- default-sources
  [{:name :buffer}
   {:name :calc}
   {:name :emoji}
   {:name :nvim_lsp}
   {:name :path}
   {:name :vsnip}])

(cmp.setup
  {:formatting
   {:format (fn [_ item]
              (set item.kind
                   (.. (or (core.get cmp-kinds item.kind) "")
                       " " item.kind))
              item)}
   :mapping
   {:<C-p> (cmp.mapping.select_prev_item)
    :<C-n> (cmp.mapping.select_next_item)
    :<Up> (cmp.mapping.scroll_docs -4)
    :<Down> (cmp.mapping.scroll_docs 4)
    :<C-s> (cmp.mapping.complete)
    :<C-e> (cmp.mapping.close)
    :<CR> (cmp.mapping.confirm
            {:behavior cmp.ConfirmBehavior.Insert
             :select true})}
   :snippet
   {:expand (fn [args]
              (vim.fn.vsnip#anonymous args.body))}
   :sources default-sources})

;; conjure
(defn init-cmp-conjure []
  (let [ss []]
    (each [_ v (ipairs default-sources)]
      (table.insert ss v))
    (table.insert ss {:name :conjure})
    (cmp.setup.buffer
      {:sources ss})))
(augroup init-cmp-conjure
         (autocmd :FileType :clojure (->viml :init-cmp-conjure)))
