(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local cmp (require :cmp))
(local cmp-git (require :cmp_git))

(local icon (autoload :rc.icon))
(import-macros {: map! : augroup!} :rc.macros)

(local icontab icon.tab)

(local cmp-kinds
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

(local cmp-srcs
  {:buffer :Buffer
   :cmdline :CMD
   :git :Git
   :conjure :Conjure
   :emoji :Emoji
   :nvim_lsp :LSP
   :async_path :Path
   :skkeleton :SKK
   :spell :Spell
   :treesitter :TS})

(local default-sources
  [{:name :nvim_lsp}
   {:name :buffer}
   {:name :treesitter}
   {:name :async_path}
   {:name :skkeleton}
   {:name :spell}
   {:name :emoji}
   {:name :orgmode}])

(cmp.setup
  {:formatting
   {:format (fn [entry item]
              (set item.kind
                   (.. (or (core.get cmp-kinds item.kind) "")
                       " " item.kind))
              (set item.menu (or (core.get cmp-srcs entry.source.name) ""))
              item)}
   :mapping
   {:<C-p> (cmp.mapping
             (cmp.mapping.select_prev_item
               {:behavior cmp.SelectBehavior.Insert})
             [:i :c])
    :<C-n> (cmp.mapping
             (cmp.mapping.select_next_item
               {:behavior cmp.SelectBehavior.Insert})
             [:i :c])
    :<Up> (cmp.mapping (cmp.mapping.scroll_docs -4) [:i :c])
    :<Down> (cmp.mapping (cmp.mapping.scroll_docs 4) [:i :c])
    :<C-s> (cmp.mapping (cmp.mapping.complete) [:i :c])
    :<C-e> (cmp.mapping (cmp.mapping.close) [:i :c])
    :<CR> (cmp.mapping.confirm
            {:behavior cmp.ConfirmBehavior.Replace
             :select true})
    :<Tab> (fn [fallback]
             (if (cmp.visible)
               (cmp.select_next_item)
               (fallback)))}
   :sources default-sources
   :enabled (fn []
              (let [buftype (vim.api.nvim_buf_get_option 0 :buftype)
                    bufname (vim.api.nvim_buf_get_name 0)]
                (and (not (= buftype :prompt))
                     (not (~= (bufname:match "org%-roam%-select$") nil)))))})

;; cmdline completions
(cmp.setup.cmdline :/ {:sources [{:name :buffer}]})
(cmp.setup.cmdline ":" {:sources
                        (cmp.config.sources
                          [{:name :path}]
                          [{:name :cmdline}])})

;; conjure
(fn append-cmp-conjure []
  (let [ss []]
    (each [_ v (ipairs default-sources)]
      (table.insert ss v))
    (table.insert ss {:name :conjure})
    (cmp.setup.buffer
      {:sources ss})))
(augroup!
  init-cmp-conjure
  {:events [:FileType]
   :pattern :clojure
   :callback append-cmp-conjure}
  {:events [:FileType]
   :pattern :fennel
   :callback append-cmp-conjure}
  {:events [:FileType]
   :pattern :hy
   :callback append-cmp-conjure})

;; cmp-git
(fn append-cmp-git []
  (cmp-git.setup {})
  (let [ss []]
    (each [_ v (ipairs default-sources)]
      (table.insert ss v))
    (table.insert ss {:name :git})
    (cmp.setup.buffer
      {:sources ss})))
(augroup!
  init-cmp-git
  {:events [:FileType]
   :pattern :gitcommit
   :callback append-cmp-git})
