(local avante (require :avante))
(local mcphub (require :mcphub))

(local org-mode-server
       {:name :org-mode
        :displayName "Org-mode"
        :capabilities
        {:tools [{:name :get_agenda_on_specific_date
                  :description "Get agenda on a specific date"
                  :inputSchema {:type :object
                                :properties
                                {:year
                                 {:type :number
                                  :description :Year}
                                 :month
                                 {:type :number
                                  :description :Month}
                                 :day
                                 {:type :number
                                  :description :Day}}
                                :required [:year :month :day]}
                  :handler (fn [req res]
                              (let [orgrc (require :rc.plugin.orgmode)
                                    txt (-> (orgrc.get_agenda
                                              :day
                                              req.params.year
                                              req.params.month
                                              req.params.day)
                                            (vim.json.encode)
                                            (res:text))]
                                (txt:send)))}
                 {:name :get_agendas_on_specific_month
                  :description "Get agendas on a specific month"
                  :inputSchema {:type :object
                                :properties
                                {:year
                                 {:type :number
                                  :description :Year}
                                 :month
                                 {:type :number
                                  :description :Month}}
                                :required [:year :month]}
                  :handler (fn [req res]
                             (let [orgrc (require :rc.plugin.orgmode)
                                   txt (-> (orgrc.get_agenda
                                             :month
                                             req.params.year
                                             req.params.month
                                             1)
                                           (vim.json.encode)
                                           (res:text))]
                               (txt:send)))}]
         :resources [{:name :todays_agenda
                      :uri "orgmode://agenda/today"
                      :description "Today's agenda"
                      :handler (fn [req res]
                                 (let [orgrc (require :rc.plugin.orgmode)
                                       txt (-> (orgrc.get_agenda :day)
                                               (vim.json.encode)
                                               (res:text))]
                                   (txt:send)))}
                     {:name :agendas_on_this_week
                      :uri "orgmode://agenda/this-week"
                      :description "Agendas on this week"
                      :handler (fn [req res]
                                 (let [orgrc (require :rc.plugin.orgmode)
                                       txt (-> (orgrc.get_agenda :week)
                                               (vim.json.encode)
                                               (res:text))]
                                   (txt:send)))}]
         :resourceTemplates []}})

(local org-roam-server
       {:name :org-roam
        :displayName "Org-roam"
        :capabilities
        {:tools [{:name :search_roam_node_headings
                  :description "Search for org-roam note headings. This search function is hybrid of vector similarity search and full-text search. The result should be formatted as JSON. It returns node ID, category, content and score for limited number of results."
                  :inputSchema {:type :object
                                :properties
                                {:query
                                 {:type :string
                                  :description "Query string used for semantic search"}
                                 :limit
                                 {:type :number
                                  :description "The number of top-k result"}}
                                :required [:query :limit]}
                  :handler (fn [req res]
                             (let [orgrc (require :rc.plugin.orgmode)
                                   callback (fn [result]
                                              (let [txt (res:text result)]
                                                (txt:send)))
                                   ecallback (fn [e]
                                               (let [err (res:error e)]
                                                 (err:send)))]
                               (orgrc.query_roam_headings
                                 req.params.query
                                 req.params.limit
                                 callback
                                 ecallback)))}
                 {:name :search_roam_node_fragments
                  :description "Search for org-roam note fragments. This search function is hybrid of vector similarity search and full-text search. The result should be formatted as JSON. It returns node ID, category, content and score for limited number of results."
                  :inputSchema {:type :object
                                :properties
                                {:query
                                 {:type :string
                                  :description "Query string used for semantic search"}
                                 :limit
                                 {:type :number
                                  :description "The number of top-k result"}}
                                :required [:query :limit]}
                  :handler (fn [req res]
                             (let [orgrc (require :rc.plugin.orgmode)
                                   callback (fn [result]
                                              (let [txt (res:text result)]
                                                (txt:send)))
                                   ecallback (fn [e]
                                               (let [err (res:error e)]
                                                 (err:send)))]
                               (orgrc.query_roam_fragments
                                 req.params.query
                                 req.params.limit
                                 callback
                                 ecallback)))}
                 {:name :create_roam_node
                  :description "Create a new org-roam note. The result should be roam node ID."
                  :inputSchema {:type :object
                                :properties
                                {:title
                                 {:type :string
                                  :description "Title of the newly created note"}
                                 :body
                                 {:type :string
                                  :description "Body of the newly created note. It should be formatted as org-mode style."}}
                                :required [:title :body]}
                  :handler (fn [req res]
                             (let [orgrc (require :rc.plugin.orgmode)
                                   body (.. "#+AUTHOR: avante.nvim\n\n"
                                            req.params.body)
                                   callback (fn [id]
                                              (let [txt (res:text id)]
                                                (txt:send)))]
                               (orgrc.create_roam_node
                                 req.params.title body callback)))}
                 {:name :open_roam_node
                  :description "Open specified org-roam note as a neovim buffer."
                  :inputSchema {:type :object
                                :properties
                                {:id
                                 {:type :string
                                  :description "node ID"}}
                                :required [:id]}
                  :handler (fn [req res]
                             (let [orgrc (require :rc.plugin.orgmode)
                                   node (orgrc.get_roam_node_by_id req.params.id)]

                               (if (vim.uv.fs_stat node.file)
                                 (do
                                   (vim.cmd.badd node.file)
                                   (let [txt (res:text "opened")]
                                     (txt:send)))
                                 (let [txt (res:error "not found")]
                                   (txt:send)))))}
                 {:name :get_roam_heading_content
                  :description "Get roam note heading content by specified id and heading title. The result should be a JSON formatted list of found objects. The object is composed by node metadata, file path, heading title, heading level, content lines, children headings and position."
                  :inputSchema {:type :object
                                :properties
                                {:id
                                 {:type :string
                                  :description "node ID"}
                                 :title
                                 {:type :string
                                  :description "title of the heading"}}
                                :required [:id :title]}
                  :handler (fn [req res]
                             (let [orgrc (require :rc.plugin.orgmode)
                                   txt (-> (orgrc.get_roam_heading_content req.params.id req.params.title)
                                           (vim.json.encode)
                                           (res:text))]
                               (txt:send)))}]
         :resources [{:name :list_roam_nodes
                      :uri "orgroam://nodes"
                      :description "List all org-roam notes with its ID, title and aliases. The result should be formatted as JSON."
                      :handler (fn [req res]
                                 (let [orgrc (require :rc.plugin.orgmode)
                                       nodes (orgrc.get_all_roam_nodes)]
                                   (let [txt (-> nodes
                                                 (vim.json.encode)
                                                 (res:text))]
                                     (txt:send))))}]
         :resourceTemplates [{:name :get_roam_node_content
                              :uriTemplate "orgroam://nodes/{id}"
                              :description "Get roam note content by specified id. The result should be org-mode formatted text."
                              :handler (fn [req res]
                                         (let [orgrc (require :rc.plugin.orgmode)
                                               node (orgrc.get_roam_node_by_id req.params.id)
                                               txt (-> node.file
                                                       (vim.fn.readfile)
                                                       (vim.fn.join "\n")
                                                       (res:text))]
                                           (txt:send)))}
                             {:name :get_roam_node_links
                              :uriTemplate "orgroam://nodes/{id}/links"
                              :description "Get roam note links. The result should be formatted as JSON. Key-value pairs of node id and distance."
                              :handler (fn [req res]
                                         (let [orgrc (require :rc.plugin.orgmode)
                                               links (orgrc.get_roam_node_links req.params.id)
                                               txt (-> links
                                                       (vim.json.encode)
                                                       (res:text))]
                                           (txt:send)))}
                             {:name :get_roam_node_backlinks
                              :uriTemplate "orgroam://nodes/{id}/backlinks"
                              :description "Get roam note backlinks. The result should be formatted as JSON. Key-value pairs of node id and distance."
                              :handler (fn [req res]
                                         (let [orgrc (require :rc.plugin.orgmode)
                                               backlinks (orgrc.get_roam_node_backlinks req.params.id)
                                               txt (-> backlinks
                                                       (vim.json.encode)
                                                       (res:text))]
                                           (txt:send)))}]}})

