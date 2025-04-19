(local avante (require :avante))
(local mcphub (require :mcphub))

(local orgmode-server
       (let [get-agenda (fn [date-string]
                          (let [orgmode (require :orgmode)
                                agenda-types (require :orgmode.agenda.types)
                                date (require :orgmode.objects.date)
                                from (if date-string
                                         (date.from_string date-string)
                                         nil)
                                view-opts (vim.tbl_extend :force {} {:files orgmode.agenda.files
                                                                     :agenda_filter orgmode.agenda.filters
                                                                     :highlighter orgmode.agenda.highlighter
                                                                     :span :day
                                                                     :from from})
                                view (agenda-types.agenda:new view-opts)
                                agenda-day (. (view:_get_agenda_days) 1)]
                            (-> (icollect [_ item (ipairs agenda-day.agenda_items)]
                                  (let [entry (view:_build_line item agenda-day)
                                        line (entry:compile)]
                                    line.content))
                                (table.concat "\n"))))]
        {:name :orgmode
         :displayName "Orgmode"
         :capabilities
         {:tools [{:name :get_agenda_on_specific_date
                   :description "Get agenda on a specific date"
                   :inputSchema {:type :object
                                 :properties
                                 {:date
                                  {:type :string
                                   :description "date formatted as '2020-01-03'"}}}
                   :handler (fn [req res]
                               (let [txt (res:text (get-agenda req.params.date))]
                                 (txt:send)))}]
          :resources [{:name :todays_agenda
                       :uri "orgmode://agenda/today"
                       :description "Today's agenda"
                       :handler (fn [req res]
                                  (let [txt (res:text (get-agenda))]
                                    (txt:send)))}]
          :resourceTemplates []}}))

(local orgroam-server
       {:name :orgroam
        :displayName "Org-roam"
        :capabilities
        {:tools []
         :resources [{:name :list_roam_nodes
                      :uri "orgroam://nodes"
                      :description "List all org-roam nodes with its ID, title and aliases. The result should be formatted as JSON."
                      :handler (fn [req res]
                                 (let [roam (require :org-roam)
                                       ids (roam.database:ids)
                                       nodes (icollect [_ id (ipairs ids)]
                                               (let [node (roam.database:get_sync id)]
                                                 {:id id
                                                  :title node.title
                                                  :aliases node.aliases}))]
                                   (let [txt (-> nodes
                                                 (vim.json.encode)
                                                 (res:text))]
                                     (txt:send))))}]
         :resourceTemplates [{:name :get_roam_node_content
                              :uriTemplate "orgroam://nodes/{id}"
                              :description "Get roam node content by specified id. The result should be org-mode formatted text."
                              :handler (fn [req res]
                                         (let [roam (require :org-roam)
                                               node (roam.database:get_sync req.params.id)
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

(avante.setup
  {:provider :copilot
   :behavior
   {:auto_set_keymaps false
    :auto_suggestions false
    :auto_apply_diff_after_generation true}
   :copilot
   {:model :claude-3.7-sonnet}
   :hints
   {:enabled false}
   :file_selector
   {:provider :snacks}
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
