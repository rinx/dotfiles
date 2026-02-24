#!/usr/bin/env bb

;; print aws sts token
;;
;; to export
;; $ eval $(aws-sts-token --serial-number="<arn>" --otp="<otp-code>")

(require '[babashka.deps :refer [add-deps]])

(add-deps
  '{:deps
    {com.cognitect.aws/endpoints {:mvn/version "1.1.12.504"}
     com.cognitect.aws/sts {:mvn/version "847.2.1387.0"}
     com.grzm/awyeah-api {:git/url "https://github.com/grzm/awyeah-api"
                          :git/sha "9257dc0159640e46803d69210cae838d411f1789"
                          :git/tag "v0.8.41"}
     org.babashka/spec.alpha {:git/url "https://github.com/babashka/spec.alpha"
                              :git/sha "1a841c4cc1d4f6dab7505a98ed2d532dd9d56b78"}}})

(require '[taoensso.timbre :as log])
(require '[com.grzm.awyeah.client.api :as aws])
(require '[babashka.cli :as cli])

;; silence logging
(alter-var-root #'log/*config* assoc :min-level :error)

(def cli-options
  {:serial-number {:require true}
   :otp {:require true
         :coerce :string}})

(defn get-session-token [sts serial-number token-code]
  (let [{:keys [Credentials
                ErrorResponse]} (-> sts
                                    (aws/invoke
                                      {:op :GetSessionToken
                                       :request
                                       {:SerialNumber serial-number
                                        :TokenCode token-code}}))]
    (if Credentials
      Credentials
      (throw
        (Exception. (format "error: %s" ErrorResponse))))))

(def sts
  (aws/client {:api :sts}))

(aws/validate-requests sts true)

(let [{:keys [serial-number otp]} (cli/parse-opts
                                    *command-line-args*
                                    {:spec cli-options})
      {:keys [AccessKeyId
              SecretAccessKey
              SessionToken
              Expiration]} (-> sts
                               (get-session-token serial-number otp))]
  (println (format "export AWS_ACCESS_KEY_ID='%s'" AccessKeyId))
  (println (format "export AWS_SECRET_ACCESS_KEY='%s'" SecretAccessKey))
  (println (format "export AWS_SESSION_TOKEN='%s'" SessionToken))
  (println (format "## expiration: %s" Expiration)))

(comment
 (aws/ops sts)
 (aws/doc sts :GetSessionToken))

;; vim: set ft=clojure:
