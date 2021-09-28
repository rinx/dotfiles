(module rc.plugin.cmp
  {autoload {core aniseed.core
             nvim aniseed.nvim
             icon rc.icon
             cmp cmp}
   require-macros [rc.macros]})

(def- icontab icon.tab)
(def- cmp-kinds
  {:Class icontab.class
   :Color icontab.color
   :Constant icontab.pi
   :Constructor icontab.tools
   :Enum icontab.enum
   :EnumMember icontab.atoz
   :Field icontab.buffer
   :File icontab.document-alt
   :Folder icontab.folder-open-alt
   :Function icontab.function-alt
   :Interface icontab.structure
   :Keyword icontab.key
   :Method icontab.function
   :Module icontab.cubes
   :Property icontab.property
   :Snippet icontab.code-braces
   :Struct icontab.struct
   :Reference icontab.reference
   :Text icontab.text
   :Unit icontab.unit
   :Value icontab.one-two-three
   :Variable icontab.cube
   :Operator icontab.plus-minus
   :Event icontab.zap
   :TypeParameter icontab.package})

(def- cmp-srcs
  {:buffer "[Buffer]"
   :calc "[Calc]"
   :conjure "[Conjure]"
   :emoji "[Emoji]"
   :nvim_lsp "[LSP]"
   :path "[Path]"
   :skkeleton "[skkeleton]"
   :spell "[Spell]"
   :treesitter "[TS]"
   :vsnip "[VSnip]"})

(def- default-sources
  [{:name :nvim_lsp}
   {:name :buffer}
   {:name :vsnip}
   {:name :treesitter}
   {:name :path}
   {:name :skkeleton}
   {:name :spell}
   {:name :calc}
   {:name :emoji}])

(cmp.setup
  {:formatting
   {:format (fn [entry item]
              (set item.kind
                   (.. (or (core.get cmp-kinds item.kind) "")
                       " " item.kind))
              (set item.menu (or (core.get cmp-srcs entry.source.name) ""))
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
(defn append-cmp-conjure []
  (let [ss []]
    (each [_ v (ipairs default-sources)]
      (table.insert ss v))
    (table.insert ss {:name :conjure})
    (cmp.setup.buffer
      {:sources ss})))
(augroup! init-cmp-conjure
          (autocmd! :FileType :clojure (->viml! :append-cmp-conjure))
          (autocmd! :FileType :fennel (->viml! :append-cmp-conjure))
          (autocmd! :FileType :hy (->viml! :append-cmp-conjure)))
