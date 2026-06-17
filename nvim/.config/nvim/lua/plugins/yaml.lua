return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!reset scalar",
                "!reset sequence",
                "!reset mapping",
                "!override scalar",
                "!override sequence",
                "!override mapping",
              },
            },
          },
        },
      },
    },
  },
}
