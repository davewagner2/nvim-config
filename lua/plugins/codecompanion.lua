return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "https://coder.ak4go.com",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["CF-Access-Client-Id"] = os.getenv("CF_ACCESS_CLIENT_ID"),
                ["CF-Access-Client-Secret"] = os.getenv("CF_ACCESS_CLIENT_SECRET"),
              },
              parameters = {
                sync = true,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
        cmd = {
          adapter = "ollama",
        },
      },
    })
  end,
}
