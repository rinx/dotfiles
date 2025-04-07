(local avante (require :avante))
(local mcphub (require :mcphub))

(mcphub.setup
  {:config (vim.fn.expand "~/.nix-profile/config/mcp-servers.json")
   :extensions
   {:avante {}}})

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
                     (ext.mcp_tool)))
   :disabled_tools [:list_files
                    :search_files
                    :read_file
                    :create_file
                    :rename_file
                    :delete_file
                    :create_dir
                    :rename_dir
                    :delete_dir
                    :bash]})
