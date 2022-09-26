(module rc.plugin.md-prev
  {autoload {core aniseed.core
             nvim aniseed.nvim
             md-prev md-prev}
   require-macros [rc.macros]})

(defn start []
  (let [port 8087]
    (md-prev.start_server port)
    (vim.notify
       (.. "preview started on http://localhost:" port)
       vim.lsp.log_levels.INFO
       {:title :md-prev.nvim})))

(defn stop []
  (md-prev.stop_server)
  (vim.notify
     (.. "preview stopped")
     vim.lsp.log_levels.INFO
     {:title :md-prev.nvim}))

(nvim.ex.command_ :MarkdownPreviewStart (->viml! :start))
(nvim.ex.command_ :MarkdownPreviewStop (->viml! :stop))
