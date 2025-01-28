-- https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/copilot-chat-v2.lua

-- COPILOT_INSTRUCTIONS
-- COPILOT_WORKSPACE
-- SHOW_CONTEXT

local prompts = {
  Explain = "/COPILOT_EXPLAIN 次のコードがどのように動作するか説明してください。",
  Review = "/COPILOT_REVIEW 次のコードをレビューして、改善の提案をしてください。",
  Tests = "/COPILOT_GENERATE 選択されたコードがどのように動作するか説明した後、単体テストを生成してください。",
  Refactor = "/COPILOT_GENERATE 次のコードをリファクタリングして、可読性と明確さを向上させてください。",
  FixCode = "/COPILOT_GENERATE 次のコードを修正して、意図通りに動作するようにしてください。",
  FixError = "次のテキスト内のエラーを説明し、解決策を提示してください。",
  BetterNamings = "次の変数や関数に対して、より良い名前を提案してください。",
  Documentation = "/COPILOT_GENERATE 次のコードのドキュメントを作成してください。",
  SwaggerApiDocs = "/COPILOT_GENERATE 次のAPIに対してSwaggerを使用してドキュメントを作成してください。",
  SwaggerJsDocs = "/COPILOT_GENERATE Swaggerを使用して次のAPIに対してJSDocを書いてください。",

  -- テキスト関連のプロンプト
  Summarize = "次のテキストを要約してください。",
  Spelling = "次のテキストの文法やスペルの誤りを修正してください。",
  Wording = "次のテキストの文法や表現を改善してください。",
  Concise = "次のテキストをより簡潔に書き直してください。",
  Docs = "次のコードやテキストに対してドキュメントを作成してください。",
  Fix = "/COPILOT_GENERATE バグが含まれている具体的なコードスニペットを提供してください。それによって、コンテキストを理解し、適切な修正を提供できます。",
  Optimize = "/COPILOT_GENERATE 選択されたコードを最適化し、パフォーマンスと可読性を向上させてください。",

  FixDiagnostic = {
    prompt = "次のファイルにおける診断問題を手助けしてください:",
    -- selection = select.diagnostics,
  },
  Commit = {
    prompt = "コミットメッセージをcommitizen規約に従って作成してください。タイトルは最大50文字で、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
    -- selection = select.gitdiff,
  },
  CommitStaged = {
    prompt = "コミットメッセージをcommitizen規約に従って作成してください。タイトルは最大50文字で、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
    -- selection = function(source)
    --   return select.gitdiff(source, true)
    -- end,
  },
}

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      prompts = prompts,
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
