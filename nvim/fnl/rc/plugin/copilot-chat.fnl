(local chat (require :CopilotChat))

(chat.setup
  {:prompts
   {:Explain
    {:prompt "/COPILOT_EXPLAIN 選択されたコードの説明を段落をつけて書いてください。"}
    :Review
    {:prompt "/COPILOT_REVIEW 選択されたコードをレビューしてください。"}
    :Fix
    {:prompt "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。"}
    :Optimize
    {:prompt "/COPILOT_REFACTOR 選択されたコードを最適化してパフォーマンスと可読性を向上させてください。"}
    :Docs
    {:prompt "/COPILOT_DOCS 選択されたコードに対してドキュメンテーションコメントを追加してください。"}
    :Tests
    {:prompt "/COPILOT_TESTS 選択されたコードの詳細な単体テスト関数を書いてください。"}}})
