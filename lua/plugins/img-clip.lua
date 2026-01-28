return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      relative_to_current_file = true,
      dir_path = function()
        return vim.fn.expand("%:t:r") .. "-img"
      end,
    },
  },
  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
