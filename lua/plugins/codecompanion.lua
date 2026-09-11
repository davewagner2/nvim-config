return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      -- Opts dictates the internal processing architecture
      opts = {
        stream = true,
      },
      adapters = {
        http = {
          llama_native = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "llama_native",
              env = {
                url = "https://coder.ak4go.com",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["CF-Access-Client-Id"] = os.getenv("CF_ACCESS_CLIENT_ID"),
                ["CF-Access-Client-Secret"] = os.getenv("CF_ACCESS_CLIENT_SECRET"),
              },
              handlers = {
                -- Correctly intercept and isolate system messages
                form_messages = function(self, messages)
                  local system_content = {}
                  local other_messages = {}

                  -- 1. Separate system messages from everything else
                  for _, msg in ipairs(messages) do
                    if msg.role == "system" then
                      table.insert(system_content, msg.content)
                    else
                      table.insert(other_messages, msg)
                    end
                  end

                  -- 2. Merge all system instances into ONE string at the top
                  local combined_messages = {}
                  if #system_content > 0 then
                    table.insert(combined_messages, {
                      role = "system",
                      content = table.concat(system_content, "\n\n"),
                    })
                  end

                  -- 3. Append the user/assistant/tool messages right after
                  for _, msg in ipairs(other_messages) do
                    table.insert(combined_messages, msg)
                  end

                  -- 4. CodeCompanion requires returning the wrapped object
                  return { messages = combined_messages }
                end,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "llama_native",
        },
        inline = {
          adapter = "llama_native",
        },
        cmd = {
          adapter = "llama_native",
        },
      },
      schema = {
        num_ctx = {
          default = 16384,
        },
      },
    })

    -- The autocommand hooks are now safely contained inside the config function:
    local group = vim.api.nvim_create_augroup("CodeCompanionStatusHooks", { clear = true })
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(ev)
        local msg
        if ev.match == "CodeCompanionRequestStarted" then
          msg = "CodeCompanion thinking..."
        elseif ev.match == "CodeCompanionRequestStreaming" then
          msg = "Streaming response..."
        elseif ev.match == "CodeCompanionRequestFinished" then
          msg = "Finished!"
        end

        if msg then
          Snacks.notify(msg, {
            level = "info",
            id = "code_companion_status",
            title = "CodeCompanion",
          })
        end
      end,
    })
  end,
}
