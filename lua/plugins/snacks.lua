return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
      image = {
        enabled = true,
        doc = {
          -- Personally I set this to false, I don't want to render all the
          -- images in the file, only when I hover over them
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          inline = vim.g.neovim_mode == "skitty" and true or false,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          -- Sets the size of the image
          max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
          max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
          -- max_width = 60,
          -- max_height = 30,
          -- Apparently, all the images that you preview in neovim are converted
          -- to .png and they're cached, original image remains the same, but
          -- the preview you see is a png converted version of that image
          --
          -- Where are the cached images stored?
          -- This path is found in the docs
          -- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
          -- For me returns `~/.cache/neobean/snacks/image`
          -- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
