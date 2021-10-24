(module rc.plugin.cmp
  {autoload {core aniseed.core
             nvim aniseed.nvim
             icon rc.icon
             util rc.util
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
  {:buffer :Buffer
   :calc :Calc
   :conjure :Conjure
   :emoji :Emoji
   :neorg :Neorg
   :nvim_lsp :LSP
   :path :Path
   :skkeleton :SKK
   :spell :Spell
   :treesitter :TS
   :vsnip :VSnip})

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
   {:<C-p> (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Insert})
    :<C-n> (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Insert})
    :<Up> (cmp.mapping.scroll_docs -4)
    :<Down> (cmp.mapping.scroll_docs 4)
    :<C-s> (cmp.mapping.complete)
    :<C-e> (cmp.mapping.close)
    :<CR> (cmp.mapping.confirm
            {:behavior cmp.ConfirmBehavior.Replace
             :select true})
    :<Tab> (fn [fallback]
             (if (cmp.visible)
               (cmp.select_next_item)
               (fallback)))}
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

;; neorg
(defn append-cmp-neorg []
  (let [ss []]
    (each [_ v (ipairs default-sources)]
      (table.insert ss v))
    (table.insert ss {:name :neorg})
    (cmp.setup.buffer
      {:sources ss})))
(augroup! init-cmp-neorg
          (autocmd! :FileType :norg (->viml! :append-cmp-neorg)))

;; autopairs
(when (util.loaded? :nvim-autopairs)
  (let [autopairs-cmp (require :nvim-autopairs.completion.cmp)]
    (autopairs-cmp.setup
      {:map_cr true
       :map_complete true})))
