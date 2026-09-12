return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "lalitmee/codecompanion-spinners.nvim",
  },
  config = function()
    require("codecompanion").setup({
      -- Opts dictates the internal processing architecture
      opts = {
        stream = true,
      },
      extensions = {
        spinner = {
          enabled = true,
          opts = {
            style = "snacks", -- Seamlessly replaces your manual Snacks.notify autocommands
            content = {
              thinking = { icon = "🤖", message = "Thinking..." },
              receiving = { icon = "📥", message = "Streaming response..." },
            },
          },
        },
      },
      adapters = {
        http = {
          nvidia_native = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "nvidia_native",
              env = {
                url = "https://integrate.api.nvidia.com",
                api_key = os.getenv("NVIDIA_API_KEY"),
              },
              schema = {
                model = {
                  default = "nvidia/nemotron-3.5-lightning-30b-a3b", -- Change to your preferred NVIDIA NIM model
                },
              },
              -- handlers = {
              --   -- Correctly intercept and isolate system messages
              --   form_messages = function(self, messages)
              --     local system_content = {}
              --     local other_messages = {}
              --
              --     -- 1. Separate system messages from everything else
              --     for _, msg in ipairs(messages) do
              --       if msg.role == "system" then
              --         table.insert(system_content, msg.content)
              --       else
              --         table.insert(other_messages, msg)
              --       end
              --     end
              --
              --     -- 2. Merge all system instances into ONE string at the top
              --     local combined_messages = {}
              --     if #system_content > 0 then
              --       table.insert(combined_messages, {
              --         role = "system",
              --         content = table.concat(system_content, "\n\n"),
              --       })
              --     end
              --
              --     -- 3. Append the user/assistant/tool messages right after
              --     for _, msg in ipairs(other_messages) do
              --       table.insert(combined_messages, msg)
              --     end
              --
              --     -- 4. CodeCompanion requires returning the wrapped object
              --     return { messages = combined_messages }
              --   end,
              -- },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "nvidia_native",
        },
        inline = {
          adapter = "nvidia_native",
        },
        cmd = {
          adapter = "nvidia_native",
        },
      },
      schema = {
        num_ctx = {
          default = 16384,
        },
      },
    })
  end,
}
