(local copilot (require :copilot))
(local command (require :copilot.command))
(local client (require :copilot.client))

(copilot.setup
  {:suggestion {:enabled false}
   :panel {:enabled false}})

;; disable by default
(command.disable)

(let [toggle (Snacks.toggle.new
               {:id :copilot
                :name "Toggle Copilot"
                :get (fn []
                       (not (client.is_disabled)))
                :set (fn [state]
                       (if state
                           (command.enable)
                           (command.disable)))})]
  (toggle:map :<leader>c))