(avante.setup
  {:provider :copilot
   :behavior
   {:auto_set_keymaps false
    :auto_suggestions false
    :auto_apply_diff_after_generation true}
   :copilot
   {:model :claude-3.7-sonnet}
   :vendors
   {:copilot-gemini-2.5-pro
    {:__inherited_from :copilot
     :model :gemini-2.5-pro}
    :copilot-gpt-4.1
    {:__inherited_from :copilot
     :model :gpt-4.1}
    :copilot-gpt-4o
    {:__inherited_from :copilot
     :model :gpt-4o}}
   :hints
   {:enabled false}
   :file_selector
   {:provider :snacks}
   :mappings
   {:ask :<leader>Aa
    :edit :<leader>Ae
    :refresh :<leader>Ar
    :focus :<leader>Af
    :stop :<leader>AS
    :toggle
    {:default :<leader>At
     :debug :<leader>Ad
     :hint :<leader>Ah
     :suggestion :<leader>As
     :repomap :<leader>AR}
    :files
    {:add_current :<leader>Ac
     :add_all_buffers :<leader>AB}
    :select_model :<leader>A?
    :select_history :<leader>AH}
   :system_prompt (fn []
                     (let [hub (mcphub.get_hub_instance)]
                       (hub:get_active_servers_prompt)))
   :custom_tools (fn []
                   (let [ext (require :mcphub.extensions.avante)]
                     [(ext.mcp_tool)]))
   :disabled_tools [:create_dir
                    :create_file
                    :delete_dir
                    :delete_file
                    :list_files
                    :python
                    :rag_search
                    :read_file
                    :rename_dir
                    :rename_file
                    :search_files
                    :web_search]})

(mcphub.setup
  {:auto_approve false
   :auto_toggle_mcp_servers true
   :config (vim.fn.expand "~/.nix-profile/config/mcp-servers.json")
   :extensions
   {:avante
    {:enabled true
     :make_slash_commands true}}
   :native_servers
   {:org-mode org-mode-server
    :org-roam org-roam-server}})

;; add mcphub_auto_approve
(let [toggle (Snacks.toggle.new
               {:id :mcphub_auto_approve
                :name "MCPHub auto_approve"
                :get (fn []
                       (= vim.g.mcphub_auto_approve true))
                :set (fn [state]
                       (if state
                           (set vim.g.mcphub_auto_approve true)
                           (set vim.g.mcphub_auto_approve false)))})]
  (toggle:map :<leader>AA))
