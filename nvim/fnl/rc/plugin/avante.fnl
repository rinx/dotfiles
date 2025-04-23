(local avante (require :avante))
(local mcphub (require :mcphub))

(local orgmode-server
       {:name :orgmode
        :displayName "Orgmode"
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

(local orgroam-server
       {:name :orgroam
        :displayName "Org-roam"
        :capabilities
        {:tools [{:name :semantic_search_roam_nodes
                  :description "Semantic search for org-roam notes. The result should be formatted as JSON. It returns IDs and distances for limited number of notes."
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
                               (orgrc.search_roam_nodes_by_vector
                                 req.params.query
                                 req.params.limit
                                 callback
                                 ecallback)))}]
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
                                           (txt:send)))}]}})

(mcphub.setup
  {:auto_approve false
   :config (vim.fn.expand "~/.nix-profile/config/mcp-servers.json")
   :extensions
   {:avante {:make_slash_commands true}}
   :native_servers
   {:org orgmode-server
    :orgroam orgroam-server}})

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
   :disabled_tools [:bash
                    :create_dir
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
