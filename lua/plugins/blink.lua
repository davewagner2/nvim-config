return { -- override blink.cmp plugin to keep from autoselecing and gets <TAB> to rotate through options
  "Saghen/blink.cmp",
  opts = {
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

-- option to disable preselect entirely
-- return {
--   {
--     "saghen/blink.cmp",
--     optional = true,
--     opts = {
--       completion = {
--         list = {
--           selection = {
--             preselect = false,
--           },
--         },
--       },
--     },
--   },
-- }
