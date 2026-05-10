return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          on_init = function(client)
            client.offset_encoding = "utf-8"
          end,
          settings = {
            basedpyright = {
              analysis = {
                extraPaths = { "src" },
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
    },
  },
}
