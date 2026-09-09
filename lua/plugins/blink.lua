return { -- override blink.cmp plugin to keep from autoselecing and gets <TAB> to rotate through options
  "Saghen/blink.cmp",
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
    keymap = {
      ["<Tab>"] = { "select_next", "fallback" },
    },
  },
}
