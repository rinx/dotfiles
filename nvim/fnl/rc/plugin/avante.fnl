(local avante (require :avante))
(local mcphub (require :mcphub))

(local orgmode-server
       {:name :orgmode
        :displayName "Orgmode"
        :capabilities
        {:tools []
         :resources [{:name :todays_agenda
                      :uri "orgmode://agenda/today"
                      :description "Today's agenda"
                      :handler (fn [req res]
                                 (let [orgmode (require :orgmode)
                                       agenda-types (require :orgmode.agenda.types)
                                       view-opts (vim.tbl_extend :force {} {:files orgmode.agenda.files
                                                                            :agenda_filter orgmode.agenda.filters
                                                                            :highlighter orgmode.agenda.highlighter
                                                                            :span :day})
                                       view (agenda-types.agenda:new view-opts)
                                       agenda-day (. (view:_get_agenda_days) 1)
                                       items agenda-day.agenda_items]
                                    (-> (icollect [_ item (ipairs items)]
                                          (let [entry (view:_build_line item agenda-day)
                                                line (entry:compile)]
                                            line.content))
                                        (table.concat "\n")
                                        (res:text))))}]
         :resourceTemplates []}})

(mcphub.setup
  {:auto_approve false
   :config (vim.fn.expand "~/.nix-profile/config/mcp-servers.json")
   :extensions
   {:avante {:make_slash_commands true}}
   :native_servers
   {:org orgmode-server}})

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
