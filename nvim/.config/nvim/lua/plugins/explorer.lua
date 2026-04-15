-- lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      -- File explorer settings
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                wo = {
                  number = true,
                  relativenumber = true,
                },
                keys = {
                  ["<C-n>"] = "close",
                  ["<BS>"] = "explorer_close",
                },
              },
            },
          },
        },
      },
      -- Lazygit window style
      styles = {
        lazygit = {
          width = 0,
          height = 0,
          border = "none",
        },
      },
    },
  },
}
