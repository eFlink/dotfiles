return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_config = {
        vertical = {
          prompt_position = "top",
          mirror = true,
        },
        horizontal = {
          prompt_position = "top",
          mirror = false,
        },
      },
      sorting_strategy = "ascending", -- results flow downward from prompt
    },
  },
}
